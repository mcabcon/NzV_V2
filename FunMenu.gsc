
//----------------------------------------
//JetPack
//----------------------------------------

Toggle_JetPack()
{
	self notify("StopJetPack");
	if(isDefined(self.SuperJump) && self.SuperJump)
	    self Toggle_SuperJump(); 
	if(isDefined(self.DoubleJump) && self.DoubleJump)
	    self Toggle_DoubleJump();   		
	if(!isDefined(self.JetPack))
		self.JetPack = false;
	self.JetPack = !self.JetPack;
   	if(self.JetPack)
		self thread doJetPack();
	self stealth_iprintln("JetPack " + (self.JetPack ? "^2ON" : "^1OFF"));

}

doJetPack()
{
    self notify("StopJetPack");
    self endon("StopJetPack");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
    self stealth_iprintln("Press ^2[{+gostand}]^7 for use jetpack");
    JetFull = 100;
    while(isDefined(self.JetPack) && self.JetPack)
    {
        if(self jumpbuttonpressed() && JetFull > 0)
        {
			if (isDefined(level._effect["lght_marker_flare"]))
			{
	            playfxontag(level._effect["lght_marker_flare"], self, "J_Ankle_RI" );
	            playfxontag(level._effect["lght_marker_flare"], self, "J_Ankle_LE" );
            }
            earthquake(0.15, 0.2, self gettagorigin("j_spine4"), 50);
            JetFull--;
            if(self getvelocity()[2] < 300)
            	self setvelocity(self getvelocity() + (0, 0, 90));  	
        }
        else if(JetFull < 100)
        	JetFull++;
        wait 0.1;
    }
}

//----------------------------------------
//Drunk
//----------------------------------------

Toggle_Drunk()
{
	self notify("StopDrunkMode");    		
	if(!isDefined(self.DrunkMode))
		self.DrunkMode = false;
	self.DrunkMode = !self.DrunkMode;
   	if(self.DrunkMode)
		self thread doDrunkMode();
	else
	{
        self EnableOffhandWeapons();
        self EnableWeaponCycling();
        self AllowLean(true);
        self AllowAds(true);
        self AllowSprint(true);
        self AllowProne(true);
        self AllowMelee(true);
        self setPlayerAngles(self.angles + (0, 0, 0));
        self setBlur(0, 1.0);
	}
	self stealth_iprintln("Drunk Mode " + (self.DrunkMode ? "^2ON" : "^1OFF"));

}

doGivePerkAnim(perk)
{
	self endon("disconnect");
	self endon("end_game");
	self endon("perk_abort_drinking");
	gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin(perk);
	evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
	if (evt == "weapon_change_complete")
		self maps/mp/zombies/_zm_perks::perk_give_bottle_end(gun, perk);
	self notify("burp");
}

doDrunkMode()
{
	self notify("StopDrunkMode");  
    self endon("StopDrunkMode");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
	 	self doGivePerkAnim("specialty_armorvest");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	  self doGivePerkAnim("specialty_fastreload");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	   self doGivePerkAnim("specialty_quickrevive");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk)  
	   self doGivePerkAnim("specialty_rof");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	    self doGivePerkAnim("specialty_longersprint");
	if(isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_additionalprimaryweapon_perk ) && level.zombiemode_using_additionalprimaryweapon_perk)
		self doGivePerkAnim("specialty_additionalprimaryweapon");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	    self doGivePerkAnim("specialty_deadshot");
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
		self doGivePerkAnim("specialty_scavenger");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_flakjacket"]) && (level.script != "zm_buried"))
		self doGivePerkAnim("specialty_flakjacket"); 
	if ((level.script == "zm_buried") && isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_nomotionsensor"]))
		self doGivePerkAnim("specialty_nomotionsensor");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_grenadepulldeath"]))
		self doGivePerkAnim("specialty_grenadepulldeath"); 
	if (isDefined(self.DrunkMode) && self.DrunkMode && isDefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
		self doGivePerkAnim("specialty_finalstand");
    while(isDefined(self.DrunkMode) && self.DrunkMode)
    {
            self setPlayerAngles(self.angles+(0,0,0));
            wait 0.1;
            self setstance("prone");
            wait 0.1;
            self SetBlur(10.3,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,5));
            wait 0.1;
            self setstance("stand");
            wait 0.1;
            self SetBlur(9.1,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,10));
            wait 0.1;
            self setstance("prone");
            wait 0.1;
            self SetBlur(6.2,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,15));
            wait 0.1;
            self setBlur(5.2,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,20));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,25));
            wait 0.1;
            self setBlur(4.2,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,30));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,35));
            wait 0.1;
            self setBlur(3.2,1.0);
            wait 0.1;
            self setstance("crouch");
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,30));
            wait 0.1;
            self setstance("prone");
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,25));
            wait 0.1;
            self setBlur(2.2,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,20));
            wait 0.1;
            self setstance("crouch");
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,15));
            wait 0.1;
            self setBlur(1.2,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,10));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,5));
            wait 0.1;
            self setBlur(0.5,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-5));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-10));
            wait 0.1;
            self setBlur(0,1.0);
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-15));
            wait 0.1;
            self setstance("prone");
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-20));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-25));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-30));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-35));
            wait 0.1;
            self setstance("stand");
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-30));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-25));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-20));
            wait 0.1;
            self setstance("crouch");
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-15));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-10));
            wait 0.1;
            self setPlayerAngles(self.angles+(0,0,-5));
            wait 0.1;
    }
}

//----------------------------------------
//FlashingPlayer
//----------------------------------------
		
Toggle_FlashingPlayer()
{
	self notify("StopFlashingPlayer");  		
	if(isDefined(self.Invisible) && self.Invisible)
		self.Invisible = false;
	if(!isDefined(self.FlashingPlayer))
		self.FlashingPlayer = false;
	self.FlashingPlayer = !self.FlashingPlayer;
   	if(self.FlashingPlayer)
		self thread doFlashyPlayer();
	else
		self show();
	self stealth_iprintln("Flashing Player " + (self.FlashingPlayer ? "^2ON" : "^1OFF"));

}

doFlashyPlayer()
{
	self notify("StopFlashingPlayer");
	self endon("StopFlashingPlayer");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
    while(isDefined(self.FlashingPlayer) && self.FlashingPlayer)
	{
		self show();
		wait 0.3;
		self hide();
		wait 0.3;
	}
}

//----------------------------------------
//RotateAngles
//----------------------------------------

Toggle_RotateAngles()
{  		
	if(!isDefined(self.RotateAng))
		self.RotateAng = false;
	self.RotateAng = !self.RotateAng;
   	if(self.RotateAng)
   	{
		a = self getPlayerAngles();
		self setPlayerAngles((a[0], a[1], a[2] + 90));
   	}
	else 
		self setPlayerAngles(self.angles + (0, 0, 0));
	self.RotateAng = !self.RotateAng;
	self stealth_iprintln("Angle Rotate " + (self.RotateAng ? "^2ON" : "^1OFF"));

}

//----------------------------------------
//AutoDropShot
//----------------------------------------

Toggle_AutoDropShot() 
{
    self notify("StopAutoDropShot");
	if(!isDefined(self.AutoDropShot))
		self.AutoDropShot = false;
	self.AutoDropShot = !self.AutoDropShot;
	if(self.AutoDropShot)
       self thread doAutoDropShot();
	self stealth_iprintln("Auto Drop-Shot " + (self.AutoDropShot ? "^2ON" : "^1OFF"));
}

doAutoDropShot()
{
    self notify("StopAutoDropShot");
    self endon("StopAutoDropShot");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
    while(isDefined(self.AutoDropShot) && self.AutoDropShot)
    {
        self waittill ("weapon_fired");
        if (self GetStance() != "prone")
        	self setStance("prone");
        wait 0.1;
    }
}

//----------------------------------------
//Centipede
//----------------------------------------

Toggle_Centipede() 
{
    self notify("StopCentipede");
	if(isdefined(level.CentipedeEntities))
    {
		for(i = 0; i <= 25; i++)
		{
			if(isdefined(level.CentipedeEntities[i]))
		    {
		        level.CentipedeEntities[i] delete();
		        level.CentipedeEntities[i] = undefined;
		    }
		}
    }
	if(!isDefined(self.Centipede))
		self.Centipede = false;
	self.Centipede = !self.Centipede;
	if(self.Centipede)
       self thread doCentipede();
	self stealth_iprintln("Centipede " + (self.Centipede ? "^2ON" : "^1OFF"));
}

doCentipede()
{
    self notify("StopCentipede");
	self endon("StopCentipede");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(!isdefined(level.CentipedeEntities))
    	level.CentipedeEntities = [];
    if(!isdefined(level.CountCentipedeEntities))
        level.CountCentipedeEntities = 0;
    while(isDefined(self.Centipede) && self.Centipede)
	{
	    if(level.CountCentipedeEntities >= 25)
	        level.CountCentipedeEntities = 0;
		if(isdefined(level.CentipedeEntities[level.CountCentipedeEntities]))
	    {
	        level.CentipedeEntities[level.CountCentipedeEntities] delete();
	        level.CentipedeEntities[level.CountCentipedeEntities] = undefined;
	    }
		level.CentipedeEntities[level.CountCentipedeEntities] = self ClonePlayer(9999999);
	    level.CentipedeEntities[level.CountCentipedeEntities] thread DestroyModelOnTime(2);
	    level.CountCentipedeEntities++;
		wait 0.1;
	}
}

DestroyModelOnTime(time)
{
	wait(time);
	if(isdefined(self))
	{
		self delete();
		self = undefined;
	}
}

//----------------------------------------
//StalkerPro
//----------------------------------------

Toggle_StalkerPro() 
{
    self notify("StopStalkerPro");
	if(!isDefined(self.StalkerPro))
		self.StalkerPro = false;
	self.StalkerPro = !self.StalkerPro;
	if(self.StalkerPro)
       	self thread doStalkerPro();
    else
		self setMoveSpeedScale(1);
	self stealth_iprintln("Stalker Pro " + (self.StalkerPro ? "^2ON" : "^1OFF"));
} 
	
doStalkerPro()
{
    self notify("StopStalkerPro");
	self endon("StopStalkerPro");
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self iPrintln("Hold [{+speed_throw}] And Walk");
    while(isDefined(self.StalkerPro) && self.StalkerPro)
	{
		if(self AdsButtonPressed()) 
			self setMoveSpeedScale(3);
		else
			self setMoveSpeedScale(1);
		wait 0.1;
	}
}

//----------------------------------------
//SaveAndLoad
//----------------------------------------

Toggle_SaveAndLoad() 
{
    self notify("StopSaveAndLoad");
	if(!isDefined(self.SaveAndLoad))
		self.SaveAndLoad = false;
	self.SaveAndLoad = !self.SaveAndLoad;
	if(self.SaveAndLoad)
       	self thread doSaveAndLoad();
	self.SaveAndLoad = !self.SaveAndLoad;
	self stealth_iprintln("Save And Load " + (self.SaveAndLoad ? "^2ON" : "^1OFF"));
} 

doSaveAndLoad()
{
    self notify("StopSaveAndLoad");
	self endon("StopSaveAndLoad");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	saveandloadL = false;
	saveandloadO = self.origin;
	saveandloadA = self.angles;
	self stealth_iprintln("Press [{+actionslot 3}] To Save Position.");
	self stealth_iprintln("Press [{+actionslot 4}] To Save Load Position.");
	self stealth_iprintln("^1Only works when menu was closed!");
    while(isDefined(self.SaveAndLoad) && self.SaveAndLoad)
	{
		if(self actionslotthreebuttonpressed() && (self.menu.open == false))
		{
			saveandloadL = true;
			saveandloadO = self.origin;
			saveandloadA = self.angles;
			self stealth_iprintln("Position ^2Saved");
		}
		else if(self actionslotfourbuttonpressed() && saveandloadL && (self.menu.open == false))
		{	
			saveandloadL = false;
			self setOrigin(saveandloadO);
			self setPlayerAngles(saveandloadA);
			self stealth_iprintln("Position ^1Loaded");	
		}
		wait 0.1;
	}
}

//----------------------------------------
//SkullProtector
//----------------------------------------

Toggle_SkullProtector() 
{
    self notify("StopSkullProtector");
    if(isDefined(self.Skullix))
    {
        self.Skullix delete();
        self.Skullix = undefined;
    }
    if(isDefined(self.SkullixFX))
    {
        self.SkullixFX delete();
        self.SkullixFX = undefined;
    }
	if(!isDefined(self.SkullProtector))
		self.SkullProtector = false;
	self.SkullProtector = !self.SkullProtector;
	if(self.SkullProtector)
       	self thread doSkullProtector();   
	self stealth_iprintln("Skull Protector " + (self.SkullProtector ? "^2ON" : "^1OFF"));
} 

doSkullProtector()
{
    self notify("StopSkullProtector");
    self endon("StopSkullProtector");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
    if(isDefined(self.Skullix))
    {
        self.Skullix delete();
        self.Skullix = undefined;
    }
    if(isDefined(self.SkullixFX))
    {
        self.SkullixFX delete();
        self.SkullixFX = undefined;
    }
    self.Skullix = spawn("script_model", self.origin + (0, 0, 95));
    self.Skullix SetModel("zombie_skull");
    self.Skullix.angles = self.angles + (0, 90, 0);
	if (isDefined(level._effect["powerup_on"]))
		playfxontag(level._effect["powerup_on"], self.Skullix, "tag_origin");
    while(isDefined(self.SkullProtector) && self.SkullProtector)
    {
        self.Skullix.origin = self.origin + (0, 0, 95);
        self.Skullix.angles = self.angles + (0, 90, 0);
        Enemy = GetAiSpeciesArray("axis","all");
        for(i = 0; i < Enemy.size; i++)
        {
	        self.Skullix.origin = self.origin + (0, 0, 95);
	        self.Skullix.angles = self.angles + (0, 90, 0);
            if(Distance(Enemy[i].origin, self.origin) < 350)
            {
				self.SkullixFX = spawn("script_model", self.Skullix.origin);
	        	self.SkullixFX.angles = self.Skullix.angles;
				self.SkullixFX SetModel("tag_origin");
				self.SkullixFX PlaySound("mus_raygun_stinger");
				if (isDefined(level._effect["powerup_on"]))
					playfxontag(level._effect["powerup_on"], self.SkullixFX, "tag_origin");
				self.SkullixFX MoveTo(Enemy[i] GetTagOrigin("J_Head"), 1);
    			self.SkullixFX waittill("movedone");
		        self.Skullix.origin = self.origin + (0, 0, 95);
		        self.Skullix.angles = self.angles + (0, 90, 0);
				Enemy[i] maps\mp\zombies\_zm_spawner::zombie_head_gib();
				Enemy[i] dodamage(Enemy[i].health + 666, Enemy[i].origin, self);
			    if(isDefined(self.SkullixFX))
			    {
			        self.SkullixFX delete();
			        self.SkullixFX = undefined;
			    }
            }
        }
        wait 0.05;
    }
}

//----------------------------------------
//Send Kamikaze
//----------------------------------------

SendKamikaze()
{
   	self stealth_iprintln("Kamikaze ^2Send ^7 To Your Position");
    kam = spawn("script_model", self.origin + (5000, 1000, 10000));
    kam setmodel("defaultvehicle");
    kam.angles = VectorToAngles((kam.origin) - (self.origin)) - (180,0,180);
    kam moveto(self.origin, 3.5, 2, 1.5);
    kam waittill("movedone");
    Earthquake(2.5, 2, kam.origin, 300);
	if (isDefined(level._effect["thunder"]))
    	playfx(level._effect["thunder"], kam.origin);
    else if (isDefined(level.zombie_powerups) && isDefined(level.zombie_powerups["nuke"]) && isDefined(level.zombie_powerups["nuke"].fx))
		playfx(level.zombie_powerups["nuke"].fx, kam.origin);
	if (isDefined(level._effect["def_explosion"]))
	{
   		playfx(level._effect["def_explosion"], kam.origin);
   		playfx(level._effect["def_explosion"], kam.origin + (0, 20, 50));
	}
	kam playSound("evt_nuked");
    Earthquake(3, 2, kam.origin, 500);
    RadiusDamage(kam.origin, 500, 1000, 300, self, "MOD_GRENADE_SPLASH");
    kam delete();
}

//----------------------------------------
//GoreMode
//----------------------------------------

Toggle_GoreMode() 
{
    self notify("StopGoreMode");
	if(!isDefined(self.GoreMode))
		self.GoreMode = false;
	if(!isDefined(level._effect["headshot"]) || !isDefined(level._effect["bloodspurt"]))
	{
		self.GoreMode = false;
		self stealth_iprintln("Gore Mode ^1Not Supported ^7On This Map");
	}
	else
	{
		if(isDefined(self.ElectricMan) && self.ElectricMan)
			Toggle_ElectricMan();
		self.GoreMode = !self.GoreMode;
		if(self.GoreMode)
	       	self thread doGoreMode();  
		self stealth_iprintln("Gore Mode " + (self.GoreMode ? "^2ON" : "^1OFF"));
	}
} 

doGoreMode()
{
    self notify("StopGoreMode");
	self endon("StopGoreMode");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	if(!isDefined(level._effect["headshot"]) || !isDefined(level._effect["bloodspurt"]))
		return;
    while(isDefined(self.GoreMode) && self.GoreMode)
    {
		playfxontag(level._effect["headshot"], self, "J_Head");
        playfxontag(level._effect["headshot"], self, "J_Neck");
		playfxontag(level._effect["headshot"], self, "J_SpineUpper");
		playfxontag(level._effect["headshot"], self, "J_SpineLower");
		playfxontag(level._effect["headshot"], self, "J_Elbow_RI");
		playfxontag(level._effect["headshot"], self, "J_Elbow_LE");
		playfxontag(level._effect["headshot"], self, "J_Knee_LE");
		playfxontag(level._effect["headshot"], self, "J_Knee_RI");
		playfxontag(level._effect["headshot"], self, "J_Ankle_LE");
		playfxontag(level._effect["headshot"], self, "J_Ankle_RI");
		playfxontag(level._effect["headshot"], self, "J_Wrist_RI");
		playfxontag(level._effect["headshot"], self, "J_Wrist_LE");
		playfxontag(level._effect["headshot"], self, "J_Shoulder_LE");
		playfxontag(level._effect["headshot"], self, "J_Shoulder_RI");
		playfxontag(level._effect["bloodspurt"], self, "J_Head");
        playfxontag(level._effect["bloodspurt"], self, "J_Neck");
		playfxontag(level._effect["bloodspurt"], self, "J_SpineUpper");
		playfxontag(level._effect["bloodspurt"], self, "J_SpineLower");
		playfxontag(level._effect["bloodspurt"], self, "J_Elbow_RI");
		playfxontag(level._effect["bloodspurt"], self, "J_Elbow_LE");
		playfxontag(level._effect["bloodspurt"], self, "J_Knee_LE");
		playfxontag(level._effect["bloodspurt"], self, "J_Knee_RI");
		playfxontag(level._effect["bloodspurt"], self, "J_Ankle_LE");
		playfxontag(level._effect["bloodspurt"], self, "J_Ankle_RI");
		playfxontag(level._effect["bloodspurt"], self, "J_Wrist_RI");
		playfxontag(level._effect["bloodspurt"], self, "J_Wrist_LE");
		playfxontag(level._effect["bloodspurt"], self, "J_Shoulder_LE");
		playfxontag(level._effect["bloodspurt"], self, "J_Shoulder_RI");
        wait 0.1;
    }       
}

//----------------------------------------
//Send Earth Quake
//----------------------------------------

SendEarthQuake()
{ 
   earthquake(0.6, 10, self.origin, 100000);
   self iPrintln("Earth Quake ^2Done");
}


//----------------------------------------
//AimBot
//----------------------------------------

Toggle_AimBot() 
{
    self notify("StopAimBot");
	if(!isDefined(self.AimBot))
		self.AimBot = false; 
	self.AimBot = !self.AimBot;
	if(self.AimBot)
       	self thread doAimBot();   
	self stealth_iprintln("Aim Bot " + (self.AimBot ? "^2ON" : "^1OFF"));
} 

doAimBot()
{
    self notify("StopAimBot");
    self endon("StopAimBot");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
    self.Aim_Shoot = false;
    self thread doAimBotFire();
    while(isDefined(self.AimBot) && self.AimBot)
    {
    	while(self adsButtonPressed())
        {
            zom = getClosest(self getOrigin(), getAiSpeciesArray("axis","all"));
            self setplayerangles(VectorToAngles((zom getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
            if(self.Aim_Shoot)
            {
            	self.Aim_Shoot = false;  
            	magicBullet(self getCurrentWeapon(), zom getTagOrigin("j_head") + (0, 0, 5), zom getTagOrigin("j_head"), self);        	
            }
            wait 0.05;
        }
        self.Aim_Shoot = false;  
        wait 0.05;
    }
}

doAimBotFire()
{
    self notify("StopAimBotF");
    self endon("StopAimBot");
    self endon("StopAimBotF");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
    while(isDefined(self.AimBot) && self.AimBot)
    {
        self waittill("weapon_fired");
        self.Aim_Shoot = true;
        wait 0.05;
    }
}

//----------------------------------------
//ElectricMan
//----------------------------------------

Toggle_ElectricMan() 
{
    self notify("StopElectricMan");
	if(!isDefined(self.ElectricMan))
		self.ElectricMan = false;
	if(!isDefined(level._effect["elec_torso"]))
	{
		self.ElectricMan = false;
		self stealth_iprintln("Electric Man ^1Not Supported ^7On This Map");
	}		
	else
	{
		if(isDefined(self.GoreMode) && self.GoreMode)
			Toggle_GoreMode();
		self.ElectricMan = !self.ElectricMan;
		if(self.ElectricMan)
	       	self thread doElectricMan();   
		self stealth_iprintln("Electric Man " + (self.ElectricMan ? "^2ON" : "^1OFF"));
    }
} 

doElectricMan()
{
    self notify("StopElectricMan");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
    self endon("StopElectricMan");
	if(!isDefined(level._effect["elec_torso"]))
		return;
    while(isDefined(self.ElectricMan) && self.ElectricMan)
	{
		playfxontag(level._effect["elec_torso"], self, "J_Head");
        playfxontag(level._effect["elec_torso"], self, "J_Neck");
		playfxontag(level._effect["elec_torso"], self, "J_SpineUpper");
		playfxontag(level._effect["elec_torso"], self, "J_SpineLower");
		playfxontag(level._effect["elec_torso"], self, "J_Elbow_RI");
		playfxontag(level._effect["elec_torso"], self, "J_Elbow_LE");
		playfxontag(level._effect["elec_torso"], self, "J_Knee_LE");
		playfxontag(level._effect["elec_torso"], self, "J_Knee_RI");
		playfxontag(level._effect["elec_torso"], self, "J_Ankle_LE");
		playfxontag(level._effect["elec_torso"], self, "J_Ankle_RI");
		playfxontag(level._effect["elec_torso"], self, "J_Wrist_RI");
		playfxontag(level._effect["elec_torso"], self, "J_Wrist_LE");
		playfxontag(level._effect["elec_torso"], self, "J_Shoulder_LE");
		playfxontag(level._effect["elec_torso"], self, "J_Shoulder_RI");
		wait 0.1;
	}
}

//----------------------------------------
//SetVision
//----------------------------------------

SetVision(vision)
{
	if(vision == "default")
	{
		self useServerVisionSet(false);
		self SetVisionSetforPlayer(vision, 0);
	}
	else 
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer(vision, 0); 
	}
	self stealth_iprintln("Vision Set To ^2" + vision);
}
















func_moveMenu(i)
{
	if(!isDefined(self.cabcon_move))
		self.cabcon_move = 0;
	
	self.cabcon_move += i;
	
	self.menu.root MoveOverTime(0.1);
	self.menu.background MoveOverTime(0.1);
	self.menu.bar MoveOverTime(0.1);
	self.menu.borderLeft MoveOverTime(0.1);
	self.menu.borderRight MoveOverTime(0.1);
	self.menu.ConfusionText MoveOverTime(0.1);
	self.menu.ConfusionText2 MoveOverTime(0.1);
	self.Private["options"] MoveOverTime(0.1);
	
	self.menu.root.x += i;
	self.menu.background.x += i;
	self.menu.bar.x += i;
    self.menu.borderLeft.x += i;
	self.menu.borderRight.x += i;
	self.menu.ConfusionText.x += i;
	self.menu.ConfusionText2.x += i;
	self.Private["options"].x += i;
	
	wait i/100;
	S("Menu Postion Move ^2"+self.cabcon_move);
}



