
//functions
killPlayer(player)
{
	if(!isDefined(player))
	{
        self stealth_iprintln("^1ERROR: ^7Unknow Player!");
	}
    else if(verificationToNum(self.AccessLevel) >= verificationToNum(player.AccessLevel))
    {
	
        if(!player isHost())
        {
            if(isAlive(player))
            {
                self stealth_iprintln(getPlayerName(player) + " ^1Was Killed!");
                player suicide();
            }
            else
                self stealth_iprintln(getPlayerName(player) + " Is Already Dead!");
        }
        else
            self stealth_iprintln("You Cannot Kill The Host!");
    }
    else
        self stealth_iprintln("^1ERROR: ^7He Has " + player.AccessLevel + ". You Cannot Kill Him!");
}

kickPlayer(player)
{
	if(!isDefined(player))
	{
        self stealth_iprintln("^1ERROR: ^7Unknow Player!");
	}
    else if(verificationToNum(self.AccessLevel) >= verificationToNum(player.AccessLevel))
    {
        if (player isHost())
            self stealth_iprintln("^1ERROR: ^7You Cannot Kick The Host!");
        else
        {
            kick(player GetEntityNumber());
            wait 0.50;
            self submenu(self.menu.previousmenu[self.menu.currentmenu]);
        }
    }
    else
        self stealth_iprintln("^1ERROR: ^7He Has " + verificationToColor(player.AccessLevel) + ". You Cannot Kick Him!");
}

banPlayer(player)
{
	if(!isDefined(player))
	{
        self stealth_iprintln("^1ERROR: ^7Unknow Player!");
	}
	else if(verificationToNum(self.AccessLevel) >= verificationToNum(player.AccessLevel))
    {
        if (player isHost())
            self stealth_iprintln("^1ERROR: ^7You Cannot Ban The Host!");
        else
        {
            ban(player getentitynumber());
            kick(player GetEntityNumber());
            wait 0.50;
            self submenu(self.menu.previousmenu[self.menu.currentmenu]);
        }
    }
    else
        self stealth_iprintln("^1ERROR: ^7He Has " + verificationToColor(player.AccessLevel) + ". You Cannot Ban Him!");
}

TakeControlOfMenu(player)
{
	if(!isDefined(player))
	{
        self stealth_iprintln("^1ERROR: ^7Unknow Player!");
	}
	else if(verificationToNum(self.AccessLevel) >= verificationToNum(player.AccessLevel))
    {
        if (player isHost()  && !(player == self))
            self stealth_iprintln("^1ERROR: ^7You Cannot Control Menu Of The Host!");
        else
        {
        	if (isDefined(self.CtrlPlayer) && player == self)
        	{
        		self.CtrlPlayer.CtrlByPlayer = undefined;
        		self.CtrlPlayer = undefined;
        	}
        	else if (player != self)
        	{
        		if (isDefined(player.CtrlByPlayer))
        		{
        			player.CtrlByPlayer stealth_iprintln("^1No More Control Menu Of Player ^7" + getPlayerName(player));
        			player.CtrlByPlayer stealth_iprintln("^1Its Now ^7" + getPlayerName(self) + " ^1Who Have It");
        			player.CtrlByPlayer TakeControlOfMenu(player.CtrlByPlayer);
        		}
        		self.CtrlPlayer = player;
        		player.CtrlByPlayer = self;
        		if(verificationToNum(player.AccessLevel) >= verificationToNum(self.AccessLevel))
        			player stealth_iprintln(getPlayerName(self) + " ^1Can Now Control Your Menu");
        		self stealth_iprintln("^2Now You Control Menu Of ^7" + getPlayerName(self));
        	}
		    else
		        self stealth_iprintln("^1ERROR: ^7You Control Menu Of No One!");

        }
    }
    else
        self stealth_iprintln("^1ERROR: ^7He Has " + verificationToColor(player.AccessLevel) + ". You Cannot Control His Menu!");
}
teleportyoutoPlayer(player)
{
	if(!isDefined(player) ||self ==player || !isAlive(player))
		{
        self stealth_iprintln("^1ERROR: ^7Unknow Player or you try teleport yourself to yourself");
		}    
    else
    	{
            self setOrigin(player);
			self stealth_iprintln("You Teleported To ^2"+player.name);
        }

}
teleportPlayerToYou(player)
{
	if(!isDefined(player) || self ==player || !isAlive(player))
		{
        self stealth_iprintln("^1ERROR: ^7Unknow Player or you try teleport yourself to yourself");
		}       
    else
    	{
            player setOrigin(self);
			self stealth_iprintln("^2"+player.name+"^7 Teleported To you");
        }

}
AddScore_player(score,player)
{
	if(!isDefined(player))
	{
	 self stealth_iprintln("^1ERROR: ^7Unknow Player");
	}
	else
	{
    	if(!isDefined(score))
	   		score = (0 - player.score);
    	else if ( 0 > (player.score + score))
	    	score = (0 - player.score);
		player.score += score;
    	if (player.score > player.max_score)
    		player.max_score = player.score; 
 	self stealth_iprintln(player.name+" Score Set To ^2" + player.score);
 	}
}
Toggle_GodMod_NzV_player(player)
{
if(!isDefined(player) || !isAlive(player))
	{
		 self stealth_iprintln("^1ERROR: ^7Something went wrong !");
	}
	else
	{
		player Toggle_GodMod_NzV();
		if(!self ==player)
		self stealth_iprintln(player.name + " GodMod " + player.GodMod_NzV ? "^2ON" : "^1OFF");
	}
}
Toggle_Ammo_NzV_player(player)
{
if(!isDefined(player))
	{
		 self stealth_iprintln("^1ERROR: ^7Something went wrong !");
	}
	else
	{
		player Toggle_Ammo_NzV();
		if(!self ==player)
		self stealth_iprintln(player.name + " Unlimited Ammo " + player.UnlimitedAmmo ? "^2ON" : "^1OFF");
	}
}
Toggle_SkullProtector_player(player)
{
if(!isDefined(player) || !isAlive(player))
	{
		 self stealth_iprintln("^1ERROR: ^7Something went wrong !");
	}
	else
	{
		player Toggle_SkullProtector();
		if(!self ==player)
		self stealth_iprintln(player.name + " Skull Protector " + player.SkullProtector ? "^2ON" : "^1OFF");
	}
}
SendEarthQuake_player(player)
{
if(!isDefined(player) || !isAlive(player))
	{
		 self stealth_iprintln("^1ERROR: ^7Something went wrong !");
	}
	else
	{
		earthquake(0.6, 10, player.origin, 100000);
		player SendEarthQuake();
		if(!self ==player)
			self stealth_iprintln(player.name + " Skull Protector " + player.SkullProtector ? "^2ON" : "^1OFF");
	}
}
