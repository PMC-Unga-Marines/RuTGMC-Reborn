#define HIGHLIGHT_VARIANTS "highlight_variants"
#define HOOD "hood"

/obj/item/armor_module/armor/cape
	name = "6E Chameleon cape"
	desc = "A chromatic cape to improve on the design of the 7E badge, this cape is capable of two colors, for all your fashion needs. It also is equipped with thermal insulators so it will double as a blanket."
	icon_state = "cape"
	slot = ATTACHMENT_SLOT_CAPE
	attachment_layer = CAPE_LAYER
	prefered_slot = SLOT_W_UNIFORM
	greyscale_config = /datum/greyscale_config/cape
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB|ATTACH_ACTIVATION
	attach_delay = 0 SECONDS
	detach_delay = 0 SECONDS
	secondary_color = TRUE
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight)
	attachments_allowed = list(
		/obj/item/armor_module/armor/cape_highlight,
		/obj/item/armor_module/armor/cape_highlight/kama,
	)
	colorable_allowed = PRESET_COLORS_ALLOWED|ICON_STATE_VARIANTS_ALLOWED
	current_variant = "long"
	icon_state_variants = list(
		"long" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"long",
				"none",
			),
		),
		"regaly" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"regaly",
				"none",
			),
		),
		"onelong" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"onelong",
				"none",
			),
		),
	)

	///True if the hood is up, false if not.
	var/hood = FALSE

/obj/item/armor_module/armor/cape/update_icon_state()
	. = ..()
	var/obj/item/armor_module/highlight = attachments_by_slot[ATTACHMENT_SLOT_CAPE_HIGHLIGHT]
	if(hood)
		icon_state = initial(icon_state) + "_[current_variant]_h"
		item_state = initial(item_state) + "_[current_variant]_h"
	else
		icon_state = initial(icon_state) + "_[current_variant]"
		item_state = initial(item_state) + "_[current_variant]"
	highlight?.update_icon()
	if(parent)
		parent.update_clothing_icon()

/obj/item/armor_module/armor/cape/activate(mob/living/user)
	. = ..()
	hood = !hood
	update_icon()
	update_greyscale()
	user.update_inv_w_uniform()


/obj/item/armor_module/armor/cape/examine(user)
	. = ..()
	. += span_notice("Interact with <b>facepaint</b> to color or change the variant.")
	. += span_notice("Attaches to <b>uniform</b>.")


/obj/item/armor_module/armor/cape/color_item(obj/item/facepaint/paint, mob/user)
	var/old_variant = current_variant
	. = ..()
	if(old_variant == current_variant)
		return
	if(parent)
		UnregisterSignal(parent, COMSIG_ITEM_EQUIPPED)
	icon_state_variants[current_variant][HOOD] ? ENABLE_BITFIELD(flags_attach_features, ATTACH_ACTIVATION) : DISABLE_BITFIELD(flags_attach_features, ATTACH_ACTIVATION)
	if(CHECK_BITFIELD(flags_attach_features, ATTACH_ACTIVATION) && parent)
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(handle_actions))
	var/obj/item/armor_module/highlight = attachments_by_slot[ATTACHMENT_SLOT_CAPE_HIGHLIGHT]
	if(!icon_state_variants[current_variant][HOOD])
		hood = FALSE
		highlight?.icon_state = initial(highlight.icon_state) + "_[highlight.current_variant]"
		if(ishuman(parent?.loc))
			LAZYREMOVE(actions_types, /datum/action/item_action/toggle)
			var/datum/action/item_action/toggle/old_action = locate(/datum/action/item_action/toggle) in actions
			old_action?.remove_action(user)
			actions = null
	if(!icon_state_variants[old_variant][HOOD] && icon_state_variants[current_variant][HOOD] && ishuman(parent?.loc))
		LAZYADD(actions_types, /datum/action/item_action/toggle)
		var/datum/action/item_action/toggle/new_action = new(src)
		if(toggle_signal)
			new_action.keybinding_signals = list(KEYBINDING_NORMAL = toggle_signal)
		new_action.give_action(user)
	highlight.current_variant = length(icon_state_variants[current_variant][HIGHLIGHT_VARIANTS]) ? icon_state_variants[current_variant][HIGHLIGHT_VARIANTS][1] : "none"
	highlight.icon_state_variants = icon_state_variants[current_variant][HIGHLIGHT_VARIANTS]
	ENABLE_BITFIELD(highlight.colorable_allowed, PRESET_COLORS_ALLOWED)
	update_icon()
	update_greyscale()
	highlight.update_icon()
	highlight.update_greyscale()
	user.update_inv_w_uniform()

/obj/item/armor_module/armor/cape/kama
	name = "6E Chameleon kama"
	desc = "A chromatic kama to improve on the design of the 7E badge, this kama is capable of two colors, for all your fashion needs. Hanged from the belt, it serves to flourish the lower extremities.  \n Interact with facepaint to color. Attaches onto a uniform."
	slot = ATTACHMENT_SLOT_KAMA
	attachment_layer = KAMA_LAYER
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight/kama)
	greyscale_config = /datum/greyscale_config/cape
	icon_state_variants = list(
		"kama" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"kama",
			),
		),
		"kilt" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"kilt",
			),
		),
		"kilt (alt)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"kilt",
			),
		),
	)
	current_variant = "kama"


/obj/item/armor_module/armor/cape_highlight
	name = "Cape Highlight"
	desc = "A cape to improve on the design of the 7E badge, this cape is capable of six colors, for all your fashion needs. This variation of the cape functions more as a scarf. \n Interact with facepaint to color. Attaches onto a uniform. Activate it to toggle the hood."
	icon_state = "highlight"
	slot = ATTACHMENT_SLOT_CAPE_HIGHLIGHT
	flags_attach_features = ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB
	colorable_allowed = PRESET_COLORS_ALLOWED|ICON_STATE_VARIANTS_ALLOWED|COLOR_WHEEL_ALLOWED
	greyscale_config = /datum/greyscale_config/cape_highlight
	secondary_color = TRUE
	flags_item_map_variant = NONE
	current_variant = "none"
	greyscale_colors = CAPE_PALETTE_GOLD
	colorable_colors = CAPE_PALETTES_LIST
	icon_state_variants = list(
		"long",
		"none",
	)

/obj/item/armor_module/armor/cape_highlight/update_icon_state()
	. = ..()
	if(!parent)
		return
	var/obj/item/armor_module/armor/cape/cape_parent = parent
	if(cape_parent.hood)
		icon_state = initial(icon_state) + "_[current_variant]_h"
	else
		icon_state = initial(icon_state) + "_[current_variant]"


/obj/item/armor_module/armor/cape_highlight/handle_color(datum/source, mob/user, list/obj/item/secondaries)
	if(current_variant == "none" && (length(icon_state_variants) == 1))
		return
	return ..()



/obj/item/armor_module/armor/cape_highlight/kama
	greyscale_config = /datum/greyscale_config/cape_highlight
	colorable_allowed = PRESET_COLORS_ALLOWED
	current_variant = "kama"
	icon_state_variants = list()
