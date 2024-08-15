/datum/ammo/bullet/pistol
	name = "pistol bullet"
	hud_state = "pistol"
	hud_state_empty = "pistol_empty"
	flags_ammo_behavior = AMMO_BALLISTIC
	damage = 20
	penetration = 5
	accurate_range = 5
	sundering = 1

/datum/ammo/bullet/pistol/tiny
	name = "light pistol bullet"
	hud_state = "pistol_light"
	damage = 15
	penetration = 5
	sundering = 0.5

/datum/ammo/bullet/pistol/tiny/ap
	name = "light pistol bullet"
	hud_state = "pistol_lightap"
	damage = 22.5
	penetration = 15 //So it can actually hurt something.
	sundering = 0.5
	damage_falloff = 1.5

/datum/ammo/bullet/pistol/tranq
	name = "tranq bullet"
	hud_state = "pistol_tranq"
	damage = 25
	damage_type = STAMINA

/datum/ammo/bullet/pistol/tranq/on_hit_mob(mob/victim, obj/projectile/proj)
	if(iscarbon(victim))
		var/mob/living/carbon/carbon_victim = victim
		carbon_victim.reagents.add_reagent(/datum/reagent/toxin/potassium_chlorophoride, 1)

/datum/ammo/bullet/pistol/hollow
	name = "hollowpoint pistol bullet"
	hud_state = "pistol_hollow"
	accuracy = -10
	shrapnel_chance = 45
	sundering = 2

/datum/ammo/bullet/pistol/hollow/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 2 SECONDS, slowdown = 0.5, knockback = 1)

/datum/ammo/bullet/pistol/ap
	name = "armor-piercing pistol bullet"
	hud_state = "pistol_ap"
	damage = 15
	penetration = 12.5
	shrapnel_chance = 15
	additional_xeno_penetration = 12.5

/datum/ammo/bullet/pistol/hp
	name = "hollow-point pistol bullet"
	hud_state = "pistol_hollow"
	damage = 37.5
	penetration = 0
	additional_xeno_penetration = -15

/datum/ammo/bullet/pistol/sabot
	name = "APDS pistol bullet"
	hud_state = "pistol_ap"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_TURF
	damage = 15
	penetration = 5
	sundering = 0.5

/datum/ammo/bullet/pistol/heavy
	name = "heavy pistol bullet"
	hud_state = "pistol_heavy"
	damage = 30
	penetration = 5
	shrapnel_chance = 25
	sundering = 2.15

/datum/ammo/bullet/pistol/superheavy
	name = "high impact pistol bullet"
	hud_state = "pistol_superheavy"
	damage = 45
	penetration = 15
	sundering = 3
	damage_falloff = 0.75

/datum/ammo/bullet/pistol/superheavy/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 0.5 SECONDS, slowdown = 0.5, knockback = 1)

/datum/ammo/bullet/pistol/superheavy/derringer
	handful_amount = 2
	handful_icon_state = "derringer"

/datum/ammo/bullet/pistol/superheavy/derringer/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, slowdown = 0.5)

/datum/ammo/bullet/pistol/incendiary
	name = "incendiary pistol bullet"
	hud_state = "pistol_fire"
	damage_type = BURN
	shrapnel_chance = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_INCENDIARY
	damage = 20

/datum/ammo/bullet/pistol/squash
	name = "squash-head pistol bullet"
	hud_state = "pistol_squash"
	accuracy = 5
	damage = 32
	penetration = 10
	shrapnel_chance = 25
	sundering = 2

/datum/ammo/bullet/pistol/mankey
	name = "live monkey"
	icon_state = "monkey1"
	hud_state = "monkey"
	hud_state_empty = "monkey_empty"
	ping = null //no bounce off.
	damage_type = BURN
	flags_ammo_behavior = AMMO_INCENDIARY|AMMO_IGNORE_ARMOR
	shell_speed = 2
	damage = 15

/datum/ammo/bullet/pistol/mankey/on_hit_mob(mob/M, obj/projectile/P)
	if(!M.stat && !ismonkey(M))
		P.visible_message(span_danger("The [src] chimpers furiously!"))
		new /mob/living/carbon/human/species/monkey(P.loc)
