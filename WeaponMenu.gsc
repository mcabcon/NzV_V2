GiveWeapon_NzV(weapon)
{
	if ((level.script == "zm_prison") && issubstr(weapon, "tomahawk_zm"))
	{
		self play_sound_on_ent("purchase");
		self notify("tomahawk_picked_up");
		level notify("bouncing_tomahawk_zm_aquired");
		self notify("player_obtained_tomahawk");
		if (weapon == "bouncing_tomahawk_zm")
		{
			self.tomahawk_upgrade_kills = 0;
			self.killed_with_only_tomahawk = 1;
			self.killed_something_thq = 0;
		}
		else
		{
			self.tomahawk_upgrade_kills = 99;
			self.killed_with_only_tomahawk = 1;
			self.killed_something_thq = 1;
			self notify("tomahawk_upgraded_swap");
		}
		old_tactical = self get_player_tactical_grenade();
		if (isDefined(old_tactical) && old_tactical != "none" )
			self takeweapon(old_tactical);
		self set_player_tactical_grenade(weapon);
		self.current_tomahawk_weapon = weapon;
		gun = self getcurrentweapon();
		self disable_player_move_states(1);
		self giveweapon("zombie_tomahawk_flourish");
		self switchtoweapon("zombie_tomahawk_flourish");
		self waittill_any("player_downed", "weapon_change_complete");
		self switchtoweapon(gun);
		self enable_player_move_states();
		self takeweapon("zombie_tomahawk_flourish");
		self giveweapon(weapon);
		self givemaxammo(weapon);
		if (gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun))
		{
			self switchtoweapon(gun);
			self waittill("weapon_change_complete");
		}
		else
		{
			primaryweapons = self getweaponslistprimaries();
			if (isDefined(primaryweapons) && primaryweapons.size > 0)
			{
				self switchtoweapon(primaryweapons[0]);
				self waittill("weapon_change_complete");
			}
		}
		self play_weapon_vo(weapon);
	}
	else if ((level.script == "zm_prison") && (weapon == "willy_pete_zm"))
	{
		self play_sound_on_ent("purchase");
		gun = self getcurrentweapon();
		old_tactical = self get_player_tactical_grenade();
		if (isDefined(old_tactical) && old_tactical != "none" )
			self takeweapon(old_tactical);
		self set_player_tactical_grenade(weapon);
		self giveweapon(weapon);
		self givemaxammo(weapon);
		if (gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun))
		{
			self switchtoweapon(gun);
			self waittill("weapon_change_complete");
		}
		else
		{
			primaryweapons = self getweaponslistprimaries();
			if (isDefined(primaryweapons) && primaryweapons.size > 0)
			{
				self switchtoweapon(primaryweapons[0]);
				self waittill("weapon_change_complete");
			}
		}
		self play_weapon_vo(weapon);
	}
	else if ((level.script == "zm_buried") && (weapon == "time_bomb_zm"))
		self maps/mp/zombies/_zm_weapons::weapon_give(weapon, undefined, undefined, 0);
	else if ((level.script == "zm_tomb") && issubstr(weapon, "one_inch_punch"))
	{
		self play_sound_on_ent("purchase");
		gun = self getcurrentweapon();
		self disable_player_move_states(1);
		if (weapon == "one_inch_punch_zm")
		{
			self.b_punch_upgraded = 0;
			self giveweapon("zombie_one_inch_punch_flourish");
			self switchtoweapon("zombie_one_inch_punch_flourish");
		}
		else
		{
			self.b_punch_upgraded = 1;
			if (weapon == "one_inch_punch_air_zm")
				self.str_punch_element = "air";
			else if (weapon == "one_inch_punch_fire_zm")
				self.str_punch_element = "fire";
			else if (weapon == "one_inch_punch_ice_zm")
				self.str_punch_element = "ice";
			else if (weapon == "one_inch_punch_lightning_zm")
				self.str_punch_element = "lightning";
			else if (weapon == "one_inch_punch_upgraded_zm")
				self.str_punch_element = "upgraded";
			self giveweapon("zombie_one_inch_punch_upgrade_flourish");
			self switchtoweapon("zombie_one_inch_punch_upgrade_flourish");
		}
		self waittill_any("player_downed", "weapon_change_complete");
		self enable_player_move_states();
		if (weapon == "one_inch_punch_zm")
			self takeweapon("zombie_one_inch_punch_flourish");
		else
			self takeweapon("zombie_one_inch_punch_upgrade_flourish");
		gun = self maps/mp/zombies/_zm_melee_weapon::change_melee_weapon(weapon, gun);
		self giveweapon(weapon);
		if (gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun))
		{
			self switchtoweapon(gun);
			self waittill("weapon_change_complete");
		}
		else
		{
			primaryweapons = self getweaponslistprimaries();
			if (isDefined(primaryweapons) && primaryweapons.size > 0)
			{
				self switchtoweapon(primaryweapons[0]);
				self waittill("weapon_change_complete");
			}
		}
		self thread maps/mp/zombies/_zm_audio::create_and_play_dialog("perk", "one_inch");
	}
	else if ((level.script == "zm_tomb") && issubstr(weapon, "staff_") && issubstr(weapon, "_melee_zm"))
	{
		self play_sound_on_ent("purchase");
		gun = self getcurrentweapon();
		gun = self maps/mp/zombies/_zm_melee_weapon::change_melee_weapon(weapon, gun);
		self giveweapon(weapon);
		if (gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun))
		{
			self switchtoweapon(gun);
			self waittill("weapon_change_complete");
		}
		else
		{
			primaryweapons = self getweaponslistprimaries();
			if (isDefined(primaryweapons) && primaryweapons.size > 0)
			{
				self switchtoweapon(primaryweapons[0]);
				self waittill("weapon_change_complete");
			}
		}
		self play_weapon_vo(weapon);
	}
	else if ((level.script == "zm_tomb") && issubstr(weapon, "staff_"))
	{
		if (issubstr(weapon, "_upgraded_zm"))
		{
			if (!(self hasweapon("staff_revive_zm")))
			{
				self setactionslot(3, "weapon", "staff_revive_zm");
				self giveweapon("staff_revive_zm");
			}
		    self givemaxammo("staff_revive_zm");
		}
		else if (self hasweapon("staff_revive_zm"))
		{
			self takeweapon("staff_revive_zm");
			self setactionslot(3, "altmode");
		}
		self maps/mp/zombies/_zm_weapons::weapon_give(weapon, undefined, undefined, 0);
	}
	else if ((level.script == "zm_tomb") && issubstr(weapon, "equip_dieseldrone_zm"))
	{
		if (isDefined(level.zombie_custom_equipment_setup))
		{
			players = getplayers();
			for (i = 0; i < players.size; i++)
			{
				if (players[i] hasweapon(weapon))
				{
					self stealth_iprintln("^1ERROR: ^7Diesel Drone is already equiped by one player");
					return;
				}
			}
			quadrotor = getentarray( "quadrotor_ai", "targetname" );
			if ( quadrotor.size >= 1 )
			{
				self stealth_iprintln("^1ERROR: ^7Diesel Drone is already active, can't spawn another yet");
				return;
			}
			CustomEquipGiver = spawn("script_model", self NormalisedTrace("position"));
			CustomEquipGiver setmodel("veh_t6_dlc_zm_quadrotor");
			CustomEquipGiver.stub = spawnstruct();
			CustomEquipGiver.stub.weaponname = "equip_dieseldrone_zm";
			CustomEquipGiver.stub.craftablestub = spawnstruct();
			CustomEquipGiver.stub.craftablestub.use_actionslot = 2;
			CustomEquipGiver [[level.zombie_custom_equipment_setup]](self);
			CustomEquipGiver delete();
		}
	}
	else if (self maps/mp/zombies/_zm_utility::is_melee_weapon(weapon))
	{
		if((weapon == "tazer_knuckles_zm") || (weapon == "bowie_knife_zm"))
			self maps/mp/zombies/_zm_melee_weapon::give_melee_weapon_by_name(weapon);
		else
		{
			self play_sound_on_ent("purchase");
			gun = self getcurrentweapon();
			gun = self maps/mp/zombies/_zm_melee_weapon::change_melee_weapon(weapon, gun);
			self giveweapon(weapon);
			if (gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun))
			{
				self switchtoweapon(gun);
				self waittill("weapon_change_complete");
			}
			else
			{
				primaryweapons = self getweaponslistprimaries();
				if (isDefined(primaryweapons) && primaryweapons.size > 0)
				{
					self switchtoweapon(primaryweapons[0]);
					self waittill("weapon_change_complete");
				}
			}
			self play_weapon_vo(weapon);
		}
	}
	else if (self maps/mp/zombies/_zm_utility::is_equipment(weapon))
	{
		self play_sound_on_ent("purchase");
		if (isDefined(level.destructible_equipment) && (level.destructible_equipment.size > 0))
		{
			for(i = 0; i < level.destructible_equipment.size; i++)
			{
				equip = level.destructible_equipment[i];
				if (isDefined(equip.owner) && (equip.owner == self) && isDefined(equip.name) && (equip.name == weapon))
				{
					equip maps/mp/zombies/_zm_equipment::item_damage(9999);
					break;
				}
				else if ((weapon == "jetgun_zm") && isDefined(equip.name) && (equip.name == weapon))
				{
					equip maps/mp/zombies/_zm_equipment::item_damage(9999);
					break;
				}
			}
		}
		self maps/mp/zombies/_zm_equipment::equipment_take(weapon);
		self maps/mp/zombies/_zm_equipment::equipment_buy(weapon);
		self play_weapon_vo(weapon);
	}
	else if (self maps/mp/zombies/_zm_weapons::is_weapon_upgraded(weapon))
		self maps/mp/zombies/_zm_weapons::weapon_give(weapon, 1, undefined, 0);
	else
		self maps/mp/zombies/_zm_weapons::weapon_give(weapon, undefined, undefined, 0);
	self stealth_iprintln("Weapon: " + weapon + " ^2Gived");
}	

UnpackCurrentWeapon_NzV()//Unupgrade current weapon
{
	gun = self getcurrentweapon();
	weapon = gun;
	if (self is_weapon_upgraded(weapon))
	{
		weapon = self maps/mp/zombies/_zm_weapons::get_base_weapon_name(gun, 1);
		if (isDefined(weapon) && (weapon != "none"))
		{
			self play_sound_on_ent("purchase");
			self takeweapon(gun);
			unacquire_weapon_toggle(gun);
			self disable_player_move_states(1);
			self giveweapon("zombie_knuckle_crack");
			self switchtoweapon("zombie_knuckle_crack");
			self waittill_any("player_downed", "weapon_change_complete");
			self enable_player_move_states();
			self takeweapon("zombie_knuckle_crack");
			self maps/mp/zombies/_zm_weapons::weapon_give(weapon, undefined, undefined, 0);
			self stealth_iprintln("[^1Unpack A Punch^7] Weapon: " + weapon);
		}
		else
			self stealth_iprintln("^1ERROR: ^7Unknow Weapon");
	}
	else
		self stealth_iprintln("^1ERROR: ^7Current Weapon [" + weapon + "] Is Not Upgraded");
}
		
PackCurrentWeapon_NzV(get_accessorie)//Upgrade current weapon, get_accessorie = true or false.
{
	gun = self getcurrentweapon();
	weapon = gun;
	if (self can_upgrade_weapon(weapon))
	{
		if (isDefined(get_accessorie) && get_accessorie)
		{
			weapon = self maps/mp/zombies/_zm_weapons::get_upgrade_weapon(weapon, 1);
		}
		else
		{
			if (self maps/mp/zombies/_zm_weapons::is_weapon_upgraded(weapon))
				weapon = self maps/mp/zombies/_zm_weapons::get_base_name(weapon);
			else
				weapon = self maps/mp/zombies/_zm_weapons::get_upgrade_weapon(weapon, 0);
		}
		if (isDefined(weapon) && (weapon != "none"))
		{
			self play_sound_on_ent("purchase");
			self takeweapon(gun);
			unacquire_weapon_toggle(gun);
			self disable_player_move_states(1);
			self giveweapon("zombie_knuckle_crack");
			self switchtoweapon("zombie_knuckle_crack");
			self waittill_any("player_downed", "weapon_change_complete");
			self enable_player_move_states();
			self takeweapon("zombie_knuckle_crack");
			self maps/mp/zombies/_zm_weapons::weapon_give(weapon, 1, undefined, 0);
			self stealth_iprintln("[^2Pack A Punch^7] Weapon: " + weapon);
		}
		else
			self stealth_iprintln("^1ERROR: ^7Unknow Weapon");
	}
	else
	{
		if (self maps/mp/zombies/_zm_weapons::is_weapon_upgraded(weapon))
			self stealth_iprintln("^1ERROR: ^7Current Weapon [" + weapon + "] Cant Be Upgraded Again");
		else
			self stealth_iprintln("^1ERROR: ^7Current Weapon [" + weapon + "] Cant Be Upgraded");
	}
}

Toggle_Ammo_NzV()
{
	self notify("StopUnlimitedAmmo");
	if(!isDefined(self.UnlimitedAmmo))
		self.UnlimitedAmmo = false;
	self.UnlimitedAmmo = !self.UnlimitedAmmo;
	if(self.UnlimitedAmmo)
		self thread doUnlimitedAmmo_NzV();
	self stealth_iprintln("Unlimited Ammo " + (self.UnlimitedAmmo ? "^2ON" : "^1OFF"));
}

doUnlimitedAmmo_NzV()
{   
    self endon("StopUnlimitedAmmo");
    self endon("disconnect");
    self endon("death");
	level endon("game_ended");
	while (isDefined(self.UnlimitedAmmo) && self.UnlimitedAmmo)
    {
        currentWeapon = self getcurrentweapon();
        if (isDefined(currentWeapon) && (currentWeapon != "none"))
        {
       	 	self setweaponammoclip(currentWeapon, weaponclipsize(currentWeapon));
       	 	self givemaxammo(currentWeapon);
			alt_weap = weaponaltweaponname(currentWeapon);
			if (isDefined(alt_weap) && (alt_weap != "none"))
				self givemaxammo(alt_weap);
        }
		//
        currenttactical_grenade = self get_player_tactical_grenade();
        if (isDefined(currenttactical_grenade) && (currenttactical_grenade != "none"))
			self givemaxammo(currenttactical_grenade);
		//
		currentlethal_grenade = self get_player_lethal_grenade();
        if (isDefined(currentlethal_grenade) && (currentlethal_grenade != "none"))
			self givemaxammo(currentlethal_grenade);
		//
		currentoffhand = self getcurrentoffhand();
        if (isDefined(currentoffhand) && (currentoffhand != "none"))
           self givemaxammo(currentoffhand);
		//
		currentplaceable_mine = self get_player_placeable_mine();
        if (isDefined(currentplaceable_mine) && (currentplaceable_mine != "none"))
			self givemaxammo(currentplaceable_mine);
		//
		currentequipement = self get_player_equipment();
        if (isDefined(currentequipement) && (currentequipement != "none"))
			self givemaxammo(currentequipement);		
		//
        if ((level.script == "zm_transit" ) || ( level.script == "zm_buried"))
        	 self setweaponoverheating(0, 0);
		//
        if ((level.script == "zm_prison"))
			self.n_tomahawk_cooking_time = getTime() - 9999;
			
     	self waittill_any ("weapon_fired", "grenade_fire", "grenade_launcher_fire", "weapon_change_complete");
    } 
}

Toggle_EquipementStayHealthy_NzV()
{
	self notify("StopEquipementStayHealthy");
	if(!isDefined(self.StopEquipementStayHealthy))
		self.StopEquipementStayHealthy = false;
	self.StopEquipementStayHealthy = !self.StopEquipementStayHealthy;
	if(self.StopEquipementStayHealthy)
		self thread doEquipmentStaysHealthy();
	self stealth_iprintln("Equipement Stay Healthy " + (self.StopEquipementStayHealthy ? "^2ON" : "^1OFF"));
}

doEquipmentStaysHealthy()
{
	self notify("StopEquipementStayHealthy");
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self endon("StopEquipementStayHealthy");
	while (isDefined(self.StopEquipementStayHealthy) && self.StopEquipementStayHealthy)
	{
		self.turbine_health = 1200;
		self.equipment_damage = [];
		self.shielddamagetaken = 0;
		if (isDefined(level.destructible_equipment) && (level.destructible_equipment.size > 0))
		{
   			for(i = 0; i < level.destructible_equipment.size; i++)
			{
				equip = level.destructible_equipment[i];
				if (isDefined(equip.owner) && (equip.owner == self))
				{
					equip.shielddamagetaken = 0;
					equip.damage = 0;
					equip.headchopper_kills = 0;
					equip.springpad_kills = 0;
					equip.subwoofer_kills = 0;
				}
			}
		}
		wait 0.1;
	}
}
	
Toggle_LeftGun()
{
    self notify("StopLeftGun"); //Stop AdvancedLeftGun
    if(getDvarint("cg_gun_y") == 0 && getDvarint("cg_gun_x") == 0)
    {
        setDvar("cg_gun_y",10);
        setDvar("cg_gun_x",4);
    }
    else
    {
        setDvar("cg_gun_y",0);
        setDvar("cg_gun_x",0);
    }
	self stealth_iprintln("Left Side Gun " + ((getDvarint("cg_gun_y") != 0) ? "^2ON" : "^1OFF"));
}

Toggle_AdvancedLeftGun()
{
    self notify("StopLeftGun");
    if(getDvarint("cg_gun_y") == 0 && getDvarint("cg_gun_x") == 0)
    {
            self thread doAdvancedLeftGun();
    }
    else
    {
            setDvar("cg_gun_y",0);
            setDvar("cg_gun_x",0);
    }
	self stealth_iprintln("Advance Left Side Gun " + ((getDvarint("cg_gun_y") != 0) ? "^2ON" : "^1OFF"));
}

doAdvancedLeftGun()
{
	self endon("StopLeftGun");
    self endon("disconnect");
	self endon("death");
	level endon("game_ended");  
	for(;;)
	{
		if(self adsbuttonpressed())
		{
			setDvar("cg_gun_y",0);
			setDvar("cg_gun_x",0);
		}
		else
		{
			setDvar("cg_gun_y",10);
			setDvar("cg_gun_x",4);
		}
		wait .1;
	}
}

Toggle_HideWeapon()
{
    if(getDvarint("cg_drawGun") == 0)
       setDvar("cg_drawGun", "1"); 
    else
       setDvar("cg_drawGun", "0"); 
	self stealth_iprintln("No Gun " + ((getDvarint("cg_drawGun") == 0) ? "^2ON" : "^1OFF"));
}

Toggle_HideCrosshair()
{
    if(getDvarint("cg_drawCrosshair") == 0)
       setDvar("cg_drawCrosshair", "1"); 
    else
       setDvar("cg_drawCrosshair", "0"); 
	self stealth_iprintln("Crosshair " + ((getDvarint("cg_drawGun") == 1) ? "^2ON" : "^1OFF"));
}

MySetFOV(fov)
{
    self setclientfov(fov);
    //setDvar("cg_fov", fov);
    self stealth_iprintln("Field of view set to ^1" + fov + "^7");
}

MySetDOF_Weapon(i)
{
	self SetViewModelDepthOfField( 2, i ); // 10 default | 20 middle | 40 high | 5 low
	self stealth_iprintln("View Model Death of Field Set To ^2"+i+"^7");
}

MySetSpead(i)
{
	self SetSpreadOverride( i ); // 30 i shigh | 4 defualt | 0 smallest !
	self stealth_iprintln("Spread set To ^1"+i);
}
MySetSpead_R()
{
self ResetSpreadOverride();
}
Toggle_ExplosiveBullets()
{
	self notify("StopExplosiveBullets");
	if(isDefined(self.telgun) && self.telgun)
	    self Toggle_TeleportGun();
	if(isDefined(self.ricbullets) && self.ricbullets)
	    self Toggle_RicochetBullet();
	if(isDefined(self.fxgun) && self.fxgun)
	    self Toggle_FxGun();
	if(isDefined(self.moddedbullets) && self.moddedbullets)
	    self Toggle_ModdedWeaponBullets();
	if(isDefined(self.doFlameTrowher) && self.doFlameTrowher)
	    self Toggle_FlameTrowher();
	if(!isDefined(self.expbullets))
		self.expbullets = false;
	if(!self.expbullets)
		self thread doExplosiveBullets();
	self.expbullets = !self.expbullets;
	self stealth_iprintln("Explosive Bullets " + (self.expbullets ? "^2ON" : "^1OFF"));
}

doExplosiveBullets()
{
   	self endon("StopExplosiveBullets");
   	self endon("disconnect");
	self endon("death");
	level endon("game_ended");  
    for(;;)
    {
        self waittill ("weapon_fired");
        Earthquake(0.5,1,self.origin,90);
        forward = self getTagOrigin("j_head");
        end = self thread vector_scale(anglestoforward(self getPlayerAngles()),1000000);
        SPLOSIONlocation = BulletTrace(forward, end, 0, self)["position"];
        RadiusDamage(SPLOSIONlocation, 500, 1000, 500, self);
        playsoundatposition("evt_nuke_flash", SPLOSIONlocation);
        Earthquake(2.5, 2, SPLOSIONlocation, 300);
        playfx(loadfx("explosions/fx_default_explosion"), SPLOSIONlocation);
        wait 0.1;
    }
}

Toggle_TeleportGun()
{
	self notify("StopTeleportGun");
	if(isDefined(self.fxbullets) && self.fxbullets)
	    self ListfxGuns();
	if(isDefined(self.expbullets) && self.expbullets)
	    self Toggle_ExplosiveBullets();
	if(isDefined(self.ricbullets) && self.ricbullets)
	    self Toggle_RicochetBullet();
	if(isDefined(self.fxgun) && self.fxgun)
	    self Toggle_FxGun();
	if(isDefined(self.moddedbullets) && self.moddedbullets)
	    self Toggle_ModdedWeaponBullets();
	if(isDefined(self.doFlameTrowher) && self.doFlameTrowher)
	    self Toggle_FlameTrowher();
	if(!isDefined(self.telgun))
		self.telgun = false;
	if(!self.telgun)
		self thread doTeleportGun();
	self.telgun = !self.telgun;
	self stealth_iprintln("Teleport Gun " + (self.telgun ? "^2ON" : "^1OFF"));
}

doTeleportGun()
{
   	self endon("disconnect");
	self endon("death");
	level endon("game_ended");  
    self endon ("StopTeleportGun");
    for(;;)
    {
        self waittill ("weapon_fired");
        self setorigin(BulletTrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglestoforward(self getplayerangles()) * 1000000, 0, self)["position"]);
        wait 0.1;
    }
}

Toggle_RicochetBullet()
{
	self notify("StopRicochetBullet");
	if(isDefined(self.fxbullets) && self.fxbullets)
	    self ListfxGuns();
	if(isDefined(self.expbullets) && self.expbullets)
	    self Toggle_ExplosiveBullets();
	if(isDefined(self.telgun) && self.telgun)
	    self Toggle_TeleportGun();
	if(isDefined(self.fxgun) && self.fxgun)
	    self Toggle_FxGun();
	if(isDefined(self.moddedbullets) && self.moddedbullets)
	    self Toggle_ModdedWeaponBullets();
	if(isDefined(self.doFlameTrowher) && self.doFlameTrowher)
	    self Toggle_FlameTrowher();
	if(!isDefined(self.ricbullets))
		self.ricbullets = false;
	if(!self.ricbullets)
		self thread doRicochetBullet();
	self.ricbullets = !self.ricbullets;
	self stealth_iprintln("Ricochet Bullets " + (self.ricbullets ? "^2ON" : "^1OFF"));
}

doRicochetBullet()
{
    self endon("StopRicochetBullet");
   	self endon("disconnect");
	self endon("death");
	level endon("game_ended");  
    for(;;)
    {
        self waittill("weapon_fired");
        Gun = self GetCurrentWeapon();
        Incident = AnglesToForward(self GetPlayerAngles());
        Trace = BulletTrace(self GetEye(), self GetEye()+ Incident * 100000, 0, self);
        Reflection = Incident - (2 * trace["normal"] * VectorDot(Incident, trace["normal"]));
        MagicBullet(Gun, Trace["position"], Trace["position"]+(Reflection * 100000), self);
        for(i=0;i<1-1;i++)
        {
            Trace = BulletTrace(Trace["position"], Trace["position"]+(Reflection * 100000), 0, self);
            Incident = Reflection;
            Reflection = Incident - (2 * Trace["normal"] * VectorDot(Incident, Trace["normal"]));
            MagicBullet(Gun, Trace["position"], Trace["position"] + (Reflection * 100000), self);
            wait 0.05;
        }
        wait 0.1;
    }
}

Toggle_FxGun(fx_effect)
{
	self notify("StopFxGun");
	if(isDefined(self.fxbullets) && self.fxbullets)
	    self ListfxGuns();
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
}
Toggle_ModdedWeaponBullets(weapon)
{
	self notify("StopModdedWeaponBullets");
	if(isDefined(self.fxbullets) && self.fxbullets)
	    self ListfxGuns();
	if(isDefined(self.expbullets) && self.expbullets)
	    self Toggle_ExplosiveBullets();
	if(isDefined(self.telgun) && self.telgun)
	    self Toggle_TeleportGun();
	if(isDefined(self.ricbullets) && self.ricbullets)
	    self Toggle_RicochetBullet();
	if(isDefined(self.fxgun) && self.fxgun)
	    self Toggle_FxGun();
	if(isDefined(self.doFlameTrowher) && self.doFlameTrowher)
	    self Toggle_FlameTrowher();
	if(!isDefined(self.moddedbullets))
		self.moddedbullets = false; 
	if(isDefined(weapon) && (!self.moddedbullets))
		self thread doModdedWeaponBullets(weapon);
	self.moddedbullets = !self.moddedbullets;
	self stealth_iprintln("Modded Bullets " + (self.moddedbullets ? "(" + weapon + ")^2ON" : "^1OFF"));
}

doModdedWeaponBullets(weapon)
{
    self endon("StopModdedWeaponBullets");
   	self endon("disconnect");
	self endon("death");
	level endon("game_ended"); 
    for(;;)
    {
        self waittill("weapon_fired");
        B = self getTagOrigin("tag_eye");
        C = self NewBullet(anglestoforward(self getPlayerAngles()), 1000000);
        D = BulletTrace(B, C, 0, self)["position"];
        MagicBullet(weapon, B, D, self);
		wait 0.1;
    }
}

NewBullet(A, B)
{
    return (A[0]*B, A[1]*B, A[2]*B);
}
	    
Toggle_FlameTrowher()
{
	self notify("StopFlameTrowher");
	if(isDefined(self.fxbullets) && self.fxbullets)
	    self ListfxGuns();
	if(isDefined(self.expbullets) && self.expbullets)
	    self Toggle_ExplosiveBullets();
	if(isDefined(self.telgun) && self.telgun)
	    self Toggle_TeleportGun();
	if(isDefined(self.ricbullets) && self.ricbullets)
	    self Toggle_RicochetBullet();
	if(isDefined(self.fxgun) && self.fxgun)
	    self Toggle_FxGun();
	if(isDefined(self.moddedbullets) && self.moddedbullets)
	    self Toggle_ModdedWeaponBullets();
	if(!isDefined(self.FlameTrowher))
		self.FlameTrowher = false; 
	if(!self.FlameTrowher)
		self thread doFlameTrowher();
	self.FlameTrowher = !self.FlameTrowher;
	self stealth_iprintln("Flame Trowher " + (self.FlameTrowher ? "^2ON" : "^1OFF"));
}

doFlameTrowher()
{
    self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self endon("StopFlameTrowher");
	FX = loadfx("env/fire/fx_fire_zombie_torso");
	FX2 = loadfx("env/fire/fx_fire_zombie_md");
    for(;;)
	{
		self waittill("weapon_fired");
		Crosshair = BulletTrace(self getTagOrigin("j_head") , self vector_Scale(anglestoforward(self getPlayerAngles()),1000000), 0, self)["position"];
		MagicBullet(self getcurrentweapon(), self getTagOrigin("j_shouldertwist_le"), Crosshair, self);
		playFX(FX, Crosshair);
		playFX(FX2, self getTagOrigin("j_hand"));
		RadiusDamage(Crosshair, 100, 15, 15, self);
		wait 0.1;
	}
}


Give_Shovel()
{
	if((level.script == "zm_tomb") && isDefined(self.dig_vars))
	{
		self play_sound_on_ent("purchase");
		self.dig_vars["has_shovel"] = 1;
		self.dig_vars["n_spots_dug"] = 0;
		self.dig_vars["has_upgraded_shovel"] = 0;
		n_player = self getentitynumber() + 1;
		level setclientfield("shovel_player" + n_player, 1);
		self stealth_iprintln("Shovel ^2Gived");
	}
	else
		self stealth_iprintln("^1ERROR: ^7Shovel Not Supported On This Map");
}

Give_GoldenShovel()
{
	if((level.script == "zm_tomb") && isDefined(self.dig_vars))
	{
		self play_sound_on_ent("purchase");
		self.dig_vars["has_shovel"] = 1;
		self.dig_vars["n_spots_dug"] = 64;
		self.dig_vars["has_upgraded_shovel"] = 1;
		n_player = self getentitynumber() + 1;
		level setclientfield( "shovel_player" + n_player, 2);
		self playsoundtoplayer("zmb_squest_golden_anything", self);
		self stealth_iprintln("Golden Shovel ^2Gived");
	}
	else
		self stealth_iprintln("^1ERROR: ^7Golden Shovel Not Supported On This Map");
}

Give_Helmet()
{
	if((level.script == "zm_tomb") && isDefined(self.dig_vars))
	{
		self play_sound_on_ent("purchase");
		self.dig_vars["has_helmet"] = 1;
		n_player = self getentitynumber() + 1;
		level setclientfield("helmet_player" + n_player, 1);
		self playsoundtoplayer("zmb_squest_golden_anything", self);
		self stealth_iprintln("Helmet ^2Gived");
	}
	else
		self stealth_iprintln("^1ERROR: ^7Helmet Not Supported On This Map");
}


WeaponDropp()
{
if(self getcurrentWeapon() == "defaultweapon_mp")
{
self stealth_iprintln("^1You cant drop this Item !");
}
self stealth_iprintln("You droped ^2"+self getcurrentWeapon());
self dropItem(self getcurrentWeapon());
}






