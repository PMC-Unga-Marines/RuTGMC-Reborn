/mob/living/carbon/xenomorph/king
	caste_base_type = /datum/xeno_caste/king
	name = "King"
	desc = "A primordial creature, evolved to smash the hardiest of defences and hunt the hardiest of prey."
	icon = 'icons/Xeno/castes/king.dmi'
	icon_state = "King Walking"
	attacktext = "bites"
	attack_sound = null
	friendly = "nuzzles"
	health = 500
	maxHealth = 500
	plasma_stored = 300
	pixel_x = -16
	old_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6
	tier = XENO_TIER_FOUR //King, like queen, doesn't count towards population limit.
	upgrade = XENO_UPGRADE_NORMAL
	bubble_icon = "alienroyal"
	footstep_type = FOOTSTEP_XENO_STOMPY
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/hijack,
	)

/mob/living/carbon/xenomorph/king/Initialize(mapload)
	. = ..()
	playsound(loc, 'sound/voice/alien/xenos_roaring.ogg', 75, 0)

/mob/living/carbon/xenomorph/king/generate_name()
	var/playtime_mins = client?.get_exp(xeno_caste.caste_name)
	var/prefix = (hive.prefix || xeno_caste.upgrade_name) ? "[hive.prefix][xeno_caste.upgrade_name] " : ""
	switch(playtime_mins)
		if(0 to 300)
			name = prefix + "Young King ([nicknumber])"
		if(301 to 1500)
			name = prefix + "Mature King ([nicknumber])"
		if(1501 to 4200)
			name = prefix + "Elder Emperor ([nicknumber])"
		if(4201 to 9000)
			name = prefix + "Ancient Emperor ([nicknumber])"
		if(9001 to INFINITY)
			name = prefix + "Prime Emperor ([nicknumber])"
		else
			name = prefix + "Young King ([nicknumber])"

	real_name = name
	if(mind)
		mind.name = name

/mob/living/carbon/xenomorph/king/death_cry()
	playsound(loc, 'sound/voice/alien/king_died.ogg', 75, 0)
