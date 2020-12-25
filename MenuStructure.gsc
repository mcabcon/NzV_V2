BaseMenuStruct(BaseMenuName)
{
    //-----------------------------------
	// Main Mods ("Access Level 1")
	//-----------------------------------
	self add_option(BaseMenuName, "Main Mods Menu", ::submenu, "main_mods_menu");
	self add_menu("main_mods_menu", BaseMenuName, "Access Level 1");
	self add_option("main_mods_menu", "Godmode", ::Toggle_GodMod_NzV);
	self add_option("main_mods_menu", "Unlimited Ammo", ::Toggle_Ammo_NzV);
	self add_option("main_mods_menu", "> Set Score", ::submenu, "main_mods_menu_money");
	self add_option("main_mods_menu", "Ufo Mode", ::Toggle_UFOMode); 
	self add_option("main_mods_menu", "No Clip", ::Toggle_NoClip); 
	self add_menu("main_mods_menu_money", "main_mods_menu", "Access Level 1");
    foreach(score in array(100000,10000,1000,100,10))
    		self add_option("main_mods_menu_money", "^7Score ^2+" + score + "^7", ::AddScore, score);
	self add_option("main_mods_menu_money", "^1Set Score To 0^7", ::AddScore, undefined);
    foreach(score in array(10,100,1000,10000,100000))
        	self add_option("main_mods_menu_money", "^7Score ^1-" + score  + "^7", ::AddScore, (0 - score));
	self add_option("main_mods_menu", "Invisible", ::Toggle_Invisi);
	self add_option("main_mods_menu", "3rd Person", ::Toggle_3rdPerson);
	self add_option("main_mods_menu", "> Set Move Speed", ::submenu, "main_mods_menu_movespeed");
	self add_menu("main_mods_menu_movespeed", "main_mods_menu", "Access Level 1");
    foreach(movespeed in array(1,2,3,4,5,7,10))
    		self add_option("main_mods_menu_movespeed", "^7Move Speed ^2x" + movespeed + "^7", ::MySetMoveSpeedScale, movespeed);	
	self add_option("main_mods_menu", "> Set Sprint Duration", ::submenu, "main_mods_menu_sprintduration");
	self add_menu("main_mods_menu_sprintduration", "main_mods_menu", "Access Level 1");
    foreach(sprintduration in array(1,2,3,4,5,7,10))
    		self add_option("main_mods_menu_sprintduration", "^7Sprint Duration ^2x" + sprintduration + "^7", ::MySetSprintDuration, sprintduration);  
	self add_option("main_mods_menu", "> Set Sprint Cooldown", ::submenu, "main_mods_menu_sprintcooldown");
	self add_menu("main_mods_menu_sprintcooldown", "main_mods_menu", "Access Level 1");
    foreach(sprintcooldown in array(1,2,3,4,5,7,10))
    		self add_option("main_mods_menu_sprintcooldown", "^7Sprint Cooldown ^2x" + sprintcooldown + "^7", ::MySetSprintCooldown, sprintcooldown); 		
    self add_option("main_mods_menu", "Double Jump",::Toggle_DoubleJump);
	self add_option("main_mods_menu", "Clone Me", ::CloneMe);
	self add_option("main_mods_menu", "Suicide",::doSuicide);
	self add_option("main_mods_menu", "Draw FPS", ::Toggle_ShowFPS);
   	//-----------------------------------
	// Fun Menu ("Access Level 1")
	//-----------------------------------
	self add_option(BaseMenuName, "Fun Menu", ::submenu, "fun_menu");	
	self add_menu("fun_menu", BaseMenuName, "Access Level 1");
	self add_option(BaseMenuName, "Visions Menu", ::submenu, "fun_menu_vision");
	self add_menu("fun_menu_vision", BaseMenuName, "Access Level 1");
	self add_option("fun_menu_vision", "Death", ::SetVision, "zombie_death");
	self add_option("fun_menu_vision", "Last Stand", ::SetVision, "zombie_last_stand");
	self add_option("fun_menu_vision", "Turned", ::SetVision, "zombie_turned");
	self add_option("fun_menu_vision", "Default", ::SetVision, "default");
	
    self add_option("fun_menu", "Jet Pack",::Toggle_JetPack);
    self add_option("fun_menu", "Flashing Player",::Toggle_FlashingPlayer);
    self add_option("fun_menu", "Drunken Mode",::Toggle_Drunk);
    self add_option("fun_menu", "Rotate Angles", ::Toggle_RotateAngles);
	self add_option("fun_menu", "Auto Dropshot", ::Toggle_AutoDropShot);
	self add_option("fun_menu", "Centipede", ::Toggle_Centipede);
	self add_option("fun_menu", "Super Stalker", ::Toggle_StalkerPro);
	self add_option("fun_menu", "Skull Protector", ::Toggle_SkullProtector);
	self add_option("fun_menu", "Send Kamikaze", ::SendKamikaze);
	self add_option("fun_menu", "Send Earth Quake", ::SendEarthQuake);
	self add_option("fun_menu", "Aimbot", ::Toggle_AimBot);
	self add_option("fun_menu", "Gore Mode", ::Toggle_GoreMode);
	self add_option("fun_menu", "Electric Man", ::Toggle_ElectricMan);
   	//-----------------------------------
	// Weapons Menu ("Access Level 1")
	//-----------------------------------
	self add_option(BaseMenuName, "Weapon Menu", ::submenu, "weapons_menu");	
	self add_menu("weapons_menu", BaseMenuName, "Access Level 1");
	//Init Autopaging
	level.menuweapmaxitemperpage = 15;
	self.countmenuweap = 0;
	self.countmenuweap_p = 0;
	self.countmenuequip = 0;
	self.countmenuequip_p = 0;
	self.countmenumelee = 0;
	self.countmenumelee_p = 0;
	self.countmenulethal = 0;
	self.countmenulethal_p = 0;
	self.countmenutactical = 0;
	self.countmenutactical_p = 0;
	//self.countmenuoffhand = 0;
	//self.countmenuoffhand_p = 0;
	//self.countmenuextra = 0;
	//self.countmenuextra_p = 0;
	//Create Menu Base
	self add_menu("weapons_menu_give_weap_0", "weapons_menu", "Access Level 1");
	self add_menu("weapons_menu_give_equip_0", "weapons_menu", "Access Level 1");
	self add_menu("weapons_menu_give_melee_0", "weapons_menu", "Access Level 1");
	self add_menu("weapons_menu_give_lethal_0", "weapons_menu", "Access Level 1");
	self add_menu("weapons_menu_give_tactical_0", "weapons_menu", "Access Level 1");
	//self add_menu("weapons_menu_give_offhand_0", "weapons_menu", "Access Level 1");
	//self add_menu("weapons_menu_give_extra_0", "weapons_menu", "Access Level 1");
	//All Map
	self AddToGiveWeaponMenu("870MCS" , "870mcs_zm");
	self AddToGiveWeaponMenu("BERETTA93R" , "beretta93r_zm");
	self AddToGiveWeaponMenu("CLAYMORE" , "claymore_zm");
	self AddToGiveWeaponMenu("DSR50" , "dsr50_zm");
	self AddToGiveWeaponMenu("FIVESEVEN" , "fiveseven_zm");
	self AddToGiveWeaponMenu("FIVESEVEN DW" , "fivesevendw_zm");
	self AddToGiveWeaponMenu("FIVESEVEN LH" , "fivesevenlh_zm");
	self AddToGiveWeaponMenu("FNFAL" , "fnfal_zm");
	self AddToGiveWeaponMenu("FRAG GRENADE" , "frag_grenade_zm");
	self AddToGiveWeaponMenu("GALIL" , "galil_zm");
	self AddToGiveWeaponMenu("M14" , "m14_zm");
	self AddToGiveWeaponMenu("RAY GUN" , "ray_gun_zm");
	self AddToGiveWeaponMenu("RAYGUN MARK2" , "raygun_mark2_zm");
	//self AddToGiveWeaponMenu("DEATH SELF" , "death_self_zm");
	//self AddToGiveWeaponMenu("DEATH THROE" , "death_throe_zm");
	//self AddToGiveWeaponMenu("DEFAULT WEAPON" , "defaultweapon_mp");
	//self AddToGiveWeaponMenu("FISTS" , "zombie_fists_zm");
	self AddToGiveWeaponMenu("AK47" , "ak47_zm"); 
	self AddToGiveWeaponMenu("HK416" , "hk416_zm");
	//self AddToGiveWeaponMenu("KNUCKLE CRACK" , "zombie_knuckle_crack");
	//self AddToGiveWeaponMenu("NONE" , "none");
	//self AddToGiveWeaponMenu("QUADROTOR TURRET" , "quadrotorturret_zm");
	//self AddToGiveWeaponMenu("GASMASK" , "equip_gasmask_zm");
	//self AddToGiveWeaponMenu("HACKER" , "equip_hacker_zm");
	//self AddToGiveWeaponMenu("EVOSKORPION" , "evoskorpion_zm");
	//self AddToGiveWeaponMenu("BULLET CROUCH" , "zombie_bullet_crouch_zm");
	//self AddToGiveWeaponMenu("MARKIV CANNON" , "zombie_markiv_cannon");
	//self AddToGiveWeaponMenu("MARKIV SIDE CANNON" , "zombie_markiv_side_cannon");
	//self AddToGiveWeaponMenu("MARKIV TURRET" , "zombie_markiv_turret");
	//self AddToGiveWeaponMenu("item_head_zm" , "item_head_zm");
	//self AddToGiveWeaponMenu("item_meat_zm" , "item_meat_zm");
	//self AddToGiveWeaponMenu("slip_bolt_zm" , "slip_bolt_zm");
	//Multi Map Specific
	if ((level.script == "zm_transit") || (level.script == "zm_highrise") || (level.script == "zm_nuked"))
	{
		self AddToGiveWeaponMenu("AK74U" , "ak74u_zm");
		self AddToGiveWeaponMenu("KNIFE BALLISTIC NO MELEE" , "knife_ballistic_no_melee_zm");
		self AddToGiveWeaponMenu("KNIFE BALLISTIC" , "knife_ballistic_zm");
		self AddToGiveWeaponMenu("M16" , "m16_zm");
		self AddToGiveWeaponMenu("SARITCH" , "saritch_zm");
		self AddToGiveWeaponMenu("DUAL OPTIC SARITCH UP" , "dualoptic_saritch_upgraded_zm");
		self AddToGiveWeaponMenu("TAZER" , "tazer_knuckles_zm");
	}
	if ((level.script != "zm_transit") && (level.script != "zm_tomb") && (level.script != "zm_prison"))
	{
		self AddToGiveWeaponMenu("AN94" , "an94_zm"); 
		self AddToGiveWeaponMenu("SVU" , "svu_zm");
	}
	if ((level.script != "zm_transit") && (level.script != "zm_tomb") && (level.script != "zm_highrise") && (level.script != "zm_nuked"))
	{
		self AddToGiveWeaponMenu("LSAT" , "lsat_zm");
		self AddToGiveWeaponMenu("RNMA" , "rnma_zm");
	}
	if ((level.script != "zm_buried") && (level.script != "zm_tomb") && (level.script != "zm_prison"))
	{
		self AddToGiveWeaponMenu("RPD" , "rpd_zm");
	}
	if ((level.script == "zm_transit") || (level.script == "zm_buried"))
	{
		self AddToGiveWeaponMenu("BOWIE KNIFE" , "bowie_knife_zm");
		self AddToGiveWeaponMenu("KNIFE BALLISTIC BOWIE" , "knife_ballistic_bowie_zm");
		self AddToGiveWeaponMenu("TURBINE" , "equip_turbine_zm");
	}
	if ((level.script == "zm_buried") || (level.script == "zm_highrise"))
	{
		self AddToGiveWeaponMenu("SPRINGPAD" , "equip_springpad_zm");
	}
	if ((level.script == "zm_prison") || (level.script == "zm_tomb"))
	{
		self AddToGiveWeaponMenu("C96" , "c96_zm"); 
		self AddToGiveWeaponMenu("MP44" , "mp44_zm");
		self AddToGiveWeaponMenu("THOMPSON" , "thompson_zm");
	}
	if ((level.script != "zm_prison") && (level.script != "zm_buried"))
	{
		self AddToGiveWeaponMenu("PYTHON" , "python_zm"); 
		self AddToGiveWeaponMenu("QCW05" , "qcw05_zm");
		self AddToGiveWeaponMenu("STICKY GRENADE" , "sticky_grenade_zm");
	}
	if (level.script != "zm_transit")
	{
		self AddToGiveWeaponMenu("PDW57" , "pdw57_zm");
	}
	if (level.script != "zm_prison")
	{
		self AddToGiveWeaponMenu("CYMBAL MONKEY" , "cymbal_monkey_zm");
		self AddToGiveWeaponMenu("HAMR" , "hamr_zm");
		self AddToGiveWeaponMenu("KARD" , "kard_zm");
		self AddToGiveWeaponMenu("KNIFE" , "knife_zm");
		self AddToGiveWeaponMenu("M32" , "m32_zm");
		self AddToGiveWeaponMenu("SRM1216" , "srm1216_zm");
		//self AddToGiveWeaponMenu("SYRETTE" , "syrette_zm");
	}
	if (level.script != "zm_tomb")
	{
		self AddToGiveWeaponMenu("BARRETM82" , "barretm82_zm");
		self AddToGiveWeaponMenu("JUDGE" , "judge_zm");
		self AddToGiveWeaponMenu("M1911" , "m1911_zm");
		self AddToGiveWeaponMenu("MP5K" , "mp5k_zm");
		self AddToGiveWeaponMenu("ROTTWEIL72" , "rottweil72_zm");
		self AddToGiveWeaponMenu("SAIGA12" , "saiga12_zm");
		self AddToGiveWeaponMenu("TAR21" , "tar21_zm");
		self AddToGiveWeaponMenu("USRPG" , "usrpg_zm");
	}
	if ((level.script == "zm_transit") || (level.script == "zm_buried") || (level.script == "zm_highrise") || (level.script == "zm_nuked"))
	{
		self AddToGiveWeaponMenu("XM8" , "xm8_zm");
	}
	//One Map Specific
	if (level.script == "zm_transit")
	{
		self AddToGiveWeaponMenu("EMP GRENADE" , "emp_grenade_zm");
		self AddToGiveWeaponMenu("ELECTRIC TRAP" , "equip_electrictrap_zm");
		self AddToGiveWeaponMenu("JETGUN" , "jetgun_zm");
		self AddToGiveWeaponMenu("SHIELD" , "riotshield_zm");
		//self AddToGiveWeaponMenu("SCREECHER ARMS" , "screecher_arms_zm");
		self AddToGiveWeaponMenu("TURRET" , "equip_turret_zm");
	}
	else if (level.script == "zm_highrise")
	{
		self AddToGiveWeaponMenu("SLIPGUN" , "slipgun_zm");
	}
	else if (level.script == "zm_prison")
	{
		self AddToGiveWeaponMenu("SHIELD" , "alcatraz_shield_zm");
		self AddToGiveWeaponMenu("BLUNDERGAT" , "blundergat_zm");
		self AddToGiveWeaponMenu("BLUNDERSPLAT" , "blundersplat_zm");
		self AddToGiveWeaponMenu("ELECTROCUTED HANDS" , "electrocuted_hands_zm");
		//self AddToGiveWeaponMenu("FALLING HANDS" , "falling_hands_zm");
		self AddToGiveWeaponMenu("KNIFE" , "knife_zm_alcatraz");
		self AddToGiveWeaponMenu("LIGHTNING HANDS" , "lightning_hands_zm");
		self AddToGiveWeaponMenu("MINIGUN" , "minigun_alcatraz_zm");
		self AddToGiveWeaponMenu("SPOON" , "spoon_zm_alcatraz");
		self AddToGiveWeaponMenu("SPORK" , "spork_zm_alcatraz");
		//self AddToGiveWeaponMenu("SYRETTE" , "syrette_afterlife_zm");
		self AddToGiveWeaponMenu("TOMAHAWK" , "bouncing_tomahawk_zm");
		self AddToGiveWeaponMenu("UP TOMAHAWK" , "upgraded_tomahawk_zm");
		self AddToGiveWeaponMenu("UZI" , "uzi_zm");
		self AddToGiveWeaponMenu("WILLY PETE" , "willy_pete_zm");
	}
	else if (level.script == "zm_buried")
	{
		//self AddToGiveWeaponMenu("CHALK DRAW" , "chalk_draw_zm");
		self AddToGiveWeaponMenu("HEADCHOPPER" , "equip_headchopper_zm");
		//self AddToGiveWeaponMenu("NO HANDS" , "no_hands_zm");
		self AddToGiveWeaponMenu("SPRINGPAD" , "equip_springpad_zm");
		self AddToGiveWeaponMenu("SUBWOOFER" , "equip_subwoofer_zm");
		self AddToGiveWeaponMenu("SLOWGUN" , "slowgun_zm");
		//self AddToGiveWeaponMenu("TIME BOMB" , "time_bomb_detonator_zm");
		self AddToGiveWeaponMenu("TIME BOMB" , "time_bomb_zm");
	}
	else if (level.script == "zm_tomb")
	{
		self AddToGiveWeaponMenu("AK74U EXTCLIP" , "ak74u_extclip_zm");
		self AddToGiveWeaponMenu("BALLISTA" , "ballista_zm");
		self AddToGiveWeaponMenu("BEACON" , "beacon_zm");
		self AddToGiveWeaponMenu("BERETTA93R EXTCLIP" , "beretta93r_extclip_zm");
		self AddToGiveWeaponMenu("DIESELDRONE" , "equip_dieseldrone_zm");
		//self AddToGiveWeaponMenu("FALLING HANDS TOMB" , "falling_hands_tomb_zm");
		self AddToGiveWeaponMenu("KSG" , "ksg_zm");
		self AddToGiveWeaponMenu("MP40 STALKER" , "mp40_stalker_zm");
		self AddToGiveWeaponMenu("MP40" , "mp40_zm");
		self AddToGiveWeaponMenu("MG08" , "mg08_zm");
		self AddToGiveWeaponMenu("PUNCH AIR" , "one_inch_punch_air_zm");
		self AddToGiveWeaponMenu("PUNCH FIRE" , "one_inch_punch_fire_zm");
		self AddToGiveWeaponMenu("PUNCH ICE" , "one_inch_punch_ice_zm");
		self AddToGiveWeaponMenu("PUNCH LIGHTNING" , "one_inch_punch_lightning_zm");
		self AddToGiveWeaponMenu("PUNCH" , "one_inch_punch_zm");
		self AddToGiveWeaponMenu("PUNCH UP" , "one_inch_punch_upgraded_zm");
		self AddToGiveWeaponMenu("SCAR" , "scar_zm");
		self AddToGiveWeaponMenu("SHIELD" , "tomb_shield_zm");
		self AddToGiveWeaponMenu("STAFF AIR MELEE" , "staff_air_melee_zm");
		self AddToGiveWeaponMenu("STAFF AIR" , "staff_air_zm");
		self AddToGiveWeaponMenu("STAFF AIR UP" , "staff_air_upgraded_zm");
		//self AddToGiveWeaponMenu("STAFF AIR UP2" , "staff_air_upgraded2_zm");
		//self AddToGiveWeaponMenu("STAFF AIR UP3" , "staff_air_upgraded3_zm");
		self AddToGiveWeaponMenu("STAFF FIRE MELEE" , "staff_fire_melee_zm");
		self AddToGiveWeaponMenu("STAFF FIRE" , "staff_fire_zm");
		self AddToGiveWeaponMenu("STAFF FIRE UP" , "staff_fire_upgraded_zm");
		//self AddToGiveWeaponMenu("STAFF FIRE UP2" , "staff_fire_upgraded2_zm");
		//self AddToGiveWeaponMenu("STAFF FIRE UP3" , "staff_fire_upgraded3_zm");
		self AddToGiveWeaponMenu("STAFF LIGHTNING MELEE" , "staff_lightning_melee_zm");
		self AddToGiveWeaponMenu("STAFF LIGHTNING" , "staff_lightning_zm");
		self AddToGiveWeaponMenu("STAFF LIGHTNING UP" , "staff_lightning_upgraded_zm");
		//self AddToGiveWeaponMenu("STAFF LIGHTNING UP2" , "staff_lightning_upgraded2_zm");
		//self AddToGiveWeaponMenu("STAFF LIGHTNING UP3" , "staff_lightning_upgraded3_zm");
		//self AddToGiveWeaponMenu("STAFF REVIVE" , "staff_revive_zm");
		//self AddToGiveWeaponMenu("STAFF WATER DART" , "staff_water_dart_zm");
		//self AddToGiveWeaponMenu("STAFF WATER DART" , "staff_water_fake_dart_zm");
		self AddToGiveWeaponMenu("STAFF WATER MELEE" , "staff_water_melee_zm");
		self AddToGiveWeaponMenu("STAFF WATER" , "staff_water_zm");
		self AddToGiveWeaponMenu("STAFF WATER UP" , "staff_water_upgraded_zm");
		//self AddToGiveWeaponMenu("STAFF WATER UP2" , "staff_water_upgraded2_zm");
		//self AddToGiveWeaponMenu("STAFF WATER UP3" , "staff_water_upgraded3_zm");
		//self AddToGiveWeaponMenu("STAFF WATER CHEAP" , "staff_water_zm_cheap");
		if (isDefined(self.dig_vars))
		{ 
			self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "SHOVEL", ::Give_Shovel);
			self.countmenuequip ++;
			if (self.countmenuequip >= level.menuweapmaxitemperpage)
			{
				self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "> Next Page", ::submenu, "weapons_menu_give_equip_" + (self.countmenuequip_p + 1));
				self add_menu("weapons_menu_give_equip_" + (self.countmenuequip_p + 1), "weapons_menu_give_equip_" + self.countmenuequip_p, "Access Level 1");
				self.countmenuequip_p ++;
				self.countmenuequip = 0;
			}
			self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "GOLDEN SHOVEL", ::Give_GoldenShovel);
			self.countmenuequip ++;
			if (self.countmenuequip >= level.menuweapmaxitemperpage)
			{
				self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "> Next Page", ::submenu, "weapons_menu_give_equip_" + (self.countmenuequip_p + 1));
				self add_menu("weapons_menu_give_equip_" + (self.countmenuequip_p + 1), "weapons_menu_give_equip_" + self.countmenuequip_p, "Access Level 1");
				self.countmenuequip_p ++;
				self.countmenuequip = 0;
			}
			self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "HELMET", ::Give_Helmet);
			self.countmenuequip ++;
			if (self.countmenuequip >= level.menuweapmaxitemperpage)
			{
				self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "> Next Page", ::submenu, "weapons_menu_give_equip_" + (self.countmenuequip_p + 1));
				self add_menu("weapons_menu_give_equip_" + (self.countmenuequip_p + 1), "weapons_menu_give_equip_" + self.countmenuequip_p, "Access Level 1");
				self.countmenuequip_p ++;
				self.countmenuequip = 0;
			}
		}
	}
	//Add Menu Option
	if ((self.countmenuweap > 0) || (self.countmenuweap_p > 0))
		self add_option("weapons_menu", "> Give Primary Weapon", ::submenu, "weapons_menu_give_weap_0");
	if ((self.countmenuequip > 0) || (self.countmenuequip_p > 0))
		self add_option("weapons_menu", "> Give Equipement", ::submenu, "weapons_menu_give_equip_0");
	if ((self.countmenumelee > 0) || (self.countmenumelee_p > 0))
		self add_option("weapons_menu", "> Give Melee Weapons", ::submenu, "weapons_menu_give_melee_0");
	if ((self.countmenulethal > 0) || (self.countmenulethal_p > 0))
		self add_option("weapons_menu", "> Give Lethal Grenade", ::submenu, "weapons_menu_give_lethal_0");
	if ((self.countmenutactical > 0) || (self.countmenutactical_p > 0))
		self add_option("weapons_menu", "> Give Tactical Grenade", ::submenu, "weapons_menu_give_tactical_0");
	//if ((self.countmenuoffhand > 0) || (self.countmenuoffhand_p > 0))
	//	self add_option("weapons_menu", "> Give Offhand Weapon", ::submenu, "weapons_menu_give_offhand_0");
	//if ((self.countmenuextra > 0) || (self.countmenuextra_p > 0))
	//	self add_option("weapons_menu", "> Give Others Weapon", ::submenu, "weapons_menu_give_extra_0");
	//
	self add_option("weapons_menu", "> PackAPunch", ::submenu, "weapons_mods_menu_pap");
	self add_menu("weapons_mods_menu_pap", "weapons_menu", "Access Level 1");
	self add_option("weapons_mods_menu_pap", "Upgrade Current Weapon", ::PackCurrentWeapon_NzV, false);
	self add_option("weapons_mods_menu_pap", "Upgrade Current Weapon+", ::PackCurrentWeapon_NzV, true);	
	self add_option("weapons_mods_menu_pap", "Unupgrade Current Weapon", ::UnpackCurrentWeapon_NzV);	
	self add_option("weapons_menu", "Unlimited Ammo", ::Toggle_Ammo_NzV);
	if (level.script != "zm_nuked")
		self add_option("weapons_menu", "Equipement Stay Healthy", ::Toggle_EquipementStayHealthy_NzV);		
	self add_option(BaseMenuName, "Weapon Mods", ::submenu, "weapons_mods_menu");	
	self add_menu("weapons_mods_menu", BaseMenuName, "Access Level 1");
	self add_option("weapons_mods_menu", "> Set Field Of View", ::submenu, "weapons_mods_menu_fov");
	self add_option("weapons_mods_menu", "> Set Spread", ::submenu, "weapons_mods_menu_spread");
	self add_option("weapons_mods_menu", "> Set Weapon Death of Field", ::submenu, "weapons_mods_menu_dofield");
	self add_menu("weapons_mods_menu_fov", "weapons_mods_menu", "Access Level 1");
    foreach(fov in array(5,15,25,45,55))
    		self add_option("weapons_mods_menu_fov", "^7FOV = ^2" + fov + "^7", ::MySetFOV, fov);
    self add_option("weapons_mods_menu_fov", "^2Reset FOV^7", ::MySetFOV, 65);
    foreach(fov2 in array(75,85,100,125,150))
    		self add_option("weapons_mods_menu_fov", "^7FOV = ^2" + fov2 + "^7", ::MySetFOV, fov2); 	
    self add_menu("weapons_mods_menu_dofield", "weapons_mods_menu", "Access Level 1");
    foreach(dof_viewmodel in array(0,1,5,8,9))
    		self add_option("weapons_mods_menu_dofield", "^7DoF = ^2" + dof_viewmodel + "^7", ::MySetDOF_Weapon, dof_viewmodel);
    self add_option("weapons_mods_menu_dofield", "^2Reset DoF^7", ::MySetDOF_Weapon, 10);
    foreach(dof_viewmodel_2 in array(15,20,25,30,50))
    		self add_option("weapons_mods_menu_dofield", "^7DoF = ^2" + dof_viewmodel_2 + "^7", ::MySetDOF_Weapon, dof_viewmodel_2); 	
    		
   	 self add_menu("weapons_mods_menu_spread", "weapons_mods_menu", "Access Level 1");
    foreach(spread_value in array(1,2,3,4,5,7.5,10,15,30,50))
    		self add_option("weapons_mods_menu_spread", "^7Spread = ^2" + spread_value + "^7", ::MySetSpead, spread_value);
    		self add_option("weapons_mods_menu_spread", "^7Reset Spread Overwrite", ::MySetSpead_R);
    		
	self add_option("weapons_mods_menu", "Left Hand Gun", ::Toggle_LeftGun);
	self add_option("weapons_mods_menu", "Advanced Left Hand Gun", ::Toggle_AdvancedLeftGun);
	self add_option("weapons_mods_menu", "Hide Gun", ::Toggle_HideWeapon);
	self add_option("weapons_mods_menu", "Drop Gun", ::WeaponDropp);
    self add_option("weapons_mods_menu", "Hide Crosshair", ::Toggle_HideCrosshair);
	self add_option("weapons_mods_menu", "Teleport Me Gun", ::Toggle_TeleportGun);	

	self add_option(BaseMenuName, "Bullets Mods", ::submenu, "weapons_menu_bullets");	
	self add_menu("weapons_menu_bullets", BaseMenuName, "Access Level 1");
	self add_option("weapons_menu_bullets", "Explosive Bullets", ::Toggle_ExplosiveBullets);
	self add_option("weapons_menu_bullets", "Ricochet Bullets", ::Toggle_RicochetBullet);
	self add_option("weapons_menu_bullets", "Flame Trowher", ::Toggle_FlameTrowher);				
	self add_option("weapons_menu_bullets", "> Fx Bullets", ::submenu, "weapons_menu_bullets_fx_0");	
	
	//Bullets
	
	
	//self FxBulletsMenuUpdate();
	self add_menu("weapons_menu_bullets_fx_0", "weapons_menu_bullets", "Access Level 1");
	self add_option("weapons_menu_bullets_fx_0", "Fx Bullets System", ::ListfxGuns);
	
	self add_option("weapons_menu_bullets", "> Weapon Bullets", ::submenu, "weapons_menu_bullets_weap");	
	self add_menu("weapons_menu_bullets_weap", "weapons_menu_bullets", "Access Level 1");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("m1911_upgraded_zm"))
		self add_option("weapons_menu_bullets_weap", "M1911 Up", ::Toggle_ModdedWeaponBullets, "m1911_upgraded_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("usrpg_zm"))	
		self add_option("weapons_menu_bullets_weap", "RPG", ::Toggle_ModdedWeaponBullets, "usrpg_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("usrpg_upgraded_zm"))	
		self add_option("weapons_menu_bullets_weap", "RPG Up", ::Toggle_ModdedWeaponBullets, "usrpg_upgraded_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("ray_gun_zm"))	
		self add_option("weapons_menu_bullets_weap", "RayGun", ::Toggle_ModdedWeaponBullets, "ray_gun_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("ray_gun_upgraded_zm"))	
		self add_option("weapons_menu_bullets_weap", "RayGun Up", ::Toggle_ModdedWeaponBullets, "ray_gun_upgraded_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("raygun_mark2_zm"))	
		self add_option("weapons_menu_bullets_weap", "RayGun M2", ::Toggle_ModdedWeaponBullets, "raygun_mark2_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("raygun_mark2_upgraded_zm"))	
		self add_option("weapons_menu_bullets_weap", "RayGun M2 Up", ::Toggle_ModdedWeaponBullets, "raygun_mark2_upgraded_zm");
	if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("knife_ballistic_upgraded_zm"))	
		self add_option("weapons_menu_bullets_weap", "Ballistic Knife Up", ::Toggle_ModdedWeaponBullets, "knife_ballistic_upgraded_zm");
	if ((level.script == "zm_highrise") && (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("slipgun_zm")))	
		self add_option("weapons_menu_bullets_weap", "Slipgun", ::Toggle_ModdedWeaponBullets, "slipgun_zm");
	if (level.script == "zm_prison")
	{
		if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("blundergat_zm"))	
			self add_option("weapons_menu_bullets_weap", "Blundergat", ::Toggle_ModdedWeaponBullets, "blundergat_zm");
		if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included("blundersplat_zm"))	
			self add_option("weapons_menu_bullets_weap", "Blundersplat", ::Toggle_ModdedWeaponBullets, "blundersplat_zm");
	}
	//-----------------------------------
	// Perks Menu ("Access Level 1")
	//-----------------------------------
	self add_option(BaseMenuName, "Perk Menu", ::submenu, "perks_menu");	
	self add_menu("perks_menu", BaseMenuName, "Access Level 1");
   	self add_option("perks_menu", "Give All Perks", ::GiveAllPerks);
   	self add_option("perks_menu", "Remove All Perks", ::RemoveAllPerks);
	if (isDefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
		self add_option("perks_menu", "Juggernaut", ::Toggle_PlayerPerk, "specialty_armorvest");	
	if (isDefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	  self add_option("perks_menu", "Sleight Of Hand", ::Toggle_PlayerPerk, "specialty_fastreload");
	if (isDefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	   self add_option("perks_menu", "Quick Revive", ::Toggle_PlayerPerk, "specialty_quickrevive");
	if (isDefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk)  
	   self add_option("perks_menu", "Double Tap", ::Toggle_PlayerPerk, "specialty_rof");
	if (isDefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	    self add_option("perks_menu", "Marathon", ::Toggle_PlayerPerk, "specialty_longersprint");
	if(isDefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
		self add_option("perks_menu", "Mule Kick", ::Toggle_PlayerPerk, "specialty_additionalprimaryweapon");
	if (isDefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	    self add_option("perks_menu", "Deadshot", ::Toggle_PlayerPerk, "specialty_deadshot");
	if (isDefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
		self add_option("perks_menu", "Tombstone", ::Toggle_PlayerPerk, "specialty_scavenger");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_flakjacket"]) && (level.script != "zm_buried"))
		self add_option("perks_menu", "Dive To Nuke", ::Toggle_PlayerPerk, "specialty_flakjacket"); 
	if (isDefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
		self add_option("perks_menu", "Chugabud", ::Toggle_PlayerPerk, "specialty_finalstand");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_nomotionsensor"]))
		self add_option("perks_menu", "Vulture", ::Toggle_PlayerPerk, "specialty_nomotionsensor"); 
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_grenadepulldeath"]))
		self add_option("perks_menu", "Electric Cherry", ::Toggle_PlayerPerk, "specialty_grenadepulldeath"); 
	//-----------------------------------
	// PermaPerks Menu (Perks Menu SubMenu) ("Access Level 2")
	//-----------------------------------
	if ((level.script == "zm_transit") || (level.script == "zm_buried") || (level.script == "zm_highrise"))
	{
		if  (sessionmodeisonlinegame() && (maps/mp/zombies/_zm_pers_upgrades::is_pers_system_active() == 1) && (1 < level.pers_upgrades_keys.size) && (level.pers_upgrades_keys.size < 32))
		{
			self add_option("perks_menu", "PermaPerk Menu", ::submenu, "perks_menu_perma");
			self add_menu("perks_menu_perma", "perks_menu", "Access Level 2");
			for(i = 0; i < level.pers_upgrades_keys.size; i++)
				self add_option("perks_menu_perma", level.pers_upgrades_keys[i], ::GivePermaPerk_NzV, level.pers_upgrades_keys[i]);
		}
	}
	//-----------------------------------
	// PowerUps Menu ("Access Level 2")
	//-----------------------------------
	if (isDefined(level.zombie_include_powerups) && (level.zombie_include_powerups.size > 0)) 	
	{
		self add_option(BaseMenuName, "PowerUps Menu", ::submenu, "powerups_menu");
		self add_menu("powerups_menu", BaseMenuName, "Access Level 2");
		self add_option("powerups_menu", "Shoot PowerUps", ::Toggle_ShootPowerUps);
		if (isDefined( level.zombie_include_powerups["nuke"]))
	   		self add_option("powerups_menu", "Nuke Bomb", ::GivePowerUp_NzV, "nuke");
		if (isDefined( level.zombie_include_powerups["green_nuke"]))
	   		self add_option("powerups_menu", "Green Nuke Bomb", ::GivePowerUp_NzV, "green_nuke");
		if (isDefined( level.zombie_include_powerups["red_nuke"]))
	   		self add_option("powerups_menu", "Red Nuke Bomb", ::GivePowerUp_NzV, "red_nuke");
		if (isDefined( level.zombie_include_powerups["yellow_nuke"]))
	   		self add_option("powerups_menu", "Yellow Nuke Bomb", ::GivePowerUp_NzV, "yellow_nuke");
		if (isDefined( level.zombie_include_powerups["insta_kill"]))
	   		self add_option("powerups_menu", "Insta Kill", ::GivePowerUp_NzV, "insta_kill");
		if (isDefined( level.zombie_include_powerups["green_insta"]))
	   		self add_option("powerups_menu", "Green Insta Kill", ::GivePowerUp_NzV, "green_insta");
		if (isDefined(level.zombie_include_powerups["insta_kill_ug"]))
	   		self add_option("powerups_menu", "Insta Kill Ug", ::GivePowerUp_NzV, "insta_kill_ug");	
		if (isDefined(level.zombie_include_powerups["full_ammo"]))
	   		self add_option("powerups_menu", "Full Ammo", ::GivePowerUp_NzV, "full_ammo");
		if (isDefined(level.zombie_include_powerups["green_ammo"]))
	   		self add_option("powerups_menu", "Green Full Ammo", ::GivePowerUp_NzV, "green_ammo");
		if (isDefined(level.zombie_include_powerups["red_ammo"]))
	   		self add_option("powerups_menu", "Red Full Ammo", ::GivePowerUp_NzV, "red_ammo");
		if (isDefined(level.zombie_include_powerups["double_points"]))
	   		self add_option("powerups_menu", "Double Points", ::GivePowerUp_NzV, "double_points");
		if (isDefined(level.zombie_include_powerups["green_double"]))
	   		self add_option("powerups_menu", "Green Double Points", ::GivePowerUp_NzV, "green_double");
		if (isDefined(level.zombie_include_powerups["yellow_double"]))
	   		self add_option("powerups_menu", "Red Double Points", ::GivePowerUp_NzV, "red_double");
		if (isDefined(level.zombie_include_powerups["yellow_double"]))
	   		self add_option("powerups_menu", "Yellow Double Points", ::GivePowerUp_NzV, "yellow_double");
		if (isDefined(level.zombie_include_powerups["carpenter"]))
	   		self add_option("powerups_menu", "Carpenter", ::GivePowerUp_NzV, "carpenter");
		if (isDefined(level.zombie_include_powerups["fire_sale"]))
	   		self add_option("powerups_menu", "Fire Sale", ::GivePowerUp_NzV, "fire_sale");
		if (isDefined(level.zombie_include_powerups["bonfire_sale"]))
	   		self add_option("powerups_menu", "Bonfire Sale", ::GivePowerUp_NzV, "bonfire_sale");
		if (isDefined(level.zombie_include_powerups["minigun"]))
	   		self add_option("powerups_menu", "Minigun", ::GivePowerUp_NzV, "minigun");
		if (isDefined(level.zombie_include_powerups["free_perk"]))
	   		self add_option("powerups_menu", "Free Perk", ::GivePowerUp_NzV, "free_perk");
		if (isDefined(level.zombie_include_powerups["tesla"]))
	   		self add_option("powerups_menu", "Tesla", ::GivePowerUp_NzV, "tesla");
		if (isDefined(level.zombie_include_powerups["random_weapon"]))
	   		self add_option("powerups_menu", "Random Weapon", ::GivePowerUp_NzV, "random_weapon");
		if (isDefined(level.zombie_include_powerups["teller_withdrawl"]))
	   		self add_option("powerups_menu", "Bank Points", ::GivePowerUp_NzV, "teller_withdrawl");
		if (isDefined(level.zombie_include_powerups["bonus_points_player"]))
	   		self add_option("powerups_menu", "Bonus Points Player", ::GivePowerUp_NzV, "bonus_points_player");
		if (isDefined(level.zombie_include_powerups["lose_points_player"]))
	   		self add_option("powerups_menu", "Lose Points Player", ::GivePowerUp_NzV, "lose_points_player");
		if (isDefined(level.zombie_include_powerups["bonus_points_team"]))
	   		self add_option("powerups_menu", "Bonus Points Team", ::GivePowerUp_NzV, "bonus_points_team");
		if (isDefined(level.zombie_include_powerups["lose_points_team"]))
	   		self add_option("powerups_menu", "Lose Points Team", ::GivePowerUp_NzV, "lose_points_team");
		if (isDefined(level.zombie_include_powerups["lose_perk"]))
	   		self add_option("powerups_menu", "Lose Perk", ::GivePowerUp_NzV, "lose_perk");
		if (isDefined(level.zombie_include_powerups["empty_clip"]))
	   		self add_option("powerups_menu", "Empty Clip", ::GivePowerUp_NzV, "empty_clip");
		if (isDefined(level.zombie_include_powerups["meat_stink"]))
	   		self add_option("powerups_menu", "Meat Stink", ::GivePowerUp_NzV, "meat_stink");
		if (isDefined(level.zombie_include_powerups["the_cure"]))
	   		self add_option("powerups_menu", "The Cure", ::GivePowerUp_NzV, "the_cure");
		if (isDefined(level.zombie_include_powerups["blue_monkey"]))
	   		self add_option("powerups_menu", "Blue Monkey", ::GivePowerUp_NzV, "blue_monkey");
		if (isDefined(level.zombie_include_powerups["green_monkey"]))
	   		self add_option("powerups_menu", "Green Monkey", ::GivePowerUp_NzV, "green_monkey");
		if (isDefined(level.zombie_include_powerups["zombie_blood"]))
	   		self add_option("powerups_menu", "Zombie Blood", ::GivePowerUp_NzV, "zombie_blood");
   	}
	//-----------------------------------
	// Forge Menu ("Access Level 3")
	//-----------------------------------
	self add_option(BaseMenuName, "Forge Menu", ::submenu, "forge_menu");
	self add_menu("forge_menu", BaseMenuName, "Access Level 3");
	self add_option("forge_menu", "Forge Mode", ::Toggle_ForgeMode);
	self add_option("forge_menu", "Advanced Forge Mode", ::Toggle_AdvancedForgeMode);
	//Spawn Effect
	self add_option("forge_menu", "> Set Entity Effect", ::submenu, "forge_menu_spawn_effect");
	self add_menu("forge_menu_spawn_effect", "forge_menu", "Access Level 3");
	self add_option("forge_menu_spawn_effect", "No Effect", ::SetEntityEffect_NzV, undefined);
	self add_option("forge_menu_spawn_effect", "Flipping Effect", ::SetEntityEffect_NzV, "Flipping");
	self add_option("forge_menu_spawn_effect", "Rolling Effect", ::SetEntityEffect_NzV, "Rolling");
	self add_option("forge_menu_spawn_effect", "Spinning Effect", ::SetEntityEffect_NzV, "Spinning");
	self add_option("forge_menu_spawn_effect", "Ice Skater Effect", ::SetEntityEffect_NzV, "IceSkater");
	self add_option("forge_menu_spawn_effect", "Trap Effect", ::SetEntityEffect_NzV, "Trap");
	//Spawn Perk Vendor
	self add_option("forge_menu", "> Spawn Perk Vendor", ::submenu, "forge_menu_spawn_vending");
	self add_menu("forge_menu_spawn_vending", "forge_menu", "Access Level 3");
	if (isDefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
	{
		self add_option("forge_menu_spawn_vending", "Juggernaut Off", ::SpawnEntity_NzV, "zombie_vending_jugg");
		self add_option("forge_menu_spawn_vending", "Juggernaut On", ::SpawnEntity_NzV, "zombie_vending_jugg_on");	
	}	
	if (isDefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	{
		self add_option("forge_menu_spawn_vending", "Sleight Off", ::SpawnEntity_NzV, "zombie_vending_sleight");	
		self add_option("forge_menu_spawn_vending", "Sleight On", ::SpawnEntity_NzV, "zombie_vending_sleight_on");
	}	
	if (isDefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	{
		self add_option("forge_menu_spawn_vending", "Quick Revive Off", ::SpawnEntity_NzV, "zombie_vending_revive");
		self add_option("forge_menu_spawn_vending", "Quick Revive On", ::SpawnEntity_NzV, "zombie_vending_revive_on");
	}
	if (isDefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk) 
	{
		self add_option("forge_menu_spawn_vending", "Double Tap Off", ::SpawnEntity_NzV, "zombie_vending_doubletap2");
		self add_option("forge_menu_spawn_vending", "Double Tap On", ::SpawnEntity_NzV, "zombie_vending_doubletap2_on");
	}
	if(isDefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
	{
		self add_option("forge_menu_spawn_vending", "Mule Kick Off", ::SpawnEntity_NzV, "zombie_vending_three_gun");
		self add_option("forge_menu_spawn_vending", "Mule Kick On", ::SpawnEntity_NzV, "zombie_vending_three_gun_on");	
	}	
	if (isDefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	{
		self add_option("forge_menu_spawn_vending", "Deadshot Off", ::SpawnEntity_NzV, "zombie_vending_ads");	
		self add_option("forge_menu_spawn_vending", "Deadshot On", ::SpawnEntity_NzV, "zombie_vending_ads_on");
	}		
	if (isDefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	{
		self add_option("forge_menu_spawn_vending", "Marathon Off", ::SpawnEntity_NzV, "zombie_vending_marathon");	
		self add_option("forge_menu_spawn_vending", "Marathon On", ::SpawnEntity_NzV, "zombie_vending_marathon_on");
	}	
	if (isDefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
	{
		self add_option("forge_menu_spawn_vending", "Tombstone Off", ::SpawnEntity_NzV, "zombie_vending_tombstone");
		self add_option("forge_menu_spawn_vending", "Tombstone On", ::SpawnEntity_NzV, "zombie_vending_tombstone_on");		
	}
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_flakjacket"]) && (level.script != "zm_buried"))
	{
		self add_option("forge_menu_spawn_vending", "Dive To Nuke Off", ::SpawnEntity_NzV, "zombie_vending_nuke");	
		self add_option("forge_menu_spawn_vending", "Dive To Nuke On", ::SpawnEntity_NzV, "zombie_vending_nuke_on");
	}
	if (isDefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
	{
		self add_option("forge_menu_spawn_vending", "Chugabud Off", ::SpawnEntity_NzV, "p6_zm_vending_chugabud_on");	
		self add_option("forge_menu_spawn_vending", "Chugabud On", ::SpawnEntity_NzV, "p6_zm_vending_chugabud_on");	
	}
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_nomotionsensor"]))
	{
		self add_option("forge_menu_spawn_vending", "Vulture Off", ::SpawnEntity_NzV, "p6_zm_vending_vultureaid");	
		self add_option("forge_menu_spawn_vending", "Vulture On", ::SpawnEntity_NzV, "p6_zm_vending_vultureaid_on");	
	}
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_grenadepulldeath"]))
	{
		self add_option("forge_menu_spawn_vending", "Electric Cherry Off", ::SpawnEntity_NzV, "p6_zm_vending_electric_cherry");
		self add_option("forge_menu_spawn_vending", "Electric Cherry On", ::SpawnEntity_NzV, "p6_zm_vending_electric_cherry_on");
	}
	//Spawn Player/Zombie
	self add_option("forge_menu", "> Spawn Player/Zombie", ::submenu, "forge_menu_spawn_player");
	self add_menu("forge_menu_spawn_player", "forge_menu", "Access Level 3");
	self add_option("forge_menu_spawn_player", "Default Actor", ::SpawnEntity_NzV, "defaultactor");
	if ((level.script == "zm_transit") || (level.script == "zm_buried") || (level.script == "zm_highrise")) 
	{
		self add_option("forge_menu_spawn_player", "Engineer", ::SpawnEntity_NzV, "c_zom_player_engineer_" + ((level.script == "zm_highrise") ? "dlc1_" : "") + "fb");
		self add_option("forge_menu_spawn_player", "Farmgirl", ::SpawnEntity_NzV, "c_zom_player_farmgirl_" + ((level.script == "zm_highrise") ? "dlc1_" : "") + "fb");
		self add_option("forge_menu_spawn_player", "Oldman", ::SpawnEntity_NzV, "c_zom_player_oldman_" + ((level.script == "zm_highrise") ? "dlc1_" : "") + "fb");
		self add_option("forge_menu_spawn_player", "Reporter", ::SpawnEntity_NzV, "c_zom_player_reporter_" + ((level.script == "zm_highrise") ? "dlc1_" : "") + "fb");
	
    }
    if (level.script == "zm_transit")
    {
		self add_option("forge_menu_spawn_player", "Bus Driver", ::SpawnEntity_NzV, "p6_anim_zm_bus_driver");
		self add_option("forge_menu_spawn_player", "Screecher", ::SpawnEntity_NzV, "c_zom_screecher_fb");
		self add_option("forge_menu_spawn_player", "Avagadro", ::SpawnEntity_NzV, "c_zom_avagadro_fb");
		self add_option("forge_menu_spawn_player", "Zombie Body", ::SpawnEntity_NzV, "c_zom_zombie1_body01");
    }
    else if (level.script == "zm_highrise")
    {
		self add_option("forge_menu_spawn_player", "Leaper Body", ::SpawnEntity_NzV, "c_zom_leaper_body");
    }
    else if (level.script == "zm_nuked")
    {
		self add_option("forge_menu_spawn_player", "Male 1", ::SpawnEntity_NzV, "dest_zm_nuked_male_01_d0");
		self add_option("forge_menu_spawn_player", "Male 2", ::SpawnEntity_NzV, "dest_zm_nuked_male_02_d0");
		self add_option("forge_menu_spawn_player", "Female 1", ::SpawnEntity_NzV, "dest_zm_nuked_female_01_d0");
		self add_option("forge_menu_spawn_player", "Female 2", ::SpawnEntity_NzV, "dest_zm_nuked_female_02_d0");
		self add_option("forge_menu_spawn_player", "Female 3", ::SpawnEntity_NzV, "dest_zm_nuked_female_03_d0");
    }
    else if (level.script == "zm_prison")
    {
		self add_option("forge_menu_spawn_player", "Handsome", ::SpawnEntity_NzV, "c_zom_player_handsome_fb");
		self add_option("forge_menu_spawn_player", "Oleary", ::SpawnEntity_NzV, "c_zom_player_oleary_fb");
		self add_option("forge_menu_spawn_player", "Deluca", ::SpawnEntity_NzV, "c_zom_player_deluca_fb");
		self add_option("forge_menu_spawn_player", "Arlington", ::SpawnEntity_NzV, "c_zom_player_arlington_fb");
		self add_option("forge_menu_spawn_player", "Cell Breaker", ::SpawnEntity_NzV, "c_zom_cellbreaker_fb");
		self add_option("forge_menu_spawn_player", "Guard Body", ::SpawnEntity_NzV, "c_zom_guard_body");
		self add_option("forge_menu_spawn_player", "Wolf Head", ::SpawnEntity_NzV, "c_zom_wolf_head");
		self add_option("forge_menu_spawn_player", "Inmate Body", ::SpawnEntity_NzV, "c_zom_inmate_body1");
    }
    else if (level.script == "zm_buried")
    {
		self add_option("forge_menu_spawn_player", "Ghost Woman", ::SpawnEntity_NzV, "c_zom_zombie_buried_ghost_woman_fb");
		self add_option("forge_menu_spawn_player", "Sgirl Body", ::SpawnEntity_NzV, "c_zom_zombie_buried_sgirl_body1");
    }
    else if (level.script == "zm_tomb")
    {
		self add_option("forge_menu_spawn_player", "Crusader Body", ::SpawnEntity_NzV, "c_zom_tomb_crusader_body_zc");
		self add_option("forge_menu_spawn_player", "German Hat", ::SpawnEntity_NzV, "c_zom_tomb_german_hat_2");
		self add_option("forge_menu_spawn_player", "German Player", ::SpawnEntity_NzV, "c_zom_tomb_german_player_fb");
		self add_option("forge_menu_spawn_player", "Robot", ::SpawnEntity_NzV, "veh_t6_dlc_zm_robot");
		self add_option("forge_menu_spawn_player", "Mech", ::SpawnEntity_NzV, "veh_t6_dlc_zm_mech");
    }
	//Spawn Vehicle
	self add_option("forge_menu", "> Spawn Vehicle", ::submenu, "forge_menu_spawn_vehicle");
	self add_menu("forge_menu_spawn_vehicle", "forge_menu", "Access Level 3");
	self add_option("forge_menu_spawn_vehicle", "Default Vehicle", ::SpawnEntity_NzV, "defaultvehicle");
	if (level.script == "zm_transit")
    {
		self add_option("forge_menu_spawn_vehicle", "Bus", ::SpawnEntity_NzV, "veh_t6_civ_bus_zombie");
		self add_option("forge_menu_spawn_vehicle", "Truck", ::SpawnEntity_NzV, "veh_t6_civ_movingtrk_cab_dead");
    }
    else if (level.script == "zm_nuked")
    {
		self add_option("forge_menu_spawn_vehicle", "Rocket", ::SpawnEntity_NzV, "p6_zm_nuked_rocket_cam");
    }
    
	else if (level.script == "zm_tomb")
    {
		self add_option("forge_menu_spawn_vehicle", "Tank", ::SpawnEntity_NzV, "veh_t6_dlc_mkiv_tank");
		self add_option("forge_menu_spawn_vehicle", "Zeppelin", ::SpawnEntity_NzV, "veh_t6_dlc_zm_zeppelin");
		self add_option("forge_menu_spawn_vehicle", "Biplane", ::SpawnEntity_NzV, "veh_t6_dlc_zm_biplane");
    }
	//Spawn Door
	self add_option("forge_menu", "> Spawn Door", ::submenu, "forge_menu_spawn_door");
	self add_menu("forge_menu_spawn_door", "forge_menu", "Access Level 3");
	if (level.script == "zm_transit")
    {
		self add_option("forge_menu_spawn_door", "Wood Door", ::SpawnEntity_NzV, "p_cub_door01_wood_fullsize");
		self add_option("forge_menu_spawn_door", "Roller Door", ::SpawnEntity_NzV, "p_rus_door_roller");
    }
    else if (level.script == "zm_highrise")
    {
		self add_option("forge_menu_spawn_door", "Luxury Door", ::SpawnEntity_NzV, "p6_zm_hr_luxury_door");
    }
    else if (level.script == "zm_nuked")
    {
		self add_option("forge_menu_spawn_door", "White Door", ::SpawnEntity_NzV, "p6_zm_door_white");
		self add_option("forge_menu_spawn_door", "Brown Door", ::SpawnEntity_NzV, "p6_zm_door_brown");
    }
    else if (( level.script == "zm_buried"))
    {
		self add_option("forge_menu_spawn_door", "Salon Door", ::SpawnEntity_NzV, "p6_zm_bu_saloon_door");
		self add_option("forge_menu_spawn_door", "Mansion Door R", ::SpawnEntity_NzV, "p6_zm_bu_mansion_door_right");
		self add_option("forge_menu_spawn_door", "Mansion Door L", ::SpawnEntity_NzV, "p6_zm_bu_mansion_door_left");
		self add_option("forge_menu_spawn_door", "Wood Door 1", ::SpawnEntity_NzV, "p6_zm_bu_wood_door_bare_right");
		self add_option("forge_menu_spawn_door", "Wood Door 2", ::SpawnEntity_NzV, "p6_zm_bu_wood_door_bare");
		self add_option("forge_menu_spawn_door", "Wood Door Red", ::SpawnEntity_NzV, "p6_zm_bu_wood_door_red");
		self add_option("forge_menu_spawn_door", "Wood Door Green", ::SpawnEntity_NzV, "p6_zm_bu_wood_door_green_right");
		self add_option("forge_menu_spawn_door", "Cell Door", ::SpawnEntity_NzV, "p6_anim_zm_bu_cell_door");
    }
	else if (level.script == "zm_tomb")
    {
		self add_option("forge_menu_spawn_door", "Tank", ::SpawnEntity_NzV, "p6_zm_tm_bunker_door");
    }
	//Spawn PowerUps
	if (isDefined(level.zombie_include_powerups) && (level.zombie_include_powerups.size > 0)) 	
	{
		self add_option("forge_menu", "> Spawn PowerUps", ::submenu, "forge_menu_spawn_powerups");
		self add_menu("forge_menu_spawn_powerups", "forge_menu", "Access Level 3");
		if (isDefined(level.zombie_include_powerups["nuke"]) || isDefined(level.zombie_include_powerups["green_nuke"]) || isDefined(level.zombie_include_powerups["yellow_nuke"]) || isDefined(level.zombie_include_powerups["red_nuke"]))
	   		self add_option("forge_menu_spawn_powerups", "Nuke Bomb", ::SpawnEntity_NzV, "zombie_bomb");
		if (isDefined(level.zombie_include_powerups["insta_kill"]) || isDefined(level.zombie_include_powerups["green_insta"]))
	   		self add_option("forge_menu_spawn_powerups", "Insta Kill", ::SpawnEntity_NzV, "zombie_skull");	
		if (isDefined(level.zombie_include_powerups["full_ammo"]) || isDefined(level.zombie_include_powerups["green_ammo"]) || isDefined(level.zombie_include_powerups["red_ammo"]))
	   		self add_option("forge_menu_spawn_powerups", "Max Ammo", ::SpawnEntity_NzV, "zombie_ammocan");
		if (isDefined(level.zombie_include_powerups["double_points"]) || isDefined(level.zombie_include_powerups["green_double"]) || isDefined(level.zombie_include_powerups["red_double"]) || isDefined(level.zombie_include_powerups["yellow_double"]))
	   		self add_option("forge_menu_spawn_powerups", "Double Points", ::SpawnEntity_NzV, "zombie_x2_icon");
		if (isDefined(level.zombie_include_powerups["carpenter"]))
	   		self add_option("forge_menu_spawn_powerups", "Carpenter", ::SpawnEntity_NzV, "zombie_carpenter");
		if (isDefined(level.zombie_include_powerups["fire_sale"]))
	   		self add_option("forge_menu_spawn_powerups", "Fire Sale", ::SpawnEntity_NzV, "zombie_firesale");
		if (isDefined(level.zombie_include_powerups["bonfire_sale"]))
	   		self add_option("forge_menu_spawn_powerups", "Bonfire Sale", ::SpawnEntity_NzV, "zombie_pickup_bonfire");
		if (isDefined(level.zombie_include_powerups["free_perk"]) || isDefined(level.zombie_include_powerups["lose_perk"]) || isDefined(level.zombie_include_powerups["the_cure"]))
	   		self add_option("forge_menu_spawn_powerups", "Perk", ::SpawnEntity_NzV, "zombie_pickup_perk_bottle");
		if (isDefined(level.zombie_include_powerups["random_weapon"]) || isDefined(level.zombie_include_powerups["tesla"]) || isDefined(level.zombie_include_powerups["minigun"]))
	   		self add_option("forge_menu_spawn_powerups", "Random Weapon", ::SpawnEntity_NzV, "zombie_pickup_minigun");
		if (isDefined(level.zombie_include_powerups["bonus_points_player"]) || isDefined(level.zombie_include_powerups["teller_withdrawl"]) || isDefined(level.zombie_include_powerups["lose_points_player"]) || isDefined(level.zombie_include_powerups["bonus_points_team"]) || isDefined(level.zombie_include_powerups["lose_points_team"]))
	   		self add_option("forge_menu_spawn_powerups", "Points", ::SpawnEntity_NzV, "zombie_z_money_icon");
		if (isDefined(level.zombie_include_powerups["meat_stink"]))
	   		self add_option("forge_menu_spawn_powerups", "Meat Stink", ::SpawnEntity_NzV, "t6_wpn_zmb_meat_world");
		if (isDefined(level.zombie_include_powerups["blue_monkey"]) || isDefined(level.zombie_include_powerups["green_monkey"]))
	   		self add_option("forge_menu_spawn_powerups", "Monkey", ::SpawnEntity_NzV, "weapon_zombie_monkey_bomb");
		if (isDefined(level.zombie_include_powerups["zombie_blood"]))
	   		self add_option("forge_menu_spawn_powerups", "Zombie Blood", ::SpawnEntity_NzV, "p6_zm_tm_blood_power_up");
	}
	//Spawn Buidables
	if (isDefined(level.zombie_include_buildables))
	{
		self add_option("forge_menu", "> Spawn Buidable", ::submenu, "forge_menu_spawn_buidables");
		self add_menu("forge_menu_spawn_buidables", "forge_menu", "Access Level 3");
		if (isDefined(level.zombie_include_buildables["bushatch"]) || isDefined(level.zombie_include_buildables["dinerhatch"]))
		{
			self add_option("forge_menu_spawn_buidables", "Bus/Dinner Hatch", ::SpawnEntity_NzV, "veh_t6_civ_bus_zombie_roof_hatch");
		}
		if (isDefined(level.zombie_include_buildables["busladder"]))
		{
			self add_option("forge_menu_spawn_buidables", "Bus Ladder", ::SpawnEntity_NzV, "com_stepladder_large_closed");
		}
		if (isDefined(level.zombie_include_buildables["cattlecatcher"]))
		{
			self add_option("forge_menu_spawn_buidables", "Cattle Catcher", ::SpawnEntity_NzV, "veh_t6_civ_bus_zombie_cow_catcher");
		}
		if (isDefined(level.zombie_include_buildables["electric_trap"]))
		{
			self add_option("forge_menu_spawn_buidables", "Electric Trap", ::SpawnEntity_NzV, "p6_anim_zm_buildable_etrap");
			self add_option("forge_menu_spawn_buidables", "Electric Trap Base", ::SpawnEntity_NzV, "p6_zm_buildable_etrap_base");
			self add_option("forge_menu_spawn_buidables", "Electric Trap TV Tube", ::SpawnEntity_NzV, "p6_zm_buildable_etrap_tvtube");
			self add_option("forge_menu_spawn_buidables", "Electric Trap Battery", ::SpawnEntity_NzV, "p6_zm_buildable_battery");
		}
		if (isDefined(level.zombie_include_buildables["headchopper_zm"]))
		{
			self add_option("forge_menu_spawn_buidables", "Head Chopper", ::SpawnEntity_NzV, "t6_wpn_zmb_chopper");
			self add_option("forge_menu_spawn_buidables", "Head Chopper", ::SpawnEntity_NzV, "t6_wpn_zmb_chopper_part_blade");
			self add_option("forge_menu_spawn_buidables", "Head Chopper", ::SpawnEntity_NzV, "t6_wpn_zmb_chopper_part_crank");
			self add_option("forge_menu_spawn_buidables", "Head Chopper", ::SpawnEntity_NzV, "t6_wpn_zmb_chopper_part_hinge");
			self add_option("forge_menu_spawn_buidables", "Head Chopper", ::SpawnEntity_NzV, "t6_wpn_zmb_chopper_part_mount");
		}
		if (isDefined(level.zombie_include_buildables["jetgun_zm"]))
		{
			self add_option("forge_menu_spawn_buidables", "Jet Gun", ::SpawnEntity_NzV, "t6_wpn_zmb_jet_gun_world");
			self add_option("forge_menu_spawn_buidables", "Jet Gun Wires", ::SpawnEntity_NzV, "p6_zm_buildable_jetgun_wires");
			self add_option("forge_menu_spawn_buidables", "Jet Gun Engine", ::SpawnEntity_NzV, "p6_zm_buildable_jetgun_engine");
			self add_option("forge_menu_spawn_buidables", "Jet Gun Guages", ::SpawnEntity_NzV, "p6_zm_buildable_jetgun_guages");
			self add_option("forge_menu_spawn_buidables", "Jet Gun Handles", ::SpawnEntity_NzV, "p6_zm_buildable_jetgun_handles");
		}
		if (isDefined(level.zombie_include_buildables["sq_common"]))
		{
			self add_option("forge_menu_spawn_buidables", "Nav Table Electric Box", ::SpawnEntity_NzV, "p6_zm_buildable_sq_electric_box");
			self add_option("forge_menu_spawn_buidables", "Nav Table Meteor", ::SpawnEntity_NzV, "p6_zm_buildable_sq_meteor");
			self add_option("forge_menu_spawn_buidables", "Nav Table Scaffoling", ::SpawnEntity_NzV, "p6_zm_buildable_sq_scaffolding");
			self add_option("forge_menu_spawn_buidables", "Nav Table Transceiver", ::SpawnEntity_NzV, "p6_zm_buildable_sq_transceiver");
		}
		if (isDefined(level.zombiemode_using_pack_a_punch) && level.zombiemode_using_pack_a_punch)
		{
			self add_option("forge_menu_spawn_buidables", "Pack A Punch Off", ::SpawnEntity_NzV, "p6_anim_zm_buildable_pap");
			self add_option("forge_menu_spawn_buidables", "Pack A Punch On", ::SpawnEntity_NzV, "p6_anim_zm_buildable_pap_on");
			if (isDefined(level.zombie_include_buildables["pap"]))
			{
				self add_option("forge_menu_spawn_buidables", "PAP Battery", ::SpawnEntity_NzV, "p6_zm_buildable_battery");
				self add_option("forge_menu_spawn_buidables", "PAP Dolly", ::SpawnEntity_NzV, "p6_zm_buildable_pap_body");
				self add_option("forge_menu_spawn_buidables", "PAP Dolly", ::SpawnEntity_NzV, "p6_zm_buildable_pap_table");
			}
		}
		if (isDefined(level.zombie_include_buildables["powerswitch"]))
		{
			self add_option("forge_menu_spawn_buidables", "Power Switch Body", ::SpawnEntity_NzV, "p6_zm_buildable_pswitch_body");
			self add_option("forge_menu_spawn_buidables", "Power Switch Lever", ::SpawnEntity_NzV, "p6_zm_buildable_pswitch_lever");
			self add_option("forge_menu_spawn_buidables", "Power Switch Hand", ::SpawnEntity_NzV, "p6_zm_buildable_pswitch_hand");
		}
		if (isDefined(level.zombie_include_buildables["riotshield_zm"]))
		{
			self add_option("forge_menu_spawn_buidables", "Shield", ::SpawnEntity_NzV, "t6_wpn_zmb_shield_world");
			self add_option("forge_menu_spawn_buidables", "Shield 2", ::SpawnEntity_NzV, "t6_wpn_zmb_shield_dmg1_world");
			self add_option("forge_menu_spawn_buidables", "Shield 3", ::SpawnEntity_NzV, "t6_wpn_zmb_shield_dmg2_world");
			self add_option("forge_menu_spawn_buidables", "Shield Dolly", ::SpawnEntity_NzV, "t6_wpn_zmb_shield_dolly");
			self add_option("forge_menu_spawn_buidables", "Shield Door", ::SpawnEntity_NzV, "t6_wpn_zmb_shield_door");
		}
		if (isDefined(level.zombie_include_buildables["slipgun_zm"]))
		{
			self add_option("forge_menu_spawn_buidables", "Split Gun", ::SpawnEntity_NzV, "t6_wpn_zmb_slipgun_world");
			self add_option("forge_menu_spawn_buidables", "Split Gun Extinguisher", ::SpawnEntity_NzV, "t6_zmb_buildable_slipgun_extinguisher");
			self add_option("forge_menu_spawn_buidables", "Split Gun Cooker", ::SpawnEntity_NzV, "t6_zmb_buildable_slipgun_cooker");
			self add_option("forge_menu_spawn_buidables", "Split Gun Foot", ::SpawnEntity_NzV, "t6_zmb_buildable_slipgun_foot");
			self add_option("forge_menu_spawn_buidables", "Split Gun Throttle", ::SpawnEntity_NzV, "t6_zmb_buildable_slipgun_throttle");

		}
		if (isDefined(level.zombie_include_buildables["keys_zm"]))
		{
			
			self add_option("forge_menu_spawn_buidables", "Keys", ::SpawnEntity_NzV, "P6_zm_hr_key");
		}
		if (isDefined(level.zombie_include_buildables["springpad_zm"]))
		{
			self add_option("forge_menu_spawn_buidables", "Spring Pad", ::SpawnEntity_NzV, "p6_anim_zm_buildable_tramplesteam");
			self add_option("forge_menu_spawn_buidables", "Spring Pad 2", ::SpawnEntity_NzV, "p6_anim_zm_buildable_view_tramplesteam");
			self add_option("forge_menu_spawn_buidables", "Spring Pad Door", ::SpawnEntity_NzV, "p6_zm_buildable_tramplesteam_door");
			self add_option("forge_menu_spawn_buidables", "Spring Pad Bellows", ::SpawnEntity_NzV, "p6_zm_buildable_tramplesteam_bellows");
			self add_option("forge_menu_spawn_buidables", "Spring Pad Flag", ::SpawnEntity_NzV, "p6_zm_buildable_tramplesteam_flag");
			self add_option("forge_menu_spawn_buidables", "Spring Pad Compressor", ::SpawnEntity_NzV, "p6_zm_buildable_tramplesteam_compressor");
		}
		if (isDefined(level.zombie_include_buildables["subwoofer_zm"]))
		{
			self add_option("forge_menu_spawn_buidables", "Sub Woofer", ::SpawnEntity_NzV, "t6_wpn_zmb_subwoofer");
			self add_option("forge_menu_spawn_buidables", "Sub Woofer", ::SpawnEntity_NzV, "t6_wpn_zmb_subwoofer_parts_speaker");
			self add_option("forge_menu_spawn_buidables", "Sub Woofer", ::SpawnEntity_NzV, "t6_wpn_zmb_subwoofer_parts_motor");
			self add_option("forge_menu_spawn_buidables", "Sub Woofer", ::SpawnEntity_NzV, "t6_wpn_zmb_subwoofer_parts_table");
			self add_option("forge_menu_spawn_buidables", "Sub Woofer", ::SpawnEntity_NzV, "t6_wpn_zmb_subwoofer_parts_mount");
		}
		if (isDefined(level.zombie_include_buildables["turbine"]))
		{
			self add_option("forge_menu_spawn_buidables", "Turbine", ::SpawnEntity_NzV, "p6_anim_zm_buildable_turbine");
			self add_option("forge_menu_spawn_buidables", "Turbine Fan", ::SpawnEntity_NzV, "p6_zm_buildable_turbine_fan");
			self add_option("forge_menu_spawn_buidables", "Turbine Rudder", ::SpawnEntity_NzV, "p6_zm_buildable_turbine_rudder");
			self add_option("forge_menu_spawn_buidables", "Turbine Mannequin", ::SpawnEntity_NzV, "p6_zm_buildable_turbine_mannequin");
		}
		if (isDefined(level.zombie_include_buildables["turret"]))
		{
			self add_option("forge_menu_spawn_buidables", "Turret", ::SpawnEntity_NzV, "p6_anim_zm_buildable_turret");
			self add_option("forge_menu_spawn_buidables", "Turret RPD", ::SpawnEntity_NzV, "t6_wpn_lmg_rpd_world");
			self add_option("forge_menu_spawn_buidables", "Turret Mower", ::SpawnEntity_NzV, "p6_zm_buildable_turret_mower");
			self add_option("forge_menu_spawn_buidables", "Turret Ammo", ::SpawnEntity_NzV, "p6_zm_buildable_turret_ammo");
		}
	}
	//Spawn Weapons
	self add_option("forge_menu", "> Spawn Weapons", ::submenu, "forge_menu_spawn_weapons");
	self add_menu("forge_menu_spawn_weapons", "forge_menu", "Access Level 3");
	if (self maps/mp/zombies/_zm_utility::is_tactical_grenade("cymbal_monkey_zm"))
		self add_option("forge_menu_spawn_weapons", "Monkey Bomb", ::SpawnEntity_NzV, "weapon_zombie_monkey_bomb");
	if (self maps/mp/zombies/_zm_utility::is_lethal_grenade("frag_grenade_zm"))
		self add_option("forge_menu_spawn_weapons", "Frag Grenade", ::SpawnEntity_NzV, "t6_wpn_grenade_frag_projectile");
	//Spawn Other
	self add_option("forge_menu", "> Spawn Other", ::submenu, "forge_menu_spawn_other");
	self add_menu("forge_menu_spawn_other", "forge_menu", "Access Level 3");
	if ((level.script == "zm_nuked") || (level.script == "zm_transit") || (level.script == "zm_buried") || (level.script == "zm_highrise"))
    {
		self add_option("forge_menu_spawn_other", "Magic Box", ::SpawnEntity_NzV, "p6_anim_zm_magic_box");
		self add_option("forge_menu_spawn_other", "Magic Box Fake", ::SpawnEntity_NzV, "p6_anim_zm_magic_box_fake");
		self add_option("forge_menu_spawn_other", "Teddy Bear", ::SpawnEntity_NzV, "zombie_teddybear");
    }
    if (level.script == "zm_transit" )
    {
		self add_option("forge_menu_spawn_other", "Tools Chest Tall", ::SpawnEntity_NzV, "p_glo_tools_chest_tall");
		self add_option("forge_menu_spawn_other", "Tools Chest Short", ::SpawnEntity_NzV, "p_glo_tools_chest_Short");
		self add_option("forge_menu_spawn_other", "Vault Hatch", ::SpawnEntity_NzV, "p6_zm_bank_vault_floor_hatch");
		self add_option("forge_menu_spawn_other", "Window Glass", ::SpawnEntity_NzV, "p6_zm_window_dest_glass_big");
    }
    else if (level.script == "zm_highrise" )
    {
		self add_option("forge_menu_spawn_other", "Elevator", ::SpawnEntity_NzV, "p6_anim_zm_hr_elevator_common");
		self add_option("forge_menu_spawn_other", "Hall Lion Statue", ::SpawnEntity_NzV, "p6_zm_hr_lion_statue_ball");
		self add_option("forge_menu_spawn_other", "Lion Statue", ::SpawnEntity_NzV, "p6_zm_hr_lion_statue");
		self add_option("forge_menu_spawn_other", "Elevator Indicator", ::SpawnEntity_NzV, "p6_zm_hr_elevator_indicator");
		self add_option("forge_menu_spawn_other", "Wirespark", ::SpawnEntity_NzV, "fxanim_gp_wirespark_med_lrg_mod");
    }
	self add_option("forge_menu", "Delete Entity", ::DeleteEntity_NzV);
	self add_option("forge_menu", "Delete All Entity", ::DeleteAllEntity_NzV);

	self add_option(BaseMenuName, "Zombie Mods Menu", ::submenu, "zombie_mods_menu");
	self add_menu("zombie_mods_menu", BaseMenuName, "Access Level 3");
	self add_option("zombie_mods_menu", "Disable Zombie Spawn",::Toggle_DisableZombiesSpawn);//TODO: added !
	self add_option("zombie_mods_menu", "Freez Zombies",::Toggle_FreezeZombies);//TODO: added !
	self add_option("zombie_mods_menu", "Headless Zombies",::Toggle_HeadLessZombie);//TODO: added !
	self add_option("zombie_mods_menu", "Invisible Zombies",::Toggle_HideZombie);//TODO: added !
	self add_option("zombie_mods_menu", "Kill All Zombies",::KillAllSwpanedZombies);//TODO: added ! SetZombieSpawnDelay   SetZombieLimit SetZombieRunSpeed
	self add_option("zombie_mods_menu", "Spawn Zombie",::SpawnZombie);//TODO: added !
	self add_option("zombie_mods_menu", "> Spawn Delay",::submenu, "zombie_mods_menu_spawndelay");//TODO: added !
	self add_option("zombie_mods_menu", "> Zombie Limit",::submenu, "zombie_mods_menu_limitspawn");//TODO: added !
	self add_option("zombie_mods_menu", "> Zombie Run Speed",::submenu, "zombie_mods_menu_runspeed");//TODO: added !
	
	self add_menu("zombie_mods_menu_spawndelay", "zombie_mods_menu", "Access Level 3");
	 foreach(value in array(0.1,0.5,1,2,3,4,5))
    		self add_option("zombie_mods_menu_spawndelay", "^7Zombies Spawn Delay ^2+" + value + "^7", ::SetZombieSpawnDelay, value);
    		
    self add_menu("zombie_mods_menu_limitspawn", "zombie_mods_menu", "Access Level 3");
	 foreach(value in array(1,5,10,20,25,30,50,75,100))
    		self add_option("zombie_mods_menu_limitspawn", "^7Limit Zombies ^2+" + value + "^7", ::SetZombieLimit, value);
    		
    self add_menu("zombie_mods_menu_runspeed", "zombie_mods_menu", "Access Level 3");
	 foreach(value in array(1,1.5,2,3,4,5,10,15,20))
    		self add_option("zombie_mods_menu_runspeed", "^7Run Speed ^2+" + value + "^7", ::SetZombieRunSpeed, value);
    
	//-----------------------------------
	// Server Mods ("Access Level 4")
	//-----------------------------------
	self add_option(BaseMenuName, "Server Mods Menu", ::submenu, "server_mods_menu");
	self add_menu("server_mods_menu", BaseMenuName, "Access Level 4");
	//> Mods from encore (structure)
	self add_option("server_mods_menu", "Super Jump",::Toggle_SuperJump);//TODO: added !
	self add_option("server_mods_menu", "Super Speed",::Toggle_SuperSpeed);//TODO: added !
	self add_option("server_mods_menu", "Super Gravity",::Toggle_Gravity);//TODO: added !
	//> Buildable
	if(isDefined(level.zombie_include_buildables) && (level.zombie_include_buildables.size > 0))
	{
		self add_option("server_mods_menu", "> Buildable", ::submenu, "server_mods_menu_buildable");
		self add_menu("server_mods_menu_buildable", "server_mods_menu", "Access Level 4");
		if (isDefined(level.zombie_include_buildables["bushatch"]))
			self add_option("server_mods_menu_buildable", "Bus Hatch", ::doBuildBuildable, "bushatch");
		if (isDefined(level.zombie_include_buildables["busladder"]))
			self add_option("server_mods_menu_buildable", "Bus Ladder", ::doBuildBuildable, "busladder");
		if (isDefined(level.zombie_include_buildables["cattlecatcher"]))
			self add_option("server_mods_menu_buildable", "Cattle Catcher", ::doBuildBuildable, "cattlecatcher");
		if (isDefined(level.zombie_include_buildables["dinerhatch"]))
			self add_option("server_mods_menu_buildable", "Diner Hatch", ::doBuildBuildable, "dinerhatch");
		if (isDefined(level.zombie_include_buildables["electric_trap"]))
			self add_option("server_mods_menu_buildable", "Electric Trap", ::doBuildBuildable, "electric_trap");
		if (isDefined(level.zombie_include_buildables["headchopper_zm"]))
			self add_option("server_mods_menu_buildable", "Head Chopper", ::doBuildBuildable, "headchopper_zm");
		if (isDefined(level.zombie_include_buildables["jetgun_zm"]))
			self add_option("server_mods_menu_buildable", "Jetgun", ::doBuildBuildable, "jetgun_zm");
		if (isDefined(level.zombie_include_buildables["sq_common"]))
			self add_option("server_mods_menu_buildable", "Nav Table", ::doBuildBuildable, "sq_common");
		if (isDefined(level.zombie_include_buildables["pap"]))
			self add_option("server_mods_menu_buildable", "Pack-A-Punch", ::doBuildBuildable, "pap");
		if (isDefined(level.zombie_include_buildables["powerswitch"]))
			self add_option("server_mods_menu_buildable", "Power Switch", ::doBuildBuildable, "powerswitch");
		if (isDefined(level.zombie_include_buildables["riotshield_zm"]))
			self add_option("server_mods_menu_buildable", "Shield", ::doBuildBuildable, "riotshield_zm");
		if (isDefined(level.zombie_include_buildables["slipgun_zm"]))
			self add_option("server_mods_menu_buildable", "Slip Gun", ::doBuildBuildable, "slipgun_zm");
		if (isDefined(level.zombie_include_buildables["springpad_zm"]))
			self add_option("server_mods_menu_buildable", "Spring Pad", ::doBuildBuildable, "springpad_zm");
		if (isDefined(level.zombie_include_buildables["subwoofer_zm"]))
			self add_option("server_mods_menu_buildable", "Sub Woofer", ::doBuildBuildable, "subwoofer_zm");
		if (isDefined(level.zombie_include_buildables["turbine"]))
			self add_option("server_mods_menu_buildable", "Turbine", ::doBuildBuildable, "turbine");
		if (isDefined(level.zombie_include_buildables["turret"]))
			self add_option("server_mods_menu_buildable", "Turret", ::doBuildBuildable, "turret");
		//
		buildable_list =  array("buried_sq_oillamp", "buried_sq_tpo_switch", "buried_sq_ghost_lamp", "buried_sq_bt_m_tower", "buried_sq_bt_r_tower", "keys_zm", "ekeys_zm", "booze", "candy", "chalk", "sloth");
   		for(id = 0; id < buildable_list.size; id++)
		{
			name = buildable_list[id];
			if (isDefined(level.zombie_include_buildables[name]))
				self add_option("server_mods_menu_buildable", name, ::doBuildBuildable, name);
		}
	}
	//> Chat Setting
	self add_option("server_mods_menu", "> Chat Setting", ::submenu, "server_mods_menu_chat");
	self add_menu("server_mods_menu_chat", "server_mods_menu", "Access Level 4");
	self add_option("server_mods_menu_chat", "Dead Chat With Dead", ::Toggle_ChatSetting, "DeadChatWithDead");
	self add_option("server_mods_menu_chat", "Dead Chat With Team", ::Toggle_ChatSetting, "DeadChatWithTeam");
	self add_option("server_mods_menu_chat", "Dead Hear Team Living", ::Toggle_ChatSetting, "DeadHearTeamLiving");
	self add_option("server_mods_menu_chat", "Dead Hear All Living", ::Toggle_ChatSetting, "DeadHearAllLiving");
	self add_option("server_mods_menu_chat", "Everyone Hears Everyone", ::Toggle_ChatSetting, "EveryoneHearsEveryone");	
	//> Game Setting
	self add_option(BaseMenuName, "Game Setting", ::submenu, "server_mods_menu_gamesetting");
	self add_menu("server_mods_menu_gamesetting", BaseMenuName, "Access Level 4");
	self add_option("server_mods_menu_gamesetting", "> Round Editor", ::submenu, "server_mods_menu_gamesetting_roundeditor");
	self add_menu("server_mods_menu_gamesetting_roundeditor", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(score in array(10000,1000,100,10,1))
        self add_option("server_mods_menu_gamesetting_roundeditor", "^7Round Increase ^2" + score, ::AddRound, score);
    self add_option("server_mods_menu_gamesetting_roundeditor", "^7Round ^1Reset", ::AddRound, undefined);
    foreach(score in array(1,10,100,1000,10000))
        self add_option("server_mods_menu_gamesetting_roundeditor", "^7Round Decrease ^1 " + score, ::AddRound, (0-score));
	self add_option("server_mods_menu_gamesetting", "> Max Claymore Per Player", ::submenu, "server_mods_menu_gamesetting_claymore");
	self add_menu("server_mods_menu_gamesetting_claymore", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(ClaymoresLimit in array(5,10,20,30,40,50,70,80,90,100)) //DEF 12
		self add_option("server_mods_menu_gamesetting_claymore", "Set To ^2" + ClaymoresLimit + "^7", ::SetClaymoresLimit, ClaymoresLimit);
	self add_option("server_mods_menu_gamesetting", "> Set Gravity", ::submenu, "server_mods_menu_gamesetting_gravity");
	self add_menu("server_mods_menu_gamesetting_gravity", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(Gravity in array(1,10,50,100,250,500))
		self add_option("server_mods_menu_gamesetting_gravity", "Set To ^2" + Gravity + "^7", ::SetGravityMods, Gravity);
	self add_option("server_mods_menu_gamesetting_gravity", "^2Reset To Default (800)^7", ::SetGravityMods, 800);
	foreach(Gravity2 in array(900,1000,1250,1500,1750,2000,9999))
		self add_option("server_mods_menu_gamesetting_gravity", "Set To ^2" + Gravity2 + "^7", ::SetGravityMods, Gravity2);
	self add_option("server_mods_menu_gamesetting", "> Set Time Scales", ::submenu, "server_mods_menu_gamesetting_timescale");
	self add_menu("server_mods_menu_gamesetting_timescale", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(TimeScales in array(0.1,0.25,0.5,0.75))
		self add_option("server_mods_menu_gamesetting_timescale", "Set To ^2" + TimeScales + "^7", ::SetTimeScalesMods, TimeScales);
	self add_option("server_mods_menu_gamesetting_timescale", "^2Reset To Default (1)" + "^7", ::SetTimeScalesMods, 1);
	foreach(TimeScales2 in array(2,3,4,5,6,7,8,9,10))
		self add_option("server_mods_menu_gamesetting_timescale", "Set To ^2" + TimeScales2 + "^7", ::SetTimeScalesMods, TimeScales2);
	self add_option("server_mods_menu_gamesetting", "> Set Speed", ::submenu, "server_mods_menu_gamesetting_speed");
	self add_menu("server_mods_menu_gamesetting_speed", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(Speed in array(1,5,10,50,100,150))
		self add_option("server_mods_menu_gamesetting_speed", "Set To ^2" + Speed + "^7", ::SetAllSpeedMods, Speed);
	self add_option("server_mods_menu_gamesetting_speed", "^2Reset To Default (200)^7", ::SetAllSpeedMods, 200);
	foreach(Speed2 in array(250,300,400,500,750,1000))
		self add_option("server_mods_menu_gamesetting_speed", "Set To ^2" + Speed2 + "^7", ::SetAllSpeedMods, Speed2);	
	self add_option("server_mods_menu_gamesetting", "> Set Melee Range", ::submenu, "server_mods_menu_gamesetting_meleerange");
	self add_menu("server_mods_menu_gamesetting_meleerange", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(MeleeRange in array(1,5,10,25,35,50,100,200,300,400,500,750,1000))
		self add_option("server_mods_menu_gamesetting_meleerange", "Set To ^2" + MeleeRange + "^7", ::SetMeleeRangeMods, MeleeRange);
	self add_option("server_mods_menu_gamesetting", "> Set Revive Radius", ::submenu, "server_mods_menu_gamesetting_revivetr");
	self add_menu("server_mods_menu_gamesetting_revivetr", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(ReviveTriggerRadius in array(1,5,10,25,50))
		self add_option("server_mods_menu_gamesetting_revivetr", "Set To ^2" + ReviveTriggerRadius + "^7", ::SetReviveTriggerRadius, ReviveTriggerRadius);
	self add_option("server_mods_menu_gamesetting_revivetr", "^2Reset To Default (75)^7", ::SetReviveTriggerRadius, 75);
	foreach(ReviveTriggerRadius2 in array(100,150,200,250,500,750,1000,5000,9999))
		self add_option("server_mods_menu_gamesetting_revivetr", "Set To ^2" + ReviveTriggerRadius2 + "^7", ::SetReviveTriggerRadius, ReviveTriggerRadius2);
	self add_option("server_mods_menu_gamesetting", "> Set Last Stand Bleedout Time" + "^7", ::submenu, "server_mods_menu_gamesetting_laststandbt");
	self add_menu("server_mods_menu_gamesetting_laststandbt", "server_mods_menu_gamesetting", "Access Level 4");
	foreach(LastStandBleedoutTime in array(1,5,10,20,30,40))
		self add_option("server_mods_menu_gamesetting_laststandbt", "Set To ^2" + LastStandBleedoutTime + "^7", ::SetLastStandBleedoutTime, LastStandBleedoutTime);
	self add_option("server_mods_menu_gamesetting_laststandbt", "^2Reset To Default (45)^7", ::SetLastStandBleedoutTime, 45);
	foreach(LastStandBleedoutTime2 in array(50,75,100,250,500,750,1000,5000,9999))
		self add_option("server_mods_menu_gamesetting_laststandbt", "Set To ^2" + LastStandBleedoutTime2 + "^7", ::SetLastStandBleedoutTime, LastStandBleedoutTime2);
	self add_option("server_mods_menu_gamesetting", "Unmovable Magic Box", ::Toggle_MagicChestUnmovable);
	self add_option("server_mods_menu_gamesetting", "Head Shots Only", ::Toggle_HeadShotsOnly);
	//
	if (isDefined(level.zombie_include_powerups["insta_kill"]))
		self add_option("server_mods_menu", "Perma Insta Kill", ::Toggle_PermaInstaKill_NzV);
	self add_option("server_mods_menu", "Auto Revive", ::Toggle_AutoRevive);
	if (level.script != "zm_tomb")
		self add_option("server_mods_menu", "Open All Doors And Power On", ::OpenAllDoorsAndPowerOn);
	self add_option("server_mods_menu", "Hide/Show Magic Chest", ::Toggle_HideMagicChest);
	self add_option("server_mods_menu", "Set Perk Power", ::submenu, "server_mods_menu_perks");
	//
	self add_menu("server_mods_menu_perks", "server_mods_menu", "Access Level 4");
	if (isDefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
		self add_option("server_mods_menu_perks", "Juggernaut", ::Toggle_PerkPower, "specialty_armorvest");	
	if (isDefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	  self add_option("server_mods_menu_perks", "Sleight Of Hand", ::Toggle_PerkPower, "specialty_fastreload");
	if (isDefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	   self add_option("server_mods_menu_perks", "Quick Revive", ::Toggle_PerkPower, "specialty_quickrevive");
	if (isDefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk)  
	   self add_option("server_mods_menu_perks", "Double Tap", ::Toggle_PerkPower, "specialty_rof");
	if (isDefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	    self add_option("server_mods_menu_perks", "Marathon", ::Toggle_PerkPower, "specialty_longersprint");
	if(isDefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
		self add_option("server_mods_menu_perks", "Mule Kick", ::Toggle_PerkPower, "specialty_additionalprimaryweapon");
	if (isDefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	    self add_option("server_mods_menu_perks", "Deadshot", ::Toggle_PerkPower, "specialty_deadshot");
	if (isDefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
		self add_option("server_mods_menu_perks", "Tombstone", ::Toggle_PerkPower, "specialty_scavenger");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_flakjacket"]) && (level.script != "zm_buried"))
		self add_option("server_mods_menu_perks", "Dive To Nuke", ::Toggle_PerkPower, "specialty_flakjacket"); 
	if (isDefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
		self add_option("server_mods_menu_perks", "Chugabud", ::Toggle_PerkPower, "specialty_finalstand");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_nomotionsensor"]))
		self add_option("server_mods_menu_perks", "Vulture", ::Toggle_PerkPower, "specialty_nomotionsensor"); 
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_grenadepulldeath"]))
		self add_option("server_mods_menu_perks", "Electric Cherry", ::Toggle_PerkPower, "specialty_grenadepulldeath");
    //-----------------------------------
	// Host Mods ("Access Level 5")
	//-----------------------------------
	self add_option(BaseMenuName, "Host Mods Menu", ::submenu, "host_mods_menu");
	self add_menu("host_mods_menu", BaseMenuName, "Access Level 5");
	self add_option("host_mods_menu", "Force Host", ::Toggle_ForceHost);
	self add_option("host_mods_menu", "Anti Cheat", ::Toggle_AntiCheat);
	self add_option("host_mods_menu", "Anti Quit", ::Toggle_AntiQuit);
	self add_option("host_mods_menu", "doHeart", ::doHeart);
	self add_option("host_mods_menu", "Restart Game", ::doRestartGame);
	self add_option("host_mods_menu", "End Game", ::doEndGame);
	if ((level.script == "zm_transit") || (level.script == "zm_buried") || (level.script == "zm_highrise"))
	{
		if (sessionmodeisonlinegame())
		{
			self add_option("host_mods_menu", "doSecret", ::doSecret);
		}
	}
	//-----------------------------------
	// Account Mods ("Access Level 2") 
	//-----------------------------------
	self add_option(BaseMenuName, "Account Mods Menu", ::submenu, "account_mods_menu");
	self add_menu("account_mods_menu", BaseMenuName, "Access Level 2");
	//if (sessionmodeisonlinegame())
	//	{
			self UpdateStatsMapsMenu(); //starts Account Stats Menu
			self add_option("account_mods_menu", "> Set Stats", ::submenu, "statsmenu");
			self add_option("account_mods_menu", "> Rank Modification", ::submenu, "statsmenu_ativityrank");
			if ((level.script == "zm_transit") || (level.script == "zm_buried") || (level.script == "zm_highrise"))
			{
			self add_option("account_mods_menu", "> Set Bank Account", ::submenu, "account_mods_menu_bank");
			self add_menu("account_mods_menu_bank", "account_mods_menu", "Access Level 2");
			foreach(bank in array(250,100,50,10,5,1))
					self add_option("account_mods_menu_bank", "^2+" + bank + "K^7", ::SetBankAccount, bank);
			self add_option("account_mods_menu_bank", "^3Set To 0K^7", ::SetBankAccount, 0);
			foreach(bank in array(1,5,10,50,100,250))
					self add_option("account_mods_menu_bank", "^1-" + bank  + "K^7", ::SetBankAccount, (0 - bank));
			}
	//	}
	//self add_option("host_mods_menu", "Spawn One Boot Player", ::SpawnBootPlayer, 1);
}


AddToGiveWeaponMenu(sweapon_name, weapon_name)
{
	if ((self maps/mp/zombies/_zm_utility::is_equipment(weapon_name)) || (self maps/mp/zombies/_zm_utility::is_placeable_mine(weapon_name)) || (self maps/mp/zombies/_zm_equipment::is_limited_equipment(weapon_name)) && !issubstr(weapon_name, "staff_"))
	{ 
		self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		self.countmenuequip ++;
		if (self.countmenuequip >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "> Next Page", ::submenu, "weapons_menu_give_equip_" + (self.countmenuequip_p + 1));
			self add_menu("weapons_menu_give_equip_" + (self.countmenuequip_p + 1), "weapons_menu_give_equip_" + self.countmenuequip_p, "Access Level 1");
			self.countmenuequip_p ++;
			self.countmenuequip = 0;
		}
	}
	else if ((level.script == "zm_tomb") && (weapon_name == "equip_dieseldrone_zm"))
	{ 
		self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		self.countmenuequip ++;
		if (self.countmenuequip >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_give_equip_" + self.countmenuequip_p, "> Next Page", ::submenu, "weapons_menu_give_equip_" + (self.countmenuequip_p + 1));
			self add_menu("weapons_menu_give_equip_" + (self.countmenuequip_p + 1), "weapons_menu_give_equip_" + self.countmenuequip_p, "Access Level 1");
			self.countmenuequip_p ++;
			self.countmenuequip = 0;
		}
	}
	else if (self maps/mp/zombies/_zm_utility::is_melee_weapon(weapon_name) || issubstr(weapon_name, "one_inch_punch"))
	{ 
		self add_option("weapons_menu_give_melee_" + self.countmenumelee_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		self.countmenumelee ++;
		if (self.countmenumelee >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_give_melee_" + self.countmenumelee_p, "> Next Page", ::submenu, "weapons_menu_give_melee_" + (self.countmenumelee_p + 1));
			self add_menu("weapons_menu_give_melee_" + (self.countmenumelee_p + 1), "weapons_menu_give_melee_" + self.countmenumelee_p, "Access Level 1");
			self.countmenumelee_p ++;
			self.countmenumelee = 0;
		}
	}
	else if (self maps/mp/zombies/_zm_utility::is_lethal_grenade(weapon_name))
	{ 
		self add_option("weapons_menu_give_lethal_" + self.countmenulethal_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		self.countmenulethal ++;
		if (self.countmenulethal >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_give_lethal_" + self.countmenulethal_p, "> Next Page", ::submenu, "weapons_menu_give_lethal_" + (self.countmenulethal_p + 1));
			self add_menu("weapons_menu_give_lethal_" + (self.countmenulethal_p + 1), "weapons_menu_give_lethal_" + self.countmenulethal_p, "Access Level 1");
			self.countmenulethal_p ++;
			self.countmenulethal = 0;
		}
	}
	else if (self maps/mp/zombies/_zm_utility::is_tactical_grenade(weapon_name) || issubstr(weapon_name, "tomahawk_zm") || (weapon_name == "willy_pete_zm"))
	{ 
		self add_option("weapons_menu_give_tactical_" + self.countmenutactical_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		self.countmenutactical ++;
		if (self.countmenutactical >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_give_tactical_" + self.countmenutactical_p, "> Next Page", ::submenu, "weapons_menu_give_tactical_" + (self.countmenutactical_p + 1));
			self add_menu("weapons_menu_give_tactical_" + (self.countmenutactical_p + 1), "weapons_menu_give_tactical_" + self.countmenutactical_p, "Access Level 1");
			self.countmenutactical_p ++;
			self.countmenutactical = 0;
		}
	}
	//else if (self maps/mp/zombies/_zm_utility::is_offhand_weapon(weapon_name))
	//{ 		
		//self add_option("weapons_menu_give_offhand_" + self.countmenuoffhand_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		//self.countmenuoffhand ++;
		//if (self.countmenuoffhand >= level.menuweapmaxitemperpage)
		//{
			//self add_option("weapons_menu_give_offhand_" + self.countmenuoffhand_p, "> Next Page", ::submenu, "weapons_menu_give_offhand_" + (self.countmenuoffhand_p + 1));
			//self add_menu("weapons_menu_give_offhand_" + (self.countmenuoffhand_p + 1), "weapons_menu_give_offhand_" + self.countmenuoffhand_p, "Access Level 1");
			//self.countmenuoffhand_p ++;
			//self.countmenuoffhand = 0;
		//}
	//}
	else if (self maps/mp/zombies/_zm_weapons::is_weapon_or_base_included(weapon_name))
	{ 		
		self add_option("weapons_menu_give_weap_" + self.countmenuweap_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		self.countmenuweap ++;
		if (self.countmenuweap >= level.menuweapmaxitemperpage)
		{
			self add_option("weapons_menu_give_weap_" + self.countmenuweap_p, "> Next Page", ::submenu, "weapons_menu_give_weap_" + (self.countmenuweap_p + 1));
			self add_menu("weapons_menu_give_weap_" + (self.countmenuweap_p + 1), "weapons_menu_give_weap_" + self.countmenuweap_p, "Access Level 1");
			self.countmenuweap_p ++;
			self.countmenuweap = 0;
		}
	}
	//else
	//{ 
		//self add_option("weapons_menu_give_extra_" + self.countmenuextra_p, sweapon_name, ::GiveWeapon_NzV, weapon_name);
		//self.countmenuextra ++;
		//if (self.countmenuextra >= level.menuweapmaxitemperpage)
		//{
			//self add_option("weapons_menu_give_extra_" + self.countmenuextra_p, "> Next Page", ::submenu, "weapons_menu_give_extra_" + (self.countmenuextra_p + 1));
			//self add_menu("weapons_menu_give_extra_" + (self.countmenuextra_p + 1), "weapons_menu_give_extra_" + self.countmenuextra_p, "Access Level 1");
			//self.countmenuextra_p ++;
			//self.countmenuextra = 0;
		//}
	//}
}

















