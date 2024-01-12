/obj/item/assembly/infra
	name = "infrared emitter"
	desc = "Emits a visible or invisible beam and is triggered when the beam is interrupted."
	icon_state = "infrared"
	is_position_sensitive = TRUE

	var/on = FALSE
	var/visible = FALSE
	var/maxlength = 8
	var/list/obj/effect/beam/i_beam/beams
	var/olddir = 0
	var/turf/listeningTo
	var/hearing_range = 3

/obj/item/assembly/infra/Initialize(mapload)
	. = ..()
	beams = list()
	START_PROCESSING(SSobj, src)
	AddComponent(\
		/datum/component/simple_rotation,\
		ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_FLIP | ROTATION_VERBS,\
		null,\
		null,\
		CALLBACK(src,PROC_REF(after_rotation))\
		)

/obj/item/assembly/infra/proc/after_rotation()
	refreshBeam()

/obj/item/assembly/infra/Destroy()
	STOP_PROCESSING(SSobj, src)
	listeningTo = null
	QDEL_LIST(beams)
	return ..()

/obj/item/assembly/infra/examine(mob/user)
	. = ..()
	. += span_notice("The infrared trigger is [on?"on":"off"].")

/obj/item/assembly/infra/activate()
	. = ..()
	if(!.)
		return FALSE//Cooldown check
	on = !on
	refreshBeam()
	update_icon()
	return TRUE

/obj/item/assembly/infra/toggle_secure()
	secured = !secured
	if(secured)
		START_PROCESSING(SSobj, src)
		refreshBeam()
	else
		QDEL_LIST(beams)
		STOP_PROCESSING(SSobj, src)
	update_icon()
	return secured

/obj/item/assembly/infra/update_overlays()
	. = ..()
	attached_overlays = list()
	if(on)
		. += "infrared_on"
		attached_overlays += "infrared_on"
		if(visible && secured)
			. += "infrared_visible"
			attached_overlays += "infrared_visible"

/obj/item/assembly/infra/update_icon()
	. = ..()
	if(holder)
		holder.update_icon()

/obj/item/assembly/infra/dropped()
	. = ..()
	if(holder)
		holder_movement() //sync the dir of the device as well if it's contained in a TTV or an assembly holder
	else
		refreshBeam()

/obj/item/assembly/infra/process()
	if(!on || !secured)
		refreshBeam()
		return

/obj/item/assembly/infra/proc/refreshBeam()
	QDEL_LIST(beams)
	if(throwing || !on || !secured)
		return
	if(holder)
		if(holder.master) //incase the sensor is part of an assembly that's contained in another item, such as a single tank bomb
			if(!holder.master.IsSpecialAssembly() || !isturf(holder.master.loc))
				return
		else if(!isturf(holder.loc)) //else just check where the holder is
			return
	else if(!isturf(loc)) //or just where the fuck we are in general
		return
	var/turf/T = get_turf(src)
	var/_dir = dir
	var/turf/_T = get_step(T, _dir)
	if(_T)
		for(var/i in 1 to maxlength)
			var/obj/effect/beam/i_beam/I = new(T)
			if(istype(holder, /obj/item/assembly_holder))
				var/obj/item/assembly_holder/assembly_holder = holder
				I.icon_state = "[initial(I.icon_state)]_[(assembly_holder.a_left == src) ? "l":"r"]" //Sync the offset of the beam with the position of the sensor.
			else if(istype(holder, /obj/item/transfer_valve))
				I.icon_state = "[initial(I.icon_state)]_ttv"
			I.density = TRUE
			if(!I.Move(_T))
				qdel(I)
				switchListener(_T)
				break
			I.density = FALSE
			beams += I
			I.master = src
			I.setDir(_dir)
			I.invisibility = visible? 0 : INVISIBILITY_ABSTRACT
			T = _T
			_T = get_step(_T, _dir)
			CHECK_TICK

/obj/item/assembly/infra/on_detach()
	. = ..()
	if(!.)
		return
	refreshBeam()

/obj/item/assembly/infra/attack_hand(mob/living/user)
	. = ..()
	refreshBeam()

/obj/item/assembly/infra/Moved()
	var/t = dir
	. = ..()
	setDir(t)

/obj/item/assembly/infra/throw_at(atom/target, range, speed, thrower, spin, flying = FALSE, targetted_throw = TRUE)
	. = ..()
	olddir = dir

/obj/item/assembly/infra/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	if(!olddir)
		return
	setDir(olddir)
	olddir = null

/obj/item/assembly/infra/proc/trigger_beam(atom/movable/AM, turf/location)
	refreshBeam()
	switchListener(location)
	if(!secured || !on || next_activate > world.time)
		return FALSE
	pulse(FALSE)
	audible_message("[icon2html(src, hearers(src))] *beep* *beep* *beep*", null, hearing_range)
	for(var/CHM in get_hearers_in_view(hearing_range, src))
		if(ismob(CHM))
			var/mob/LM = CHM
			LM.playsound_local(get_turf(src), 'sound/machines/triple_beep.ogg', ASSEMBLY_BEEP_VOLUME, TRUE)
	next_activate = world.time + 30

/obj/item/assembly/infra/proc/switchListener(turf/newloc)
	if(listeningTo == newloc)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_ATOM_EXITED)
	RegisterSignal(newloc, COMSIG_ATOM_EXITED, PROC_REF(check_exit))
	listeningTo = newloc

/obj/item/assembly/infra/proc/check_exit(datum/source, atom/movable/offender, direction)
	SIGNAL_HANDLER_DOES_SLEEP
	if(QDELETED(src))
		return
	if(offender == src || istype(offender,/obj/effect/beam/i_beam))
		return
	if(offender && isitem(offender))
		var/obj/item/I = offender
		if(I.flags_item & ITEM_ABSTRACT)
			return
	return refreshBeam()

/obj/item/assembly/infra/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(!is_secured(user))
		return FALSE

	return TRUE

/obj/item/assembly/infra/interact(mob/user)
	. = ..()
	if(.)
		return

	var/dat
	dat += "<BR><B>Status</B>: [on ? "<A href='?src=[REF(src)];state=0'>On</A>" : "<A href='?src=[REF(src)];state=1'>Off</A>"]"
	dat += "<BR><B>Visibility</B>: [visible ? "<A href='?src=[REF(src)];visible=0'>Visible</A>" : "<A href='?src=[REF(src)];visible=1'>Invisible</A>"]"
	dat += "<BR><BR><A href='?src=[REF(src)];refresh=1'>Refresh</A>"

	var/datum/browser/popup = new(user, "infra", name)
	popup.set_content(dat)
	popup.open()

/obj/item/assembly/infra/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["state"])
		on = !(on)
		update_icon()
		refreshBeam()

	if(href_list["visible"])
		visible = !(visible)
		update_icon()
		refreshBeam()

	updateUsrDialog()

/obj/item/assembly/infra/setDir()
	. = ..()
	refreshBeam()

/***************************IBeam*********************************/
/obj/effect/beam/i_beam
	name = "infrared beam"
	icon = 'icons/obj/items/projectiles.dmi'
	icon_state = "ibeam"
	var/obj/item/assembly/infra/master
	anchored = TRUE
	density = FALSE
	allow_pass_flags = PASS_LOW_STRUCTURE|PASS_GLASS|PASS_GRILLE

/obj/effect/beam/i_beam/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)

/obj/effect/beam/i_beam/proc/on_cross(datum/source, atom/movable/AM, oldloc, oldlocs)
	if(istype(AM, /obj/effect/beam))
		return
	if(isitem(AM))
		var/obj/item/I = AM
		if(I.flags_item & ITEM_ABSTRACT)
			return
	master.trigger_beam(AM, get_turf(src))
