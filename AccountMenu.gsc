//----------------------------------------
//Account Stuff
//----------------------------------------

SetBankAccount(i)
{
	if ( !isDefined( level.banking_map ) )
		level.banking_map = "zm_transit";
	new_account_value = (self maps/mp/zombies/_zm_stats::get_map_stat( "depositBox", level.banking_map)) + i;
	if (new_account_value < 0)
		new_account_value = 0;
	else if (new_account_value > level.bank_account_max)
		new_account_value = level.bank_account_max;
	if (i > 0)
		self playsoundtoplayer("zmb_vault_bank_deposit", self);
	else
		self playsoundtoplayer("zmb_vault_bank_withdraw", self);
	self.account_value = new_account_value;
	self maps/mp/zombies/_zm_stats::set_map_stat( "depositBox", self.account_value, level.banking_map );
	if (i > 0)
	{
		if (isDefined( level.custom_bank_deposit_vo))
			self thread [[level.custom_bank_deposit_vo]]();
	}
	else
	{
		if (isDefined(level.custom_bank_withdrawl_vo))
			self thread [[level.custom_bank_withdrawl_vo]]();
		else
			self thread do_player_general_vox( "general", "exert_laugh", 10, 50 );
	}
	self stealth_iprintln("You have now ^1" +  self.account_value + "K^7 in your bank");
}

//----------------------------------------
//Stats System
//----------------------------------------


SetClientStatCustom( stat_name, stat_value, include_gametype )
{
	textonoff = 1;
	author = self;
    game_mode = getDvar( "ui_gametype" );
    if ( !isDefined( include_gametype ) )
	{
		include_gametype = 1;
	}
	if ( !isDefined( textonoff ) )
	{
		textonoff = 1;
	}
	old_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( game_mode , stat_name );
	if (include_gametype==1)
	{
	old_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( game_mode , stat_name );
	if (( old_stat_count + stat_value) < 0) stat_value = (0 - old_stat_count);
	}
	else
	{
	old_stat_count = self maps/mp/zombies/_zm_stats::get_global_stat( stat_name );
	if (( old_stat_count + stat_value) < 0) stat_value = (0 - old_stat_count);
	}
	if (stat_name == "downs")
	{
	deathstats = self maps/mp/zombies/_zm_stats::get_game_mode_stat( game_mode , "deaths" );
	if (( old_stat_count + stat_value) < deathstats) stat_value = (0 - old_stat_count) + deathstats;
	}
    old_glb_stat_count = self maps/mp/zombies/_zm_stats::get_global_stat( stat_name );
  	self maps/mp/gametypes_zm/_globallogic_score::incpersstat( stat_name, stat_value, 1, include_gametype );
	new_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( game_mode , stat_name );
	new_glb_stat_count = self maps/mp/zombies/_zm_stats::get_global_stat( stat_name );
	if (stat_name == "head_gibs" || stat_name == "right_arm_gibs" || stat_name == "left_arm_gibs" || stat_name =="right_leg_gibs" || stat_name == "left_leg_gibs")
	{
	self SetClientStatCustom("gibs", stat_value,1 );
	}
	else if (stat_name == "specialty_scavenger_drank" || stat_name == "specialty_finalstand_drank" || stat_name == "specialty_grenadepulldeath_drank" || stat_name == "specialty_nomotionsensor_drank" || stat_name == "specialty_flakjacket_drank" || stat_name == "specialty_additionalprimaryweapon_drank" || stat_name == "specialty_longersprint_drank" || stat_name == "specialty_deadshot_drank" || stat_name == "specialty_armorvest_drank" || stat_name == "specialty_quickrevive_drank" || stat_name == "specialty_rof_drank" || stat_name == "specialty_fastreload_drank" )
	{
	self SetClientStatCustom("perks_drank", stat_value, 1 );
	}
	else if ( stat_name == "headshots" )
	{
	self SetClientStatCustom("kills", stat_value, 1 );
	}
	else if ( stat_name == "grenade_kills" )
	{
	self SetClientStatCustom("kills", stat_value, 1 );
	}
	if (stat_name == "deaths")
	{
	self SetClientStatCustom("downs", stat_value, 1 );
	}
	 if (textonoff == 1)
	 {
	 if (game_mode == "zclassic" )
    {
    self stealth_iprintln("All games types " + stat_name +" changed from " + old_glb_stat_count + " to " + new_glb_stat_count);       
  if (include_gametype==1)  self stealth_iprintln("Classic game type " + stat_name +" changed from " + old_stat_count + " to " + new_stat_count); 
    }
     else if (game_mode == "zstandard" )
    {
    self stealth_iprintln("All games type " + stat_name +" changed from " + old_glb_stat_count + " to " + new_glb_stat_count);       
    if (include_gametype==1)  self stealth_iprintln("Survival game type " + stat_name +" changed from " + old_stat_count + " to " + new_stat_count); 
    }
    else if (game_mode == "zgrief" )
    {
    self stealth_iprintln("All games type " + stat_name +" changed from " + old_glb_stat_count + " to " + new_glb_stat_count);       
    if (include_gametype==1)  self stealth_iprintln("Grief game type " + stat_name +" changed from " + old_stat_count + " to " + new_stat_count); 
    }
     else if (game_mode == "zcleansed" )
    {
    self stealth_iprintln("All games type " + stat_name +" changed from " + old_glb_stat_count + " to " + new_glb_stat_count);       
   if (include_gametype==1)   self iprintln("Cleansed game type " + stat_name +" changed from " + old_stat_count + " to " + new_stat_count); 
    }
     else if (game_mode == "zencounter" )
    {
    self iprintln("All games type " + stat_name +" changed from " + old_glb_stat_count + " to " + new_glb_stat_count);       
    if (include_gametype==1)  self stealth_iprintln("Encounter game type " + stat_name +" changed from " + old_stat_count + " to " + new_stat_count); 
    }
    else
     {
    self stealth_iprintln("All games type " + stat_name +" changed from " + old_glb_stat_count + " to " + new_glb_stat_count);       
    if (include_gametype==1)  self stealth_iprintln(game_mode +" game type " + stat_name +" changed from " + old_stat_count + " to " + new_stat_count); 
    }
     }
}

GetStatsCustom(stat_name, include_gametype)
{
    if ( !isDefined( include_gametype ) )
	{
		include_gametype = 1;
	}
	game_mode = getDvar( "ui_gametype" ); 
    current_stat_count = self maps/mp/zombies/_zm_stats::get_global_stat( stat_name );
    if (game_mode == "zclassic" )
    {
    zclassiccurrent_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( "zclassic"  , stat_name );
    self stealth_iprintln("All games types " +stat_name + ": " + current_stat_count);       
     if (include_gametype==1)   self stealth_iprintln("Classic game type " +stat_name + ": "  + zclassiccurrent_stat_count); 
    }
     else if (game_mode == "zstandard" )
    {
    zstandardcurrent_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( "zstandard"  , stat_name );
    self stealth_iprintln("All games type " +stat_name + ": "  + current_stat_count);       
     if (include_gametype==1)   self stealth_iprintln("Survival game type " +stat_name + ": "  + zstandardcurrent_stat_count); 
    }
    else if (game_mode == "zgrief" )
    {
    zgriefcurrent_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( "zgrief"  , stat_name );
    self stealth_iprintln("All games type " +stat_name + ": "  + current_stat_count);       
    if (include_gametype==1)    self stealth_iprintln("Grief game type " +stat_name + ": "  + zgriefcurrent_stat_count); 
    }
     else if (game_mode == "zcleansed" )
    {
     zcleansedcurrent_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_stat( "zcleansed"  , stat_name );
    self stealth_iprintln("All games type " +stat_name + ": "  + current_stat_count);       
     if (include_gametype==1)   self stealth_iprintln("Cleansed game type " +stat_name + ": "  + zcleansedcurrent_stat_count); 
    }
    else
     {
    zcl_stat_count = self maps/mp/zombies/_zm_stats::get_game_mode_group_stat( game_mode, stat_name );
    self stealth_iprintln("All games type " + current_stat_count);       
     if (include_gametype==1)   self stealth_iprintln(game_mode +" game type " +stat_name + ": "  + zcl_stat_count); 
    }
    if (stat_name == "head_gibs" || stat_name == "right_arm_gibs" || stat_name == "left_arm_gibs" || stat_name =="right_leg_gibs" || stat_name == "left_leg_gibs")
	{
	self GetStatsCustom("gibs",1);
	}
	else if (stat_name == "specialty_scavenger_drank" || stat_name == "specialty_finalstand_drank" || stat_name == "specialty_grenadepulldeath_drank" || stat_name == "specialty_nomotionsensor_drank" || stat_name == "specialty_flakjacket_drank" || stat_name == "specialty_additionalprimaryweapon_drank" || stat_name == "specialty_longersprint_drank" || stat_name == "specialty_deadshot_drank" || stat_name == "specialty_armorvest_drank" || stat_name == "specialty_quickrevive_drank" || stat_name == "specialty_rof_drank" || stat_name == "specialty_fastreload_drank" )
	{
	self GetStatsCustom("perks_drank");
	}
}
Set_LastActivity_Stats(i)
{
//self setdstat( "PlayerStatsList", stat_name, "StatValue", value );
newtime = getutc();
if (i == 0)
{
self set_global_stat( "TIMESTAMPLASTDAY1", (newtime -(85252*6)) );
self set_global_stat( "TIMESTAMPLASTDAY2", (newtime -(85252*7)) );
self set_global_stat( "TIMESTAMPLASTDAY3", (newtime -(86101*8)) );
self set_global_stat( "TIMESTAMPLASTDAY4", (newtime -(84470*9)) );
self set_global_stat( "TIMESTAMPLASTDAY5", (newtime -(85903*10)) );	
}
else if (i == 1)
{
self set_global_stat( "TIMESTAMPLASTDAY1", newtime );
self set_global_stat( "TIMESTAMPLASTDAY2", (newtime -(85252*6)) );
self set_global_stat( "TIMESTAMPLASTDAY3", (newtime -(86101*7)) );
self set_global_stat( "TIMESTAMPLASTDAY4", (newtime -(84470*8)) );
self set_global_stat( "TIMESTAMPLASTDAY5", (newtime -(85903*9)) );	
}
else if (i == 2)
{
self set_global_stat( "TIMESTAMPLASTDAY1", newtime );
self set_global_stat( "TIMESTAMPLASTDAY2", (newtime -(85252)) );
self set_global_stat( "TIMESTAMPLASTDAY3", (newtime -(86101*6)) );
self set_global_stat( "TIMESTAMPLASTDAY4", (newtime -(84470*7)) );
self set_global_stat( "TIMESTAMPLASTDAY5", (newtime -(85903*8)) );	
}
else if (i == 3)
{
self set_global_stat( "TIMESTAMPLASTDAY1", newtime );
self set_global_stat( "TIMESTAMPLASTDAY2", (newtime -(85252)) );
self set_global_stat( "TIMESTAMPLASTDAY3", (newtime -(86101*2)) );
self set_global_stat( "TIMESTAMPLASTDAY4", (newtime -(84470*6)) );
self set_global_stat( "TIMESTAMPLASTDAY5", (newtime -(85903*7)) );	
}
else if (i == 4)
{
self set_global_stat( "TIMESTAMPLASTDAY1", newtime );
self set_global_stat( "TIMESTAMPLASTDAY2", (newtime -(85252)) );
self set_global_stat( "TIMESTAMPLASTDAY3", (newtime -(86101*2)) );
self set_global_stat( "TIMESTAMPLASTDAY4", (newtime -(84470*3)) );
self set_global_stat( "TIMESTAMPLASTDAY5", (newtime -(85903*6)) );	
}
else if (i == 5)
{
self set_global_stat( "TIMESTAMPLASTDAY1", newtime );
self set_global_stat( "TIMESTAMPLASTDAY2", (newtime -(85252)) );
self set_global_stat( "TIMESTAMPLASTDAY3", (newtime -(86101*2)) );
self set_global_stat( "TIMESTAMPLASTDAY4", (newtime -(84470*3)) );
self set_global_stat( "TIMESTAMPLASTDAY5", (newtime -(85903*4)) );	
}
self stealth_iprintln("Activity Rank Set To ^2" + i );       
}



