
/mob/living/Login()
	. = ..()
	//Mind updates
	mind_initialize()	//updates the mind (or creates and initializes one if one doesn't exist)
	mind.active = 1		//indicates that the mind is currently synced with a client

	INVOKE_ASYNC(SSdiscord, TYPE_PROC_REF(/datum/controller/subsystem/discord, get_boosty_tier), ckey)

	var/turf/T = get_turf(src)
	if (isturf(T))
		update_z(T.z)

	if(length(pipes_shown)) //ventcrawling, need to reapply pipe vision
		var/obj/machinery/atmospherics/A = loc
		if(istype(A)) //a sanity check just to be safe
			remove_ventcrawl()
			add_ventcrawl(A)
	LAZYREMOVE(GLOB.ssd_living_mobs, src)
	set_afk_status(MOB_CONNECTED)
