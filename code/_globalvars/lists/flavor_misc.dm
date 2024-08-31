	//Hairstyles
GLOBAL_LIST_EMPTY(hair_styles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hair_gradients_list)			//stores /datum/sprite_accessory/hair_gradient indexed by name
GLOBAL_LIST_EMPTY(facial_hair_styles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
	//Underwear
GLOBAL_LIST_EMPTY(underwear_list)		//stores /datum/sprite_accessory/underwear indexed by name
GLOBAL_LIST_INIT(underwear_m, list("Briefs"))
GLOBAL_LIST_INIT(underwear_f, list("Sports bra and briefs", "Bra and brief", "Bra and panties"))
	//Undershirts
GLOBAL_LIST_INIT(undershirt_m, list("None","Black undershirt", "White undershirt", "Beige undershirt", "Fitness shirt", "Beige undershirt(sleeveless)"))
GLOBAL_LIST_INIT(undershirt_f, list("None","Black undershirt", "White undershirt", "Beige undershirt", "Beige undershirt(sleeveless)"))
	//Mutant Human bits
GLOBAL_LIST_EMPTY(moth_wings_list)
GLOBAL_LIST_EMPTY(tails_list_monkey)
	//Backpacks
GLOBAL_LIST_INIT(backpacklist, list("Nothing", "Backpack", "Satchel", "Green Satchel", "Molle Backpack", "Molle Satchel", "Scav Backpack"))



GLOBAL_LIST_INIT(ghost_forms_with_directions_list, list("ghost")) //stores the ghost forms that support directional sprites
GLOBAL_LIST_INIT(ghost_forms_with_accessories_list, list("ghost")) //stores the ghost forms that support hair and other such things

GLOBAL_LIST_INIT(ai_core_display_screens, list(
	":thinking:",
	"Alien",
	"Angel",
	"Banned",
	"Bliss",
	"Blue",
	"Clown",
	"Database",
	"Dorf",
	"Firewall",
	"Fuzzy",
	"Gentoo",
	"Glitchman",
	"Gondola",
	"Goon",
	"Hades",
	"Heartline",
	"Helios",
	"House",
	"Inverted",
	"Matrix",
	"Monochrome",
	"Murica",
	"Nanotrasen",
	"Not Malf",
	"President",
	"Random",
	"Rainbow",
	"Red",
	"Red October",
	"Static",
	"Syndicat Meow",
	"Text",
	"Too Deep",
	"Triumvirate",
	"Triumvirate-M",
	"Weird",
	"shodan",
	"shodan_chill",
	"shodan_data",
	"shodan_pulse"))

/proc/resolve_ai_icon(input)
	if(!input || !(input in GLOB.ai_core_display_screens))
		return "ai"
	else
		if(input == "Random")
			input = pick(GLOB.ai_core_display_screens - "Random")
		return "ai-[lowertext(input)]"

GLOBAL_LIST_INIT(genders, list(MALE, FEMALE, NEUTER))

//like above but autogenerated when a new squad is created
GLOBAL_LIST_INIT(playable_squad_icons, list(
	"private",
	"leader",
	"engi",
	"medic",
	"smartgunner",
))

GLOBAL_LIST_INIT(campaign_icon_types, list(
	"b18",
	"gorgon",
	"medkit",
	"materials",
	"heavy_mech",
	"medium_mech",
	"light_mech",
	"militia",
	"freelancers",
	"icc",
	"pmc",
	"combat_robots",
	"logistics_buff",
	"logistics_malus",
	"bluespace_logistics",
	"bluespace_logistics_malus",
	"tele_uses",
	"tele_active",
	"tele_broken",
	"droppod_refresh",
	"droppod_active",
	"droppod_broken",
	"cas",
	"mortar",
	"cas_disabled",
	"mortar_disabled",
	"droppod_disabled",
	"tele_disabled",
	"reserve_force",
	"tyr",
	"lorica",
	"riot_shield",
	"xeno",
	"grenade",
	"shotgun",
	"scout",
	"ballistic",
	"lasergun",
	"volkite",
	"smartgun",
	"at_mine",
	"binoculars",
	"respawn",
	"support_1",
	"support_2",
	"support_3",
))

GLOBAL_LIST_INIT(campaign_mission_icon_types, list(
	"combat_patrol",
	"mortar_raid",
	"cas_raid",
	"mech_war",
	"teleporter_raid",
	"supply_depot",
	"raiding_base",
	"comm_uplink",
	"asat_capture",
	"phoron_raid",
	"nt_rescue",
	"speahead_som",
	"spearhead_tgmc",
	"final_som",
	"final_tgmc",
))

GLOBAL_LIST_INIT(campaign_icons, init_campaign_icons())

/proc/init_campaign_icons()
	. = list()
	var/list/colours = list("green", "orange", "grey", "red", "blue")
	for(var/icon_state in GLOB.campaign_icon_types)
		for(var/colour in colours)
			.["[icon_state]_[colour]"] = icon2base64(icon('icons/UI_icons/campaign_icons.dmi', "[icon_state]_[colour]", frame = 1))

GLOBAL_LIST_INIT(campaign_mission_icons, init_campaign_mission_icons())

/proc/init_campaign_mission_icons()
	. = list()
	var/list/colours = list("green", "yellow", "grey", "red", "blue")
	for(var/icon_state in GLOB.campaign_mission_icon_types)
		for(var/colour in colours)
			.["[icon_state]_[colour]"] = icon2base64(icon('icons/UI_icons/mission_icons.dmi', "[icon_state]_[colour]", frame = 1))



GLOBAL_LIST_INIT(playable_icons, list(
	"behemoth",
	"boiler",
	"bull",
	"captain",
	"clown",
	"military_police",
	"carrier",
	"chief_medical",
	"cl",
	"crusher",
	"cse",
	"defender",
	"defiler",
	"drone",
	"facehugger",
	"fieldcommander",
	"gorger",
	"hivelord",
	"hivemind",
	"hunter",
	"larva",
	"mech_pilot",
	"medical",
	"panther",
	"pilot",
	"praetorian",
	"private",
	"ravager",
	"requisition",
	"researcher",
	"runner",
	"sentinel",
	"spitter",
	"st",
	"staffofficer",
	"synth",
	"warlock",
	"warrior",
	"xenoking",
	"xenominion",
	"xenoqueen",
	"xenoshrike",
	"chimera",
	"predator",
	"thrall",
	"hellhound",
	"transport_crew",
	"transportofficer",
	"assaultcrew",
))

GLOBAL_LIST_EMPTY(human_ethnicities_list)
GLOBAL_LIST_EMPTY(yautja_ethnicities_list)

GLOBAL_LIST_EMPTY(yautja_hair_styles_list)

GLOBAL_LIST_INIT(ethnicities_list, init_ethnicities())

/// Ethnicity - Initialise all /datum/ethnicity into a list indexed by ethnicity name
/proc/init_ethnicities()
	. = list()

	for(var/path in subtypesof(/datum/ethnicity) - /datum/ethnicity/human - /datum/ethnicity/yautja)
		var/datum/ethnicity/E = new path()
		.[E.name] = E

		if(istype(E, /datum/ethnicity/human))
			GLOB.human_ethnicities_list[E.name] = E

		if(istype(E, /datum/ethnicity/yautja))
			GLOB.yautja_ethnicities_list[E.name] = E

	for(var/path in subtypesof(/datum/sprite_accessory/yautja_hair))
		var/datum/sprite_accessory/yautja_hair/H = new path()
		GLOB.yautja_hair_styles_list[H.name] = H


GLOBAL_LIST_INIT(minimap_icons, init_minimap_icons())

/proc/init_minimap_icons()
	. = list()
	for(var/icon_state in GLOB.playable_icons)
		.[icon_state] = icon2base64(icon('icons/UI_icons/map_blips.dmi', icon_state, frame = 1)) //RUTGMC edit - icon change
