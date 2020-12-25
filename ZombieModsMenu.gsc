Toggle_DisableZombiesSpawn()
{
	if(!isDefined(level.DisableZombiesSpawn))
		level.DisableZombiesSpawn = false;
	if(!level.DisableZombiesSpawn)
		flag_init("spawn_zombies", 1);
	else
		flag_init("spawn_zombies", 0);
	level.DisableZombiesSpawn = !level.DisableZombiesSpawn;
	self stealth_iprintln("Disable Zombies Spawn " + (level.DisableZombiesSpawn ? "^2ON" : "^1OFF"));
}

Toggle_FreezeZombies()
{
    if(getDvarint("g_ai") == 1)
       setDvar("g_ai", 0); 
    else
       setDvar("g_ai", 1); 
	self stealth_iprintln("Freeze Zombies " + ((getDvarint("g_ai") == 0) ? "^2ON" : "^1OFF"));
}


Toggle_HeadLessZombie()
{
	level notify("StopHeadLessZombie");
	if(!isDefined(level.HeadLessZombie))
		level.HeadLessZombie = false;
	if(!level.HeadLessZombie)
		level doHeadLessZombie();
	level.HeadLessZombie = !level.HeadLessZombie;
	self stealth_iprintln("HeadLess Zombie " + (level.HeadLessZombie ? "^2ON" : "^1OFF"));
}

doHeadLessZombie()
{
	level endon("StopHeadLessZombie");
	level endon("game_ended");  
    for(;;)
    {
	    z = getaispeciesarray("axis", "all");
	    for (i = 0; i < z.size; i++)
	        z[i] detachall();
	    wait 0.1;
	}        
}

Toggle_HideZombie()
{
	level notify("StopHideZombie");
	if(!isDefined(level.HideZombie))
		level.HideZombie = false;
	if(!level.HideZombie)
		level doHideZombie();
	else
	{
	    z = getaispeciesarray("axis", "all");
	    for (i = 0; i < z.size; i++)
	        z[i] show();
	}
	level.HideZombie = !level.HideZombie;
	self stealth_iprintln("Hide Zombie " + (level.HideZombie ? "^2ON" : "^1OFF"));
}


doHideZombie()
{
	level endon("StopHideZombie");
	level endon("game_ended");  
    for(;;)
    {
	    z = GetAiSpeciesArray("axis", "all");
	    for (i = 0; i < z.size; i++)
	        z[i] hide();
	    wait 0.1;
	}        
}


KillAllSwpanedZombies()
{
        zombs=getaiarray("axis");
        level.zombie_total=0;
        if(isDefined(zombs))
        {
                for(i=0;i<zombs.size;i++)
                {
                        zombs[i] dodamage(zombs[i].health * 5000,(0,0,0),self);
                        wait 0.05;
                }
               
        }

	self stealth_iprintln("^2All Swpaned Zombies Killed");
}


SumonAllZombies()
{
	z =getaiarray("axis");
	vec = anglesToForward(self getPlayerAngles());
	end = (vec[0] * 100000000, vec[1] * 100000000, vec[2] * 100000000);
	teleport_loc = BulletTrace(self geteye(), end, 0, self)["position"];
	for(i=0;i <z.size; i++)
	{
		z[i] forceTeleport(teleport_loc);
		z[i] maps\mp\zombies\_zm_spawner::reset_attack_spot();
	}
	self stealth_iprintln("^2All Zombies Teleported To Your Crosshair");
}

SpawnZombie()
{
    spawn_point = level.zombie_spawn_locations[randomint(level.zombie_spawn_locations.size)];
    spawner = random(level.zombie_spawners);
    self maps\mp\zombies\_zm_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
    self stealth_iprintln("Zombie ^2Spawned ");
}



SetZombieSpawnDelay(i) //0.08 Def
{
	set_zombie_var("zombie_spawn_delay", i);
	level.zombie_spawn_delay = i;
    level.zombie_vars["zombie_spawn_delay"] = i;
	self stealth_iprintln("Zombie Spawn Delay Set To  ^2" + i);
}
SetZombieLimit(i)
{
	set_zombie_var( "zombie_ai_limit", i);
	level.zombie_ai_limit = i;
	set_zombie_var( "zombie_actor_limit", (i + 8));
	level.zombie_actor_limit = (i + 8);
	set_zombie_var( "zombie_ai_per_player", int(i/level.players.size));
	level.zombie_ai_per_player = int(i/level.players.size);
}

SetZombieRunSpeed(i)
{
	self stealth_iprintln("Zombie Run Speed Set To  ^2" + i);
	set_zombie_var( "zombie_move_speed_multiplier", i);
	set_zombie_var( "zombie_move_speed_multiplier_easy", i);
	level.zombie_move_speed_multiplier = i ;
	level.zombie_move_speed_multiplier_easy = i ;
	level.zombie_move_speed_original = self.zombie_move_speed;
	level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier" ];
}








