//----------------------------------------
//Give/Take Perk
//----------------------------------------

Toggle_PlayerPerk(perk) 
{
	if (!(self hasperk(perk) || self maps/mp/zombies/_zm_perks::has_perk_paused(perk)))
	{
		self doGivePerk(perk);
		self stealth_iprintln("Perk [" + perk + "] ^2Gived");
	}
	else
	{
		self notify(perk + "_stop");
		self stealth_iprintln("Perk [" + perk + "] ^1Removed");
	}
}

doGivePerk(perk) 
{
    self endon("disconnect");
	self endon("death");
	level endon("game_ended"); 
	self endon("perk_abort_drinking");
	if (!(self hasperk(perk) || (self maps/mp/zombies/_zm_perks::has_perk_paused(perk))))
	{
		gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin(perk);
		evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
		if (evt == "weapon_change_complete")
			self thread maps/mp/zombies/_zm_perks::wait_give_perk(perk, 1);
		self maps/mp/zombies/_zm_perks::perk_give_bottle_end(gun, perk);
		if (self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission)
			return;
		self notify("burp");
	}
}

//----------------------------------------
//PerkPower
//----------------------------------------

Toggle_PerkPower(perk)
{
	if(!isDefined(level.PerkPower))
		level.PerkPower = [];
	if(!isDefined(level.PerkPower[perk]))
		level.PerkPower[perk] = true;
	level.PerkPower[perk] = !level.PerkPower[perk];
	if(level.PerkPower[perk])
		level maps/mp/zombies/_zm_perks::perk_unpause(perk);
	else	
		level maps/mp/zombies/_zm_perks::perk_pause(perk);
	self stealth_iprintln("Perk [" + perk + "] Power " + (level.PerkPower[perk] ? "^2ON" : "^1OFF"));
}

//----------------------------------------
//GiveAllPerk
//----------------------------------------

GiveAllPerks()
{
	if (isDefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
	 	self doGivePerk("specialty_armorvest");
	if (isDefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	  self doGivePerk("specialty_fastreload");
	if (isDefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	   self doGivePerk("specialty_quickrevive");
	if (isDefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk)  
	   self doGivePerk("specialty_rof");
	if (isDefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	    self doGivePerk("specialty_longersprint");
	if(isDefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
		self doGivePerk("specialty_additionalprimaryweapon");
	if (isDefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	    self doGivePerk("specialty_deadshot");
	if (isDefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
		self doGivePerk("specialty_scavenger");
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_flakjacket"]) && (level.script != "zm_buried"))
		self doGivePerk("specialty_flakjacket"); 
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_nomotionsensor"]))
		self doGivePerk("specialty_nomotionsensor"); 
	if (isDefined(level._custom_perks) && isDefined(level._custom_perks["specialty_grenadepulldeath"]))
		self doGivePerk("specialty_grenadepulldeath"); 
	if (isDefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
		self doGivePerk("specialty_finalstand");
	self stealth_iprintln("All Perks ^2Gived");
}

//----------------------------------------
//RemoveAllPerk
//----------------------------------------

RemoveAllPerks()
{
	self notify("specialty_armorvest_stop");
	self notify("specialty_fastreload_stop");
	self notify("specialty_quickrevive_stop");
	self notify("specialty_rof_stop");
	self notify("specialty_longersprint_stop");
	self notify("specialty_additionalprimaryweapon_stop");
	self notify("specialty_deadshot_stop");
	self notify("specialty_scavenger_stop");
	self notify("specialty_flakjacket_stop");
	self notify("specialty_nomotionsensor_stop");
	self notify("specialty_grenadepulldeath_stop");
	self notify("specialty_finalstand_stop");
	self stealth_iprintln("All Perks ^1Removed");
}

//----------------------------------------
//PermaPerks
//----------------------------------------

GivePermaPerk_NzV(name)
{
	for (i = 0; i < level.pers_upgrades[name].stat_names.size; i++)
	{
		stat_name = level.pers_upgrades[name].stat_names[i];
		self maps/mp/zombies/_zm_stats::set_global_stat(level.pers_upgrades[name].stat_names[i], level.pers_upgrades[name].stat_desired_values[i]);
		self.stats_this_frame[stat_name] = true;
		wait 0.1;
	}
	self stealth_iprintln("Perma Perk [" + name + "] ^2Gived");
}






































