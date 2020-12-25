Toggle_MagicChestUnmovable()
{
    if(getDvarint("magic_chest_movable") == 1)
       setDvar("magic_chest_movable", 0); 
    else
       setDvar("magic_chest_movable", 1); 
	self stealth_iprintln("Magic Chest Unmovable " + ((getDvarint("magic_chest_movable") == 0) ? "^2ON" : "^1OFF"));
}

Toggle_HideMagicChest()
{
	if(!isDefined(level.HideMagicBox))
		level.HideMagicBox = false;
	level.HideMagicBox = !level.HideMagicBox;
	if(level.HideMagicBox)
	{
	 	foreach(chest in level.chests)
				chest thread maps\mp\zombies\_zm_magicbox::hide_chest();
	}
	else
	{
	 	foreach(chest in level.chests)
				chest thread maps\mp\zombies\_zm_magicbox::show_chest();
	}
	self stealth_iprintln("Hide Magic Box " + (level.HideMagicBox ? "^2ON" : "^1OFF"));
}

Toggle_HeadShotsOnly()
{
	if(!isDefined(level.headshots_only))
		level.headshots_only = false;
	level.headshots_only = !level.headshots_only;
	self stealth_iprintln("Head Shots Only " + (level.headshots_only ? "^2ON" : "^1OFF"));
}


Toggle_AutoRevive()
{
	level notify("StopAutoRevive");
	if(!isDefined(level.AutoRevive))
		level.AutoRevive = false;
	level.AutoRevive = !level.AutoRevive;
	if(level.AutoRevive)
	{
		for(m = 0; m < getPlayers().size; m++)
		{
			getPlayers()[m] notify("StopAutoRevive");
			getPlayers()[m] thread doAutoRevive();
			wait 0.1;
		}
	}
	self stealth_iprintln("Auto Revive " + (level.AutoRevive ? "^2ON" : "^1OFF"));
}

doAutoRevive()
{
	self notify("StopAutoRevive");
	self endon("StopAutoRevive");
	level endon("StopAutoRevive");
    self endon("disconnect");
	level endon("game_ended");  
    while(isDefined(level.AutoRevive) && level.AutoRevive)
    {
		self waittill("player_downed");
		if(IsDefined(self.revivetrigger))
		{
			self notify ("player_revived");
			self reviveplayer();
			self.revivetrigger delete();
			self.revivetrigger = undefined;
			self.ignoreme = false;
			self allowjump(true);
			self EnableOffhandWeapons();
	        self EnableWeaponCycling();
	        self Enableweapons();
	       	self AllowLean(true);
	        self AllowAds(true);
	        self AllowSprint(true);
	        self AllowProne(true);
	        self AllowMelee(true);
			self.laststand = undefined;
		}
		wait 0.1;		
    }
}

doBuildBuildable(buildable)
{
   	for(i = 0; i < level.buildable_stubs.size; i++)
	{
		if (isDefined(buildable) && level.buildable_stubs[i].equipname == buildable && level.buildable_stubs[i].persistent != 3  && !isDefined(level.buildable_stubs[i].isCustomBuilded))
		{
			level.buildable_stubs[i] maps/mp/zombies/_zm_buildables::buildablestub_finish_build(self);
			for(y = 0; y < level.buildable_stubs[i].buildablezone.pieces.size; y++)
				level.buildable_stubs[i].buildablezone.pieces[y] maps/mp/zombies/_zm_buildables::piece_unspawn();
			level.buildable_stubs[i].model notsolid();
			level.buildable_stubs[i].model show();
			level.buildable_stubs[i].isCustomBuilded = true;
			self stealth_iprintln(buildable + " ^2Builded");
			return;
		}
	}
	self stealth_iprintln(buildable + " ^1Not Found Or Already Build");
}


Toggle_ChatSetting(Type)
{
    if(Type == "DeadChatWithDead")
    {
		if(level.voip.deadchatwithdead == 1)
			level.voip.deadchatwithdead = 0;
		else
			level.voip.deadchatwithdead = 1;
		setmatchtalkflag( "DeadChatWithDead", level.voip.deadchatwithdead);
		self stealth_iprintln("Dead Chat With Dead " + ((level.voip.deadchatwithdead == 1) ? "^2ON" : "^1OFF"));
    }
    else if(Type == "DeadChatWithTeam")
    {
		if(level.voip.deadchatwithteam == 1)
			level.voip.deadchatwithteam = 0;
		else
			level.voip.deadchatwithteam = 1;
		setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
		self stealth_iprintln("Dead Chat With Team " + ((level.voip.deadchatwithteam == 1) ? "^2ON" : "^1OFF"));
    }
    else if(Type == "DeadHearTeamLiving")
    {
		if(level.voip.deadhearallliving == 1)
			level.voip.deadhearallliving = 0;
		else
			level.voip.deadhearallliving = 1;
		setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearallliving);
		self stealth_iprintln("Dead Hear Team Living " + ((level.voip.deadhearallliving == 1) ? "^2ON" : "^1OFF"));
    }
    else if(Type == "DeadHearAllLiving")
    {
		if(level.voip.deadhearallliving == 1)
			level.voip.deadhearallliving = 0;
		else
			level.voip.deadhearallliving = 1;
		setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
		self stealth_iprintln("Dead Hear All Living " + ((level.voip.deadhearallliving == 1) ? "^2ON" : "^1OFF"));
    }
    else if(Type == "EveryoneHearsEveryone")
    {
		if(level.voip.everyonehearseveryone == 1)
			level.voip.everyonehearseveryone = 0;
		else
			level.voip.everyonehearseveryone = 1;
		setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
		self stealth_iprintln("Everyone Hears Everyone " + ((level.voip.everyonehearseveryone == 1) ? "^2ON" : "^1OFF"));
    }
}

SetClaymoresLimit(i)
{
	set_zombie_var("claymores_max_per_player", i);
	level.claymores_max_per_player = i;
	self stealth_iprintln("Max Spawned Claymores Per Players Limit Set To  ^2" + level.claymores_max_per_player);
}

SetGravityMods(i)
{
    setDvar("bg_gravity", i);
	self stealth_iprintln("Gravity Set To  ^2" + i);
}

SetTimeScalesMods(i)
{
    setDvar("timescale", i);
	self stealth_iprintln("Time Scale Set To  ^2" + i);
}

SetMeleeRangeMods(i)
{
    setDvar("player_meleeRange", i);
	self stealth_iprintln("Melee Range Set To  ^2" + i);
}

SetAllSpeedMods(i)
{
    setDvar("g_speed", i);
	self stealth_iprintln("Speed Set To  ^2" + i);
}

SetReviveTriggerRadius(i)
{
    setDvar("revive_trigger_radius", i);
	self stealth_iprintln("Revive Trigger Radius Set To  ^2" + i);
}

SetLastStandBleedoutTime(i)
{
    setDvar("player_lastStandBleedoutTime", i);
	self stealth_iprintln("Last Stand Bleedout Time Set To  ^2" + i);
}

//----------------------------------------
//PermaInstaKill
//----------------------------------------

Toggle_PermaInstaKill_NzV()
{
	level notify("StopPermaInstaKill");
	self notify("StopPermaInstaKill");
	if(!isDefined(level.PermaInstaKill))
		level.PermaInstaKill = false;
	level.PermaInstaKill = !level.PermaInstaKill;
	if(level.PermaInstaKill)
		self thread doPermaInstaKill_NzV();
	self stealth_iprintln("Perma Insta Kill " + (level.PermaInstaKill ? "^2ON" : "^1OFF"));
}

doPermaInstaKill_NzV()
{   
	level notify("StopPermaInstaKill");
	self notify("StopPermaInstaKill");
    self endon("StopPermaInstaKill");
    level endon("StopPermaInstaKill");
    self endon("disconnect");
    self endon("death");
	level endon("game_ended");
    while(isDefined(level.PermaInstaKill) && level.PermaInstaKill)
    {
		level.powerup_drop_count = 0;
		level thread maps/mp/zombies/_zm_powerups::specific_powerup_drop("insta_kill", self.origin);
   	 	wait 27;
    } 
}

//----------------------------------------
//OpenAllDoorsAndPowerOn
//----------------------------------------

OpenAllDoorsAndPowerOn()
{
	if(!isDefined(level.OpenDoorPower) || !level.OpenDoorPower)
	{
	    level.OpenDoorPower = true;
	    setdvar("zombie_unlock_all", 1);
	    level notify("open_sesame");
		//Set Power ON
		if (level.script == "zm_tranzit")
		{
			level.local_doors_stay_open = 1;
			level.power_local_doors_globally = 1;
			level notify( "Pack_A_Punch_on" );
		}
		flag_set("power_on");
		clientnotify("power_on");
		level setclientfield("zombie_power_on", 1);
		//Unlock Perk Vendor
		if ((level.script == "zm_transit") ||  (level.script == "zm_highrise") ||  (level.script == "zm_buried"))
		{
	    	level notify("unlock_all_perk_machines");
			level thread maps/mp/zombies/_zm_perks::perk_unpause_all_perks();
		}
		if (level.script == "zm_prison")
		{
			level notify("intro_powerup_activate");
			level notify("cell_1_powerup_activate");
			level notify("cell_2_powerup_activate");
			flag_set("key_found");      
		}
		else if (level.script == "zm_buried")
		{
			flag_set("maze_fountain_broken");
			flag_set("courtyard_fountain_broken");  
		}
		Triggers = StrTok("zombie_door|zombie_debris|flag_blocker","|");
		for(a = 0; a < Triggers.size; a++)
		{
			Trigger = GetEntArray(Triggers[a], "targetname");
			for(b = 0 ; b < Trigger.size; b++)
			{
				Trigger[b].zombie_cost = 0;
				if (level.script == "zm_tranzit")
				{
					Trigger[b] notify("power_on");
					Trigger[b] notify("local_power_on");
				}
				Trigger[b] notify("trigger", self, 1 );
			}
		}
		setdvar("zombie_unlock_all", 0);
		self thread maps/mp/zombies/_zm_game_module::turn_power_on_and_open_doors();
		self stealth_iprintln("^2All Doors Open And Power On");
	}
	else
		self stealth_iprintln("^1Already Done!");
		
}



//----------------------------------------
//Super Jump
//----------------------------------------
	    
Toggle_SuperJump()
{
	self notify("StopSuperJump");	
	if(isDefined(self.JetPack) && self.JetPack)
	    self Toggle_JetPack();
	if(isDefined(self.DoubleJump) && self.DoubleJump)
	    self Toggle_DoubleJump();
	if(!isDefined(self.SuperJump))
		self.SuperJump = false;
	self.SuperJump = !self.SuperJump;
	if(self.SuperJump)
		self thread doSuperJump();
	self stealth_iprintln("Super Jump  " + (self.SuperJump ? "^2ON" : "^1OFF"));
}

doSuperJump()
{
	self notify("StopSuperJump");
	self endon("StopSuperJump");
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	while(isDefined(self.SuperJump) && self.SuperJump)
	{
		if(self JumpButtonPressed() && !isDefined(self.allowedtopress))
		{
			for(i = 0; i < 10; i++)
			{
				self.allowedtopress = true;
				self setVelocity(self getVelocity()+(0, 0, 999));
				wait 0.05;
			}
			self.allowedtopress = undefined;
		}
		wait 0.05;
	}
}

AddRound(round)
{
    if(!isDefined(round))
        level.round_number = 1;
    level.round_number += round;
    foreach(zombie in GetAiArray(level.zombie_team))
        zombie dodamage(zombie.health + 666, zombie.origin);
    level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier" ];
    level.zombie_vars[ "zombie_spawn_delay" ] = 0;
}















