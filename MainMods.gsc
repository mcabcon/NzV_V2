//----------------------------------------
//GodMod
//----------------------------------------

Toggle_GodMod_NzV()
{
	self notify("StopUnlimitedLives");
	if(!isDefined(self.GodMod_NzV))
		self.GodMod_NzV = false;
	self.GodMod_NzV = !self.GodMod_NzV;
	if(self.GodMod_NzV)
	{
		self.premaxhealth = 9999;
		self.maxhealth = self.maxhealth;
		self setmaxhealth(self.premaxhealth);
		self.health = self.maxhealth;
		self EnableInvulnerability();
		
        if (isDefined(level.player_out_of_playable_area_monitor) && level.player_out_of_playable_area_monitor)
        	self notify("stop_player_out_of_playable_area_monitor");
        	
		if (level.script == "zm_prison")
	    {
			self.infinite_mana = 1;
			self thread UnlimitedLives();
		}
	}
	else
	{
		self.premaxhealth= 100;
		self.maxhealth = self.maxhealth;
		self setmaxhealth(self.premaxhealth);
		if (self hasperk("specialty_armorvest"))
		{
			self.maxhealth = level.zombie_vars[ "zombie_perk_juggernaut_health" ];
		}
		self setmaxhealth(self.maxhealth);
		self.health = self.maxhealth;
		self DisableInvulnerability();
		
        /*if (isDefined(level.player_out_of_playable_area_monitor) && level.player_out_of_playable_area_monitor)
		{
			self notify("stop_player_out_of_playable_area_monitor");
			self thread maps/mp/zombies/_zm::player_out_of_playable_area_monitor();
		}*/
		
		if (level.script == "zm_prison")
				self.infinite_mana = 0;
				
	}
	self stealth_iprintln("GodMod " + self.GodMod_NzV ? "^2ON" : "^1OFF");
}

UnlimitedLives()
{   
    self notify("StopUnlimitedLives");
    self endon("StopUnlimitedLives");
    self endon("disconnect");
	level endon("game_ended");
    while(isDefined(self.GodMod_NzV) && self.GodMod_NzV)
    {
        self waittill_any("fake_death", "death", "player_downed");
        if (isDefined(level.is_forever_solo_game) && level.is_forever_solo_game) 
        {
        	self.lives = 3;
        	level.solo_lives_given = 0;
        }
		else
			self.lives = 1;
        
    }
    
}

//----------------------------------------
//Show FPS
//----------------------------------------

Toggle_ShowFPS() 
{
	if(!isDefined(self.ShowFPS))
		self.ShowFPS = false;
	self.ShowFPS = !self.ShowFPS;
	if(self.ShowFPS)
       setDvar("cg_drawBigFPS", "1"); 
    else
       setDvar("cg_drawBigFPS", "0"); 
	self stealth_iprintln("Show FPS " + (self.ShowFPS ? "^2ON" : "^1OFF"));
}

//----------------------------------------
//AddScore
//----------------------------------------

AddScore(score)
{
    if(!isDefined(score))
	   	score = (0 - self.score);
    else if ( 0 > (self.score + score))
	    score = (0 - self.score);
	self.score += score;
    if (self.score > self.max_score)
    	self.max_score = self.score; 
 	self stealth_iprintln("Score Set To ^2" + self.score);
}

//----------------------------------------
//3rdPerson
//----------------------------------------

Toggle_3rdPerson() 
{
	if(!isDefined(self.tard))
		self.tard = false;
	self.tard = !self.tard;
	if(self.tard)
       self setclientthirdperson(1);
    else
       self setclientthirdperson(0);
	self stealth_iprintln("Third Person " + (self.tard ? "^2ON" : "^1OFF"));
}

//----------------------------------------
//CloneMe
//----------------------------------------

CloneMe()
{
    if(!isDefined(level.CLonePlayersEntities) )
    	level.CLonePlayersEntities = [];
    if(!isDefined(level.CountCLonePlayersEntities))
        level.CountCLonePlayersEntities = 0;
    if(level.CountCLonePlayersEntities >= 20)
        level.CountCLonePlayersEntities = 0;
    if(isDefined(level.CLonePlayersEntities[level.CountCLonePlayersEntities]))
    {
        level.CLonePlayersEntities[level.CountCLonePlayersEntities] delete();
        level.CLonePlayersEntities[level.CountCLonePlayersEntities] = undefined;
    }
	level.CLonePlayersEntities[level.CountCLonePlayersEntities] =  self ClonePlayer(9999);
    level.CountCLonePlayersEntities++;
   	self stealth_iprintln("Clone ^2Spawned");
}

//----------------------------------------
//Invisible
//----------------------------------------

Toggle_Invisi() 
{
	if(isDefined(self.FlashingPlayer) && self.FlashingPlayer)
		Toggle_FlashingPlayer();
	if(!isDefined(self.Invisible))
		self.Invisible = false;
	self.Invisible = !self.Invisible;
	if(self.Invisible)
       	self hide();
    else
        self show();
	self stealth_iprintln("Invisible " + (self.Invisible ? "^2ON" : "^1OFF"));
}

//----------------------------------------
//Suicide
//----------------------------------------

doSuicide()
{
	if(isAlive(player))
	{
		if(isDefined(self.GodMod_NzV) && self.GodMod_NzV)
		    self Toggle_GodMod_NzV();
		self disableInvulnerability();
		self doDamage(self.maxhealth + 666, self.origin);
		self.bleedout_time = 0;
		self stealth_iprintln("Your are ^2Dead");
	}
	else
		self stealth_iprintln("Your are ^1 Already ^2Dead");
}

//----------------------------------------
//Move Speed
//----------------------------------------

MySetMoveSpeedScale(movespeed)
{
   	self setMoveSpeedScale(movespeed);
	self stealth_iprintln("Move Speed x" + movespeed);
}

//----------------------------------------
//Sprint Duration
//----------------------------------------

MySetSprintDuration(sprintduration)
{
   	self SetSprintDuration(sprintduration);
	self stealth_iprintln("Sprint Duration x" + sprintduration);
}

//----------------------------------------
//Sprint Cooldown
//----------------------------------------

MySetSprintCooldown(sprintcooldown)
{
   	self SetSprintCooldown(sprintcooldown);
	self stealth_iprintln("Sprint Cooldown x" + sprintcooldown);
}

//----------------------------------------
//Double Jump
//----------------------------------------

Toggle_DoubleJump()
{
	self notify("StopDoubleJump");	
	if(isDefined(self.JetPack) && self.JetPack)
	   self Toggle_JetPack();
	if(isDefined(self.SuperJump) && self.SuperJump)
	    self Toggle_SuperJump();
	if(!isDefined(self.DoubleJump))
		self.DoubleJump = false;
	self.DoubleJump = !self.DoubleJump;
	if(self.DoubleJump)
		self thread doDoubleJump();
	self stealth_iprintln("Double Jump  " + (self.DoubleJump ? "^2ON" : "^1OFF"));
}

doDoubleJump()
{
	self notify("StopDoubleJump");
    self endon("StopDoubleJump");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended"); 
	while(isDefined(self.DoubleJump) && self.DoubleJump)
    {
        if(self GetVelocity()[2]>150 && !self isOnGround())
        {
                wait .2;
                self setvelocity((self getVelocity()[0], self getVelocity()[1], self getVelocity()[2])+(0,0,250));
                wait .8;
        }
        wait .001;
    }
}

//----------------------------------------
//UFO Mode
//----------------------------------------

Toggle_UFOMode()
{
	self notify("StopUFOMode");	
	if(isDefined(self.NoClip) && self.NoClip)
	    self Toggle_NoClip();
	if(!isDefined(self.UFOMode))
		self.UFOMode = false;
	self.UFOMode = !self.UFOMode;
	if(self.UFOMode)
		self thread doUFOMode();
	else 
	{
		self unlink();
		if(isDefined(self.UFOEntity))
		{
    		self.UFOEntity delete();
    		self.UFOEntity = undefined;
		}
	}
	self stealth_iprintln("UFO Mode " + (self.UFOMode ? "^2ON" : "^1OFF"));
}

doUFOMode()
{
    self notify("StopUFOMode");
	if(isDefined(self.UFOEntity))
	{
		self.UFOEntity delete();
		self.UFOEntity = undefined;
	}
    self endon("StopUFOMode");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
    self.UFOEntity = spawn("script_model", self.origin);
    Fly = 0;
   	self stealth_iprintln("Press [{+frag}] To Fly");
    while(isDefined(self.UFOMode) && self.UFOMode)
    {
        if(self FragButtonPressed())
        {
                self playerLinkTo(self.UFOEntity);
                Fly = 1;
        }
        else
        {
                self unlink();
                Fly = 0;
        }
        if(Fly !=0)
                self.UFOEntity moveTo(self.origin + vector_scale(anglesToForward(self getPlayerAngles()),40), 0.01);
        wait 0.1;
    }
}

//----------------------------------------
//No Clip
//----------------------------------------

Toggle_NoClip()
{
	self notify("StopNoClip");	
	if(!isDefined(self.NoClip))
		self.NoClip = false;
	if(isDefined(self.UFOMode) && self.UFOMode)
	    self Toggle_UFOMode();
	self.NoClip = !self.NoClip;
    if(self.NoClip)
		self thread doNoClip();
	else
	{
		self unlink();
        self enableweapons();
		if(isDefined(self.NoClipEntity))
		{
    		self.NoClipEntity delete();
    		self.NoClipEntity = undefined;
		}    	
	}
	self stealth_iprintln("NoClip " + (self.NoClip ? "^2ON" : "^1OFF"));
}

doNoClip()
{
    self notify("StopNoClip");
	if(isDefined(self.NoClipEntity))
	{
		self.NoClipEntity delete();
		self.NoClipEntity = undefined;
	}   
    self endon("StopNoClip");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");
    self.NoClipEntity = spawn( "script_origin", self.origin, 1);
    self.NoClipEntity.angles = self.angles;
    self playerlinkto(self.originObj, undefined);
    NoClipFly = false;
	self stealth_iprintln("Press [{+smoke}] To ^2Enable ^7NoClip.");
	self stealth_iprintln("Press [{+gostand}] To Move Fast.");
	self stealth_iprintln("Press [{+stance}] To ^1Disable ^7NoClip.");
    while(isDefined(self.NoClip) && self.NoClip)
    {
        if(self secondaryOffhandButtonPressed() && !NoClipFly)
        {
    		self disableweapons();
            self playerLinkTo(self.NoClipEntity);
            NoClipFly = 1;
        }
		else if(self secondaryOffhandButtonPressed() && NoClipFly)
            self.NoClipEntity moveTo(self.origin + vector_scale(anglesToForward(self getPlayerAngles()),30), .01);
		else if(self jumpButtonPressed() && NoClipFly)
            self.NoClipEntity moveTo(self.origin + vector_scale(anglesToForward(self getPlayerAngles()),170), .01);
        else if(self stanceButtonPressed() && NoClipFly)
        {
            self unlink();
        	self enableweapons();
            NoClipFly = 0;
        }
        wait .01;
    }
}
