
Toggle_ForceHost()
{
    if(getDvarint("partyMigrate_disabled") == 0)
    {
        setDvar("party_connectToOthers" ,"0");
        setDvar("partyMigrate_disabled" ,"1");
        setDvar("party_mergingEnabled" ,"0");
    }
    else
    {
        setDvar("party_connectToOthers" ,"1");
        setDvar("partyMigrate_disabled" ,"0");
        setDvar("party_mergingEnabled" ,"1");
    }
	self stealth_iprintln("Force Host " + ((getDvarint("partyMigrate_disabled") == 1) ? "^2ON" : "^1OFF"));
}

Toggle_AntiCheat()
{
    if(getDvarint("sv_cheats") == 0)
        setDvar("sv_cheats" , 1);
    else
        setDvar("sv_cheats" , 0);
	self stealth_iprintln("Anti Cheat " + ((getDvarint("sv_cheats") == 0) ? "^2ON" : "^1OFF"));
}

doRestartGame()
{
	self stealth_iprintln("Current Game ^1Restarted");
	wait 1;
	map_restart(false);
}

doEndGame()
{
	self stealth_iprintln("Current Game ^1Ended");
    level thread maps/mp/gametypes_zm/_globallogic::forceend();
}

Toggle_AntiQuit()
{
	level notify("StopAntiQuit");
	if(!isDefined(level.AntiQuit))
		level.AntiQuit = false;
	level.AntiQuit = !level.AntiQuit;
	if(level.AntiQuit)
	{
		for(m = 0; m < getPlayers().size; m++)
		{
			getPlayers()[m] notify("StopAntiQuit");
			if (!(getPlayers()[m] isHost()))
			 	getPlayers()[m] thread doAntiQuit();
			wait 0.1;
		}
	}
	self stealth_iprintln("Anti Quit " + (level.AntiQuit ? "^2ON" : "^1OFF"));
}

doAntiQuit()
{
	self notify("StopAntiQuit");
	level notify("StopAntiQuit");
	self endon("StopAntiQuit");
	level endon("StopAntiQuit");
    self endon("disconnect");
	level endon("game_ended");  
    while(isDefined(level.AntiQuit) && level.AntiQuit)
    {
		self closeInGameMenu();
		wait 0.1;
    }
}

SpawnBootPlayer(number)
{
	for(i = 0; i < number; i++)
	{
		self thread maps\mp\zombies\_zm::add_bots();
    	wait 1;
	}
	self stealth_iprintln(number + " Bot" + ((number > 1) ? "s" : "") + " ^2Spawned");
}





doHeart()
{
    if(!isDefined(level.SA))
    {
        level.iamtext = self.name;
        level.SA=level createServerFontString("hudbig",2.1);
        level.SA setPoint( "TOPLEFT","TOPLEFT",0,30 + 100 );
        level.SA setText( "IM A ZOMBIE" );
        level.SA.archived=false;
        level.SA.hideWhenInMenu=true;
        self stealth_iprintln("Do Heart^2ON");
        level.doheart=true;
        for(;;)
        {
            level.SA ChangeFontScaleOverTime( 0.4 );
            level.SA.fontScale = 2.0;
            level.SA FadeOverTime( 0.3 );
            level.SA.glowAlpha=1;
            level.SA.glowColor =((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
            level.SA SetPulseFX(40,2000,600);
            wait 0.4;
            level.SA ChangeFontScaleOverTime( 0.4 );
            level.SA.fontScale = 2.3;
            level.SA FadeOverTime( 0.3 );
            level.SA.glowAlpha=1;
            level.SA.glowColor =((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
            level.SA SetPulseFX(40,2000,600);
            wait 0.4;
        }
    }
    if(!isDefined(level.doheart))
    {
        self stealth_iprintln("Do Heart^2ON");
        level.doheart=true;
        level.SA.alpha=1;
    }
    else if(level.doheart==1)
    {
        self stealth_iprintln("Do Heart^1OFF");
        level.SA.alpha=0;
        level.doheart=undefined;
    }
}










