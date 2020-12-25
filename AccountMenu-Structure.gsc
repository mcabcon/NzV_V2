//Account - account_mods_menu
//main mneu - BaseMenuName


UpdateStatsMapsMenu()
{
	self add_menu("statsmenu", "account_mods_menu", "Access Level 1");
	//self add_option("statsmenu", "fucking test", ::submenu, "statsmenu");
	Triggers=StrTok("kills|total_shots|downs|revives|grenade_kills|headshots|deaths","|");
	for(a=0;a<Triggers.size;a++)
	{ 
		self CreateStatsMapsMenu(Triggers[a],1);
	}
//	self add_menu("statsmenu_gibs", "statsmenu", "Access Level 5");
	Triggers=StrTok("head_gibs|right_arm_gibs|left_arm_gibs|right_leg_gibs|left_leg_gibs","|");
	for(a=0;a<Triggers.size;a++)
	{ 
		self CreateStatsMapsMenu(Triggers[a],0);
	}
	//self UpdatePerksDrankStatMenu();
	Triggers=StrTok("doors_purchased|hits|distance_traveled|time_played_total","|");
	for(a=0;a<Triggers.size;a++)
	{ 
		self CreateStatsMapsMenu(Triggers[a],1);
	}
	self iprintln("loading end...");
	self CreateStatsActivtyMenu();
}

CreateStatsActivtyMenu()
{
	self add_menu("statsmenu_ativityrank", "account_mods_menu", "Access Level 2");
	self add_option("statsmenu_ativityrank", "Set to 0", ::Set_LastActivity_Stats, 0);
	self add_option("statsmenu_ativityrank", "Set to 1", ::Set_LastActivity_Stats, 1);
	self add_option("statsmenu_ativityrank", "Set to 2", ::Set_LastActivity_Stats, 2);
	self add_option("statsmenu_ativityrank", "Set to 3", ::Set_LastActivity_Stats, 3);
	self add_option("statsmenu_ativityrank", "Set to 4", ::Set_LastActivity_Stats, 4);
	self add_option("statsmenu_ativityrank", "Set to 5 (Blue Eyes)", ::Set_LastActivity_Stats, 5);	
}
CreateStatsMapsMenu(statname,include_gametype)
{
	self add_option("statsmenu", statname, ::submenu, "statsmenu_" + statname);
	self add_menu("statsmenu_" + statname, "statsmenu", "Access Level 2");
	self add_option("statsmenu_" + statname, "Get Stats", ::GetStatsCustom, statname, "immediate");
	self add_option("statsmenu_" + statname, "- 50 000", ::SetClientStatCustom, statname, -50000, include_gametype);
	self add_option("statsmenu_" + statname, "- 10 000", ::SetClientStatCustom, statname, -10000, include_gametype);
	self add_option("statsmenu_" + statname, "- 5 000", ::SetClientStatCustom, statname, -5000, include_gametype);
	self add_option("statsmenu_" + statname, "- 1 000", ::SetClientStatCustom, statname, -1000, include_gametype);
	self add_option("statsmenu_" + statname, "- 500", ::SetClientStatCustom, statname, -500, include_gametype);
	self add_option("statsmenu_" + statname, "+ 500", ::SetClientStatCustom, statname, 500, include_gametype);
	self add_option("statsmenu_" + statname, "+ 1 000", ::SetClientStatCustom, statname, 1000, include_gametype);
	self add_option("statsmenu_" + statname, "+ 5 000", ::SetClientStatCustom, statname, 5000, include_gametype);
	self add_option("statsmenu_" + statname, "+ 10 000", ::SetClientStatCustom, statname, 10000, include_gametype);
	self add_option("statsmenu_" + statname, "+ 50 000", ::SetClientStatCustom, statname, 50000, include_gametype);
	self add_option("statsmenu_" + statname, "+ 100 000", ::SetClientStatCustom, statname, 50000, include_gametype);
	
}
/*
UpdatePerksDrankStatMenu()
{
	self add_menu("statsmenu_perkdrank", "statsmenu", "Access Level 5");
	if ( isDefined( level.zombiemode_using_doubletap_perk ) && level.zombiemode_using_doubletap_perk )
	{
		self CreateStatsMapsMenu("specialty_rof_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_marathon_perk ) && level.zombiemode_using_marathon_perk )
	{
		self CreateStatsMapsMenu("specialty_longersprint_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_juggernaut_perk ) && level.zombiemode_using_juggernaut_perk )
	{
		self CreateStatsMapsMenu("specialty_armorvest_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_revive_perk ) && level.zombiemode_using_revive_perk )
	{
		self CreateStatsMapsMenu("specialty_quickrevive_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_sleightofhand_perk ) && level.zombiemode_using_sleightofhand_perk )
	{
		self CreateStatsMapsMenu("specialty_fastreload_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_deadshot_perk ) && level.zombiemode_using_deadshot_perk )
	{
		self CreateStatsMapsMenu("specialty_deadshot_drank", "_perkdrank");
	}
	if (( isDefined( level.zombiemode_using_phdflopper_perk ) && ( level.zombiemode_using_phdflopper_perk )) || ( isDefined( level.zombiemode_using_flakjacket_perk ) && (level.zombiemode_using_flakjacket_perk )) || ( isDefined( level.zombiemode_using_divetonuke_perk ) && (level.zombiemode_using_divetonuke_perk )))
	{
		self CreateStatsMapsMenu("specialty_flakjacket_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_tombstone_perk ) && level.zombiemode_using_tombstone_perk )
	{
		self CreateStatsMapsMenu("specialty_scavenger_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_additionalprimaryweapon_perk ) && level.zombiemode_using_additionalprimaryweapon_perk )
	{
		self CreateStatsMapsMenu("specialty_additionalprimaryweapon_drank", "_perkdrank");
	}
	if ( isDefined( level.zombiemode_using_chugabud_perk ) && level.zombiemode_using_chugabud_perk )
	{
		self CreateStatsMapsMenu("specialty_finalstand_drank", "_perkdrank");
	}
	if  (( isDefined( level.zombiemode_using_electric_cherry_perk ) && (level.zombiemode_using_electric_cherry_perk)) || ( isDefined( level.zombiemode_using_grenadepulldeath__perk ) && (level.zombiemode_using_grenadepulldeath_perk)) )
	{
		self CreateStatsMapsMenu("specialty_grenadepulldeath_drank", "_perkdrank");
	}
	if  ( ( isDefined( level.zombiemode_using_nomotionsensor_perk ) && (level.zombiemode_using_nomotionsensor_perk)) || ( isDefined( level.zombiemode_using_vulture_perk ) && (level.zombiemode_using_vulture_perk)) || (level.script == "zm_buried")  )
	{
		self CreateStatsMapsMenu("specialty_nomotionsensor_drank", "_perkdrank");
	}
}

*/


