//----------------------------------------
//GivePowerUp
//----------------------------------------

GivePowerUp_NzV(powerup_name)
{
	if (!isDefined(level.zombie_include_powerups) || (!(level.zombie_include_powerups.size > 0))) 	
		self stealth_iprintln("Power Ups ^1Not Supported ^7On This Map");
	else
	{
		level.powerup_drop_count = 0;
		powerup = level maps/mp/zombies/_zm_powerups::specific_powerup_drop(powerup_name, self.origin);
		if (powerup_name == "teller_withdrawl")
			powerup.value = 1000;
		powerup thread maps/mp/zombies/_zm_powerups::powerup_timeout();
		self stealth_iprintln("PowerUps (" + powerup_name + ") ^2Gived^7");
	}
}

//----------------------------------------
//ShootPowerUps
//----------------------------------------

Toggle_ShootPowerUps()
{
	self notify("StopShootPowerUps");
	if(!isDefined(self.ShootPowerUps))
		self.ShootPowerUps = false;
	if (!isDefined(level.zombie_include_powerups) || (level.zombie_include_powerups.size <= 0)) 	
	{
		self.ShootPowerUps = false;
		self stealth_iprintln("Power Ups ^1Not Supported ^7On This Map");
	}
	else
	{
		self.ShootPowerUps = !self.ShootPowerUps;
		if(self.ShootPowerUps)
			self thread doShootPowerUps();
		self stealth_iprintln("Shoot PowerUps " + (self.ShootPowerUps ? "^2ON" : "^1OFF"));
	}
}

doShootPowerUps()
{
	self notify("StopShootPowerUps");
	self endon("StopShootPowerUps");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended"); 
    powerups = getarraykeys(level.zombie_include_powerups);
    while(isDefined(self.ShootPowerUps) && self.ShootPowerUps)
    {
    	for(i = 0; i < powerups.size; i++)
    	{
	        self waittill("weapon_fired");
			level.powerup_drop_count = 0;
			direction_vec = anglesToForward(self getplayerangles());
			eye = self geteye();
			direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
			trace = bullettrace(eye, eye + direction_vec, 0, undefined);
			powerup = level maps/mp/zombies/_zm_powerups::specific_powerup_drop(powerups[i], trace["position"]);
			if (powerups[i] == "teller_withdrawl")
				powerup.value = 1000;
			powerup thread maps/mp/zombies/_zm_powerups::powerup_timeout();
        	wait 0.1;
    	}
    }
}








































