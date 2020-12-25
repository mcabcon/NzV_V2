

SetAllZombiesModel(model)
{
	level notify("StopAllZombiesModel");
	if(!isDefined(level.AllZombiesModel))
		level.AllZombiesModel = false;
	if(!level.AllZombiesModel)
		level doZombieModel(model);
	level.AllZombiesModel = !level.AllZombiesModel;
	self stealth_iprintln("Zombie Model Set To " + model);
}


doZombieModel(model)
{
	level endon("StopAllZombiesModel");
	level endon("game_ended");  
    for(;;)
    {
        Z = GetAiSpeciesArray("axis","all");
        for(i=0; i < Z.size; i++)
        {
                Z[i] setModel(model);
        }
        wait 0.1;
    }
}


doStunZombie()
{
	self notify( "stun_zombie" );
	self endon( "stun_zombie" );
	Z = GetAiSpeciesArray("axis","all");
    for(i = 0; i < Z.size; i++)
    {
        if (Z.health > 0)
		{
			if (isDefined(Z.stun_zombie))
				Z thread [[Z.stun_zombie]]();
			else
				Z thread maps/mp/zombies/_zm_ai_basic::start_inert();
		}
	}
}

doPauseZombieSpawning()
{
	if ( !isDefined( level.spawnpausecount ) )
	{
		level.spawnpausecount = 0;
	}
	level.spawnpausecount++;
	flag_clear("spawn_zombies");
}

doResumeZombieSpawning()
{
	if ( !isDefined( level.spawnpausecount ) )
	{
		level.spawnpausecount = 0;
	}
	level.spawnpausecount--;

	if ( level.spawnpausecount <= 0 )
	{
		level.spawnpausecount = 0;
		flag_set("spawn_zombies");
	}
}


SetBuildableNeedPower(buildable)
{

	level.equipment_turret_needs_power = 1;
	level.equipment_etrap_needs_power = 1;
	level.explode_overheated_jetgun = 1;
	level.unbuild_overheated_jetgun	= 0;
}


doSecret()
{	
	self stealth_iprintln("START");
	
	m_update_sidequest_stats("sq_transit_started");
	m_update_sidequest_stats("sq_transit_rich_stage_1");
	m_update_sidequest_stats("sq_transit_rich_stage_2");
	m_update_sidequest_stats("sq_transit_rich_stage_3");
	m_update_sidequest_stats("sq_transit_rich_complete");
	m_update_sidequest_stats("navcard_applied_zm_transit");
	
	m_update_sidequest_stats("sq_highrise_started");
	m_update_sidequest_stats("sq_highrise_rich_complete");
	m_update_sidequest_stats("navcard_applied_zm_highrise");
	
	m_update_sidequest_stats("sq_buried_started");
	m_update_sidequest_stats("sq_buried_rich_complete");
	m_update_sidequest_stats("navcard_applied_zm_buried");
	
	self stealth_iprintln("END");
}
		
m_update_sidequest_stats(stat_name)
{
	maxis_complete = 0;
	rich_complete = 0;
	started = 0;
	if ((stat_name == "sq_transit_maxis_complete") || (stat_name == "sq_highrise_maxis_complete") || (stat_name == "sq_buried_maxis_complete"))
		maxis_complete = 1;
	else if ((stat_name == "sq_transit_rich_complete") || (stat_name == "sq_highrise_rich_complete") || (stat_name == "sq_buried_rich_complete"))
		rich_complete = 1;
	for(m = 0; m < getPlayers().size; m++)
	{
		player = getPlayers()[m];
		if ((stat_name == "sq_transit_started") || (stat_name == "sq_highrise_started") || (stat_name == "sq_buried_started"))
		{
			player maps/mp/zombies/_zm_stats::set_global_stat(stat_name, 1);
			player.f_sq_started = 1;
			player.transit_sq_started = 1;
			player.buried_sq_started = 1;
			player.highrise_sq_started = 1;
		}
		else if ((stat_name == "navcard_applied_zm_transit") || (stat_name == "navcard_applied_zm_highrise") || (stat_name == "navcard_applied_zm_buried"))
		{
			player maps/mp/zombies/_zm_stats::set_global_stat(stat_name, 1);
			if (stat_name == "navcard_applied_zm_transit")
				player maps/mp/zombies/_zm_stats::set_global_stat("navcard_held_zm_buried", 0 );
			if (stat_name == "navcard_applied_zm_highrise")
				player maps/mp/zombies/_zm_stats::set_global_stat("navcard_held_zm_transit", 0 );
			if (stat_name == "navcard_applied_zm_buried")
				player maps/mp/zombies/_zm_stats::set_global_stat("navcard_held_zm_highrise", 0 );
		}
		if (isDefined(player.f_sq_started) && player.f_sq_started)
		{
			if (rich_complete)
			{
				if (stat_name == "sq_transit_rich_complete") 
				{
					player maps/mp/zombies/_zm_stats::set_global_stat( "sq_transit_last_completed", 1 );
					incrementcounter( "global_zm_total_rich_sq_complete_transit", 1 );
				}
				else if (stat_name == "sq_highrise_rich_complete")
				{
					player maps/mp/zombies/_zm_stats::set_global_stat( "sq_highrise_last_completed", 1 );
					incrementcounter( "global_zm_total_rich_sq_complete_highrise", 1 );
				}
				else if (stat_name == "sq_buried_rich_complete")
				{
					player maps/mp/zombies/_zm_stats::set_global_stat( "sq_buried_last_completed", 1 );
					incrementcounter( "global_zm_total_rich_sq_complete_buried", 1 );
				}
			}
			else if (maxis_complete)
			{
				if (stat_name == "sq_transit_maxis_complete")
				{
					player maps/mp/zombies/_zm_stats::set_global_stat( "sq_transit_last_completed", 2 );
					incrementcounter( "global_zm_total_max_sq_complete_transit", 1 );
				}
				else if (stat_name == "sq_highrise_maxis_complete")
				{
					player maps/mp/zombies/_zm_stats::set_global_stat( "sq_highrise_last_completed", 2 );
					incrementcounter( "global_zm_total_rich_sq_complete_highrise", 1 );
				}
				else if (stat_name == "sq_buried_maxis_complete")
				{
					player maps/mp/zombies/_zm_stats::set_global_stat( "sq_buried_last_completed", 2 );
					incrementcounter( "global_zm_total_rich_sq_complete_buried", 1 );
				}
			}
			player maps/mp/zombies/_zm_stats::increment_client_stat(stat_name, 0);
		}
	}
	//if (rich_complete || maxis_complete)
	//{
	//	if ((stat_name == "sq_transit_rich_complete") || (stat_name == "sq_transit_maxis_complete"))
	//		level notify( "transit_sidequest_achieved" );
	//	if ((stat_name == "sq_highrise_rich_complete") || (stat_name == "sq_highrise_maxis_complete"))
	//		level notify( "highrise_sidequest_achieved");
	//	if ((stat_name == "sq_buried_rich_complete") || (stat_name == "sq_buried_maxis_complete"))
	//		level notify( "buried_sidequest_achieved" );
	//}
}


















