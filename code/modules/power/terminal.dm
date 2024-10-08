// the underfloor wiring terminal for the APC
// autogenerated when an APC is placed
// all conduit connects go to this object instead of the APC
// using this solves the problem of having the APC in a wall yet also inside an area

/obj/machinery/power/terminal
	name = "terminal"
	icon_state = "term"
	desc = "It's an underfloor wiring terminal for power equipment."
	level = 1
	anchored = TRUE
	layer = WIRE_TERMINAL_LAYER
	resistance_flags = UNACIDABLE
	var/obj/machinery/power/master = null


// Needed so terminals are not removed from machines list.
// Powernet rebuilds need this to work properly.
/obj/machinery/power/terminal/process()
	return TRUE

/obj/machinery/power/terminal/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, use_alpha = TRUE)

/obj/machinery/power/terminal/Destroy()
	if(master)
		master.disconnect_terminal()
		master = null
	return ..()

/obj/machinery/power/terminal/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return FALSE
	if(prob(severity * 0.3))
		Destroy()

/obj/machinery/power/terminal/should_have_node()
	return TRUE

/obj/machinery/power/proc/can_terminal_dismantle()
	. = FALSE


/obj/machinery/power/apc/can_terminal_dismantle()
	. = FALSE
	if(opened)
		. = TRUE


/obj/machinery/power/terminal/deconstruct(mob/living/user)
	var/turf/T = get_turf(src)
	if(T.intact_tile)
		to_chat(user, span_warning("You must first expose the power terminal!"))
		return FALSE

	if(master && !master.can_terminal_dismantle())
		return FALSE

	user.visible_message(span_notice("[user] starts removing [master]'s wiring and terminal."),
		span_notice("You start removing [master]'s wiring and terminal."))

	playsound(loc, 'sound/items/deconstruct.ogg', 50, 1)
	if(!do_after(user, 50, NONE, src, BUSY_ICON_BUILD))
		return FALSE

	if(master && !master.can_terminal_dismantle())
		return FALSE

	if(prob(50) && electrocute_mob(user, powernet, src, 1, TRUE))
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		return FALSE

	new /obj/item/stack/cable_coil(get_turf(src), 10)
	user.visible_message(span_notice("[user] removes [src]'s wiring and terminal."),
			span_notice("You remove [src]'s wiring and terminal."))

	. = TRUE

	return ..()
