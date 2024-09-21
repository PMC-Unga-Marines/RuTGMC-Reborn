/datum/xeno_caste/bull
	caste_name = "Bull"
	display_name = "Bull"
	upgrade_name = ""
	caste_desc = "A well defended hit-and-runner."
	caste_type_path = /mob/living/carbon/xenomorph/bull
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "bull" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 21

	// *** Speed *** //
	speed = -0.8

	// *** Plasma *** //
	plasma_max = 270 //High plasma is need for charging
	plasma_gain = 18

	// *** Health *** //
	max_health = 325

	// *** Sunder *** //
	sunder_multiplier = 0.8

	// *** Evolution *** //
	evolution_threshold = 225

	deevolves_to = /mob/living/carbon/xenomorph/runner

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 40, BULLET = 50, LASER = 40, ENERGY = 40, BOMB = 20, BIO = 35, FIRE = 20, ACID = 35)
	hard_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "bull"

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/xeno_action/acid_charge,
		/datum/action/ability/xeno_action/headbutt,
		/datum/action/ability/xeno_action/gore,
	)

/datum/xeno_caste/bull/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/bull/primordial
	upgrade_name = "Primordial"
	caste_desc = "Bloodthirsty horned devil of the hive. Stay away from its path."
	primordial_message = "We are the spearhead of the hive. Run them all down."
	upgrade = XENO_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/xeno_action/acid_charge,
		/datum/action/ability/xeno_action/headbutt,
		/datum/action/ability/xeno_action/gore,
		/datum/action/ability/xeno_action/tolerate,
	)

