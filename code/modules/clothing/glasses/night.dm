/obj/item/clothing/glasses/night
	name = "night vision goggles"
	desc = "You can totally see in the dark now!"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	icon_state = "night"
	item_state = "glasses"
	darkness_view = 7
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE

/obj/item/clothing/glasses/night/tx8
	name = "\improper BR-8 battle sight"
	desc = "A headset and night vision goggles system for the BR-8 Battle Rifle. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS
	darkness_view = 12
	toggleable = TRUE

/obj/item/clothing/glasses/night/m42_night_goggles
	name = "\improper M42 scout sight"
	desc = "A headset and night vision goggles system for the M42 Scout Rifle. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS
	darkness_view = 24
	toggleable = TRUE

/obj/item/clothing/glasses/night/m42_night_goggles/upp
	name = "\improper Type 9 elite goggles"
	desc = "A headset and night vision goggles system used by USL forces. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "upp_goggles"
	deactive_state = "upp_goggles_0"

/obj/item/clothing/glasses/night/sectoid
	name = "alien lens"
	desc = "A thick, black coating over an alien's eyes, allowing them to see in the dark."
	icon_state = "alien_lens"
	item_state = "alien_lens"
	darkness_view = 7
	lighting_alpha = LIGHTING_PLANE_ALPHA_INVISIBLE
	flags_item = DELONDROP

/obj/item/clothing/glasses/night/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper KTLD head mounted sight"
	desc = "A headset and goggles system made to pair with any KTLD weapon, such as the SG type weapons. Has a low-res short range imager, allowing for view of terrain."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	darkness_view = 5
	toggleable = TRUE
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/night/sunglasses
	name = "\improper KTLD sunglasses"
	desc = "A pair of designer sunglasses. This pair has been fitted with a KTLD head mounted sight."
	icon_state = "m56sunglasses"
	item_state = "m56sunglasses"
	deactive_state = "deactived_sunglasses"
	darkness_view = 5
	toggleable = TRUE
	vision_flags = SEE_TURFS
	prescription = TRUE

/obj/item/clothing/glasses/night/optgoggles
	name = "\improper Optical imager ballistic goggles"
	desc = "Standard issue TGMC goggles. This pair has been fitted with an internal optical imaging scanner."
	icon_state = "optgoggles"
	item_state = "optgoggles"
	deactive_state = "deactived_mgoggles"
	darkness_view = 0
	toggleable = TRUE
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 15, BOMB = 35, BIO = 10, FIRE = 30, ACID = 30)
	goggles_layer = TRUE

/obj/item/clothing/glasses/night/optgoggles/prescription
	name = "\improper Optical imager prescription ballistic goggles"
	desc = "Standard issue TGMC prescription goggles. This pair has been fitted with an internal optical imaging scanner."
	prescription = TRUE

/obj/item/clothing/glasses/night/imager_goggles
	name = "optical imager goggles"
	desc = "Uses image scanning to increase visibility of even the most dimly lit surroundings except total darkness"
	icon_state = "securityhud"
	deactive_state = "deactived_goggles"
	darkness_view = 0
	toggleable = TRUE

/obj/item/clothing/glasses/night/imager_goggles/sunglasses
	name = "\improper Optical imager sunglasses"
	desc = "A pair of designer sunglasses. This pair has been fitted with an internal optical imager scanner."
	icon_state = "optsunglasses"
	item_state = "optsunglasses"
	deactive_state = "deactived_sunglasses"
	sprite_sheets = list("Combat Robot" = 'icons/mob/species/robot/glasses.dmi')

/obj/item/clothing/glasses/night/imager_goggles/eyepatch
	name = "\improper Meson eyepatch"
	desc = "An eyepatch fitted with the optical imager interface. For the disabled and/or edgy Marine."
	icon_state = "optpatch"
	deactive_state = "deactived_patch"

/obj/item/clothing/glasses/night/yautja
	name = "bio-mask nightvision"
	desc = "A vision overlay generated by the Bio-Mask. Used for low-light conditions."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "visor_nvg"
	item_state = "visor_nvg"
	item_icons = list(
		slot_glasses_str = 'icons/mob/hunter/pred_gear.dmi'
	)
	actions_types = null

/obj/item/clothing/glasses/night/yautja/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/obj/item/clothing/glasses/night/yautja/dropped(mob/living/carbon/human/user)
	if(istype(user) && user.glasses == src)
		user.clear_fullscreen("robothalf", 5)
	..()

/obj/item/clothing/glasses/night/yautja/equipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.overlay_fullscreen("robothalf", /atom/movable/screen/fullscreen/machine/pred/night)
	..()

/obj/item/clothing/glasses/night/yautja/unequipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.clear_fullscreen("robothalf", 5)
	..()

/obj/item/clothing/glasses/night_vision
	name = "\improper BE-47 night vision goggles"
	desc = "Goggles for seeing clearer in low light conditions and maintaining sight of the surrounding environment."
	icon_state = "night_vision"
	deactive_state = "night_vision_off"
	worn_layer = COLLAR_LAYER	//The sprites are designed to render over helmets
	item_state_slots = list()
	tint = COLOR_RED
	darkness_view = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	vision_flags = SEE_TURFS
	goggles_layer = TRUE
	active = FALSE
	activation_sound = 'sound/effects/nightvision.ogg'
	deactivation_sound = 'sound/machines/click.ogg'
	///The battery inside
	var/obj/item/cell/night_vision_battery/battery
	///How much energy this module needs when activated
	var/active_energy_cost = 4	//Little over 4 minutes of use
	///Looping sound to play
	var/datum/looping_sound/active_sound = /datum/looping_sound/scan_pulse
	///How loud the looping sound should be
	var/looping_sound_volume = 25

/obj/item/clothing/glasses/night_vision/Initialize(mapload)
	. = ..()
	//Start with a charged battery
	battery = new /obj/item/cell/night_vision_battery(src)
	active_sound = new active_sound()
	active_sound.volume = looping_sound_volume
	update_worn_state()

/obj/item/clothing/glasses/night_vision/examine(mob/user)
	. = ..()
	. += span_notice("This model drains [active_energy_cost] energy when active.")
	. += battery_status()
	. += "To eject the battery, [span_bold("[user.get_inactive_held_item() == src ? "click" : "ALT-click"]")] [src] with an empty hand. To insert a battery, [span_bold("click")] [src] with a compatible cell."

///Info regarding battery status; separate proc so that it can be displayed when examining the parent object
/obj/item/clothing/glasses/night_vision/proc/battery_status()
	if(battery)
		return span_notice("Battery: [battery.charge]/[battery.maxcharge]")
	return span_warning("No battery installed!")

/obj/item/clothing/glasses/night_vision/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() == src && eject_battery(user))
		return
	return ..()

/obj/item/clothing/glasses/night_vision/AltClick(mob/user)
	if(!eject_battery(user))
		return ..()

/obj/item/clothing/glasses/night_vision/attackby(obj/item/I, mob/user, params)
	. = ..()
	insert_battery(I, user)

///Insert a battery, if checks pass
/obj/item/clothing/glasses/night_vision/proc/insert_battery(obj/item/I, mob/user)
	if(!istype(I, /obj/item/cell/night_vision_battery))
		return

	if(battery && (battery.charge > battery.maxcharge / 2))
		balloon_alert(user, "Battery already installed")
		return
	//Hot swap!
	eject_battery()

	user.temporarilyRemoveItemFromInventory(I)
	I.forceMove(src)
	battery = I
	return TRUE

///Eject the internal battery, if there is one
/obj/item/clothing/glasses/night_vision/proc/eject_battery(mob/user)
	if(user?.get_active_held_item() || !battery)
		return

	if(user)
		user.put_in_active_hand(battery)
	else
		battery.forceMove(get_turf(src))
	battery = null

	if(active)
		activate(user)

	return TRUE

/obj/item/clothing/glasses/night_vision/activate(mob/user)
	if(active)
		STOP_PROCESSING(SSobj, src)
		active_sound.stop(src)
	else
		if(!battery || battery.charge < active_energy_cost)
			if(user)
				balloon_alert(user, "No power")
			return FALSE	//Don't activate
		START_PROCESSING(SSobj, src)
		active_sound.start(src)

	update_worn_state(!active)	//The active var has not been toggled yet, so pass the opposite value
	return ..()

/obj/item/clothing/glasses/night_vision/process()
	if(!battery?.use(active_energy_cost))
		if(ismob(loc))	//If it's deactivated while being worn, pass on the reference to activate() so that the user's sight is updated
			activate(loc)
		else
			activate()
		return PROCESS_KILL

///Simple proc to update the worn state of the glasses; will use the active value by default if no argument passed
/obj/item/clothing/glasses/night_vision/proc/update_worn_state(state = active)
	item_state_slots[slot_glasses_str] = initial(icon_state) + (state ? "" : "_off")

/obj/item/clothing/glasses/night_vision/unequipped(mob/unequipper, slot)
	. = ..()
	if(active)
		activate(unequipper)

/obj/item/clothing/glasses/night_vision/Destroy()
	QDEL_NULL(active_sound)
	return ..()

//So that the toggle button is only given when in the eyes slot
/obj/item/clothing/glasses/night_vision/item_action_slot_check(mob/user, slot)
	return CHECK_BITFIELD(slot, ITEM_SLOT_EYES)

/obj/item/clothing/glasses/night_vision/mounted
	name = "\improper BE-35 night vision goggles"
	desc = "Goggles for seeing clearer in low light conditions. Must remain attached to a helmet."
	icon_state = "night_vision_mounted"
	tint = COLOR_BLUE
	vision_flags = NONE
	darkness_view = 9	//The standalone version cannot see the edges
	active_energy_cost = 2	//A little over 7 minutes of use
	looping_sound_volume = 50

/obj/item/clothing/glasses/night_vision/mounted/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, NIGHT_VISION_GOGGLES_TRAIT)
