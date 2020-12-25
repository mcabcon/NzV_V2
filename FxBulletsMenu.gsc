//Created by CabCon 28.07.2015

/*
FxBulletsMenuUpdate()
{
	self.countmenuequip_fx = 0;
	self.countfx_p = 0;
	self add_menu("weapons_menu_bullets_fx_0", "weapons_menu_bullets", "Access Level 1");
	fxs = GetArrayKeys(level._effect);
	for(i = 0; i < fxs.size; i++)
		{
			 CreateFxBulletFunction(fxs[i]);
		} 	

}

CreateFxBulletFunction(Fx_Name)
{
		self add_option("weapons_menu_bullets_fx_" + self.countfx_p, fx_effect, ::Toggle_FxGun, Fx_Name);
		self.countmenuequip_fx++;
		if (self.countmenuequip_fx >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_bullets_fx_" + self.countfx_p, "> Next Page", ::submenu, "weapons_menu_bullets_fx_" + (self.countfx_p + 1));
			self add_menu("weapons_menu_bullets_fx_" + (self.countfx_p + 1), "weapons_menu_bullets_fx_" + self.countfx_p, "Access Level 1");
			self.countfx_p ++;
			self.countmenuequip_fx = 0;
		}
	wait .0001;
}
*/


ListfxGuns()
{
	if(!isdefined(self.fxbullets))
	{
		if(isDefined(self.expbullets) && self.expbullets)
	    	self Toggle_ExplosiveBullets();
		if(isDefined(self.telgun) && self.telgun)
	    	self Toggle_TeleportGun();
		if(isDefined(self.ricbullets) && self.ricbullets)
	    	self Toggle_RicochetBullet();
		if(isDefined(self.moddedbullets) && self.moddedbullets)
	    	self Toggle_ModdedWeaponBullets();
		if(!isDefined(self.fxgun))
			self.fxgun = false;
		if(isDefined(self.doFlameTrowher) && self.doFlameTrowher)
	    	self Toggle_FlameTrowher();
		self thread ListfxGuns_T();
		self.fxbullets = true;
		self stealth_iprintln("Fx Bullets System ^2ON^7 Press [{+actionslot 1}]/[{+actionslot 2}]");
	}
	else
	{
		self notify("Stuop_Fx_bullet_thread");
		self notify("StopFxGun");
		self.fxbullets = undefined;
		self stealth_iprintln("Fx Bullets System ^1OFF");
	}

}


ListfxGuns_T()
{
	self endon("death");
	self endon("disconnect");
	self endon("Stuop_Fx_bullet_thread");
	fxs = GetArrayKeys(level._effect);
	for(;;)
		{
			if(self actionslottwobuttonpressed())
				{
					i++;
					if(i >= fxs.size )
						i=0;
					self thread doFxGun(fxs[i]);
					self stealth_iprintln(i+" / "+fxs.size);
					wait .1;
				}
			else if(self actionslotonebuttonpressed())
				{
					i--;
					if(i <= -1)
						i=fxs.size;
					self thread doFxGun(fxs[i]);
					self stealth_iprintln(i+" / "+fxs.size);
					wait .1;
				}
			wait .0025;
		}
}

doFxGun(fx_effect)
{
	self notify("StopFxGun");
   	self endon("disconnect");
	self endon("death");
	level endon("game_ended");  
	self endon("StopFxGun");
	self stealth_iprintln("Bullet FX set to ^2"+fx_effect);
	for(;;)
	{
		self waittill("weapon_fired");
		start = self gettagorigin("tag_eye");
		end = anglestoforward(self getPlayerAngles())* 1000000;
		SPLOSIONlocation = BulletTrace(start, end, true, self)["position"];
		effect = spawnFx(level._effect[ fx_effect ] , SPLOSIONlocation);
		triggerFx(effect);
		wait 0.1;
	}
}




