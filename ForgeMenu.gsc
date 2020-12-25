Toggle_ForgeMode()
{
	self notify("StopForgeMode");
	if(isDefined(self.AdvancedForgeMode) && self.AdvancedForgeMode)
		Toggle_AdvancedForgeMode();
	if(!isDefined(self.ForgeMode))
		self.ForgeMode = false;
	self.ForgeMode = !self.ForgeMode;
	if(self.ForgeMode)
		self thread doForgeMode();
	else
        self.CurrentForgeEntity = undefined;
	self stealth_iprintln("Forge Mode " + (self.ForgeMode ? "^2ON" : "^1OFF"));
}

doForgeMode()
{
	self notify("StopForgeMode");
	self endon("StopForgeMode");
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
    self stealth_iprintln("Press ^2[{+speed_throw}]^7 To Pick Up/Drop Objects");
	while(isDefined(self.ForgeMode) && self.ForgeMode)
	{
		while(self AdsButtonPressed())
		{
			trace = bulletTrace(self GetTagOrigin("j_head"), self GetTagOrigin("j_head") + anglesToForward(self GetPlayerAngles()) * 1000000, true, self);
			while(self adsbuttonpressed())
			{
				trace["entity"] ForceTeleport(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
				trace["entity"] setOrigin(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
				trace["entity"].origin = self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200;
				wait 0.05;
			}
		}
		wait 0.05;
	}
}

Toggle_AdvancedForgeMode()
{
	self notify("StopAdvancedForgeMode");
    self notify("StopAdvancedForgeMode_Move");
	if(isDefined(self.ForgeMode) && self.ForgeMode)
		Toggle_ForgeMode();
	if(!isDefined(self.AdvancedForgeMode))
		self.AdvancedForgeMode = false;
	self.AdvancedForgeMode = !self.AdvancedForgeMode;
	if(self.AdvancedForgeMode)
		self thread doAdvancedForgeMode_NzV();
	else
        self.CurrentForgeEntity = undefined;
	self stealth_iprintln("Advanced Forge Mode " + (self.AdvancedForgeMode ? "^2ON" : "^1OFF"));
}

doAdvancedForgeMode_NzV()
{   
    self notify("StopAdvancedForgeMode");
    self notify("StopAdvancedForgeMode_Move");
    self endon("StopAdvancedForgeMode");
    self endon("disconnect");
    self endon("death");
	level endon("game_ended");
    self stealth_iprintln("Press ^2[{+speed_throw}]^7 To Pick Up/Drop Entity");
	self stealth_iprintln("^2Use menu ^7to do more");
	while(isDefined(self.AdvancedForgeMode) && self.AdvancedForgeMode)
    {
        if(self adsbuttonpressed())
        {
    		self notify("StopAdvancedForgeMode_Move");
            if(isdefined(self.CurrentForgeEntity))
            {
	            if(isdefined(self.CurrentForgeEntity.SpEffect))
	            {
	                if(self.CurrentForgeEntity.SpEffect == "Flipping")
						self.CurrentForgeEntity thread doFlippingEntity();
					else if(self.CurrentForgeEntity.SpEffect == "Rolling")
						self.CurrentForgeEntity thread doRollingEntity();
					else if(self.CurrentForgeEntity.SpEffect == "Spinning")
						self.CurrentForgeEntity thread doSpinningEntity();
					else if(self.CurrentForgeEntity.SpEffect == "IceSkater")
						self.CurrentForgeEntity thread doIceSkaterEntity();
					else if(self.CurrentForgeEntity.SpEffect == "Trap")
						self.CurrentForgeEntity thread doTrapEntity();
            	}
                self.CurrentForgeEntity = undefined;
                self stealth_iprintln("Entity ^1released");
            }
            else
            {
                self.CurrentForgeEntity = self NormalisedTrace("entity");
				if(isdefined(self.CurrentForgeEntity))
            	{
					if(isdefined(self.CurrentForgeEntity.IsForgeEntity) && self.CurrentForgeEntity.IsForgeEntity)
	            	{
	            		self thread doMoveEntity();
	                	self stealth_iprintln("Entity ^2picked up");
	            	}
	            	else
	            	{
                		self.CurrentForgeEntity = undefined;
                		self stealth_iprintln("^1You can only pickup user spawned entity");
	            	}
            	}
            }
        }
        wait 0.3;
 	}
}

SetEntityEffect_NzV(Effect)
{
    if(!isDefined(self.AdvancedForgeMode) || !self.AdvancedForgeMode)
	{
		self stealth_iprintln("^1You need to enable ^2Advanced Forge Mode ^1first");
	}
    else if(!isDefined(self.CurrentForgeEntity))
	{
		self stealth_iprintln("^1You need to pickup an entity first^7, use [{+speed_throw}] to do it");
	}
	else
	{
    	if(isDefined(Effect)) 
    	{
    		self.CurrentForgeEntity.SpEffect = Effect;
    		self stealth_iprintln("Entity Effect Set To ^2" + Effect);
		}
		else
    	{
    		self.CurrentForgeEntity.SpEffect = "None";
    		self stealth_iprintln("Entity Effect Set To ^2None");
		}
	}
}

DeleteEntity_NzV()
{
    if(!isDefined(self.AdvancedForgeMode) || !self.AdvancedForgeMode)
	{
		self stealth_iprintln("^1You need to enable ^2Advanced Forge Mode ^1first");
	}
    else if(!isDefined(self.CurrentForgeEntity))
	{
		self stealth_iprintln("^1You need to pickup an entity first^7, use [{+speed_throw}] to do it");
	}
	else
	{
	    self notify("StopAdvancedForgeMode_Move");
	    self.CurrentForgeEntity notify("StopAnimEntity");
    	self.CurrentForgeEntity delete();
    	self.CurrentForgeEntity = undefined;
    	self stealth_iprintln("Entity ^2deleted");
	}
}

DeleteAllEntity_NzV()
{
    if(isDefined(self.ForgeEntity))
	{
		for (i = 0; i < 100; i++)
		{
	  		if(isdefined(self.ForgeEntity[i]))
		    {
	    		self.ForgeEntity[i] notify("StopAnimEntity");
		        self.ForgeEntity[i] delete();
		        self.ForgeEntity[i] = undefined;
		    }
		}
	}
    self stealth_iprintln("All entity ^2deleted");
}

SpawnEntity_NzV(Entity)
{
    if(!isDefined(self.AdvancedForgeMode) || !self.AdvancedForgeMode)
	{
		self stealth_iprintln("^1You need to enable ^2Advanced Forge Mode ^1first");
	}
	else
	{
		if(isDefined(self.CurrentForgeEntity))
	    	self.CurrentForgeEntity delete();
	    self notify("StopAdvancedForgeMode_Move");
	    self.CurrentForgeEntity = undefined;
	    if(!isdefined(self.ForgeEntity))
	    	self.ForgeEntity = [];
	    if(!isdefined(self.CountForgeEntity))
	        self.CountForgeEntity = 0;
	    if(self.CountForgeEntity >= 99)
	        self.CountForgeEntity = 0;
	    if(isdefined(self.ForgeEntity[self.CountForgeEntity]))
	    {
	    	self.ForgeEntity[self.CountForgeEntity] notify("StopAnimEntity");
	        self.ForgeEntity[self.CountForgeEntity] delete();
	        self.ForgeEntity[self.CountForgeEntity] = undefined;
	    }
		self.ForgeEntity[self.CountForgeEntity] = spawn("script_model", self NormalisedTrace("position"));
		self.CurrentForgeEntity = self.ForgeEntity[self.CountForgeEntity];
	    self.CountForgeEntity++;
	    self.CurrentForgeEntity.SpEffect = "None";
	    self.CurrentForgeEntity.IsForgeEntity = true;
		self.CurrentForgeEntity setmodel(Entity);
		self thread doMoveEntity();
		self stealth_iprintln("Entity (" + Entity + ") ^2Spawned");
	}
}

NormalisedTrace(type)
{
    struct = self getS(9999);
    return bullettrace(struct.start, struct.end, false, undefined)[type];
}

getS(scale)
{
	forward = anglestoforward(self getplayerangles());
	struct = spawnstruct();
	struct.start = self geteye();
	struct.end = struct.start + vectorScale(forward, scale);
	return struct;
}

doMoveEntity()
{
    self notify("StopAdvancedForgeMode_Move");
    self endon("StopAdvancedForgeMode_Move");
    self endon("StopAdvancedForgeMode");
    self endon("disconnect");
    self endon("death");
	level endon("game_ended");
	if(isdefined(self.CurrentForgeEntity))
	{
    	self.CurrentForgeEntity notify("StopAnimEntity");
		while(isdefined(self.CurrentForgeEntity) && isDefined(self.AdvancedForgeMode) && self.AdvancedForgeMode)
		{
			org = self getS(100).end;
			self.CurrentForgeEntity ForceTeleport(org);
			self.CurrentForgeEntity setOrigin(org);
			self.CurrentForgeEntity.origin = org;
			self.CurrentForgeEntity.angles = (0, self.angles[1], self.angles[2]);
			wait 0.1;
		}
	}
}

doFlippingEntity()
{
    self notify("StopAnimEntity");
    self endon("StopAnimEntity");
    self.SpEffect = "Flipping";
	while(isdefined(self))
	{
		self rotateroll(-360, 1);
		self waittill("rotatedone");
	}
}

doRollingEntity()
{
    self notify("StopAnimEntity");
    self endon("StopAnimEntity");
    self.SpEffect = "Rolling";
	while(isdefined(self))
	{
		self rotatepitch(-360, 1);
		self waittill("rotatedone");
	}
}

doSpinningEntity()
{
    self notify("StopAnimEntity");
    self endon("StopAnimEntity");
    self.SpEffect = "Spinning";
	while(isdefined(self))
	{
		self rotateyaw(-360, 1);
		self waittill("rotatedone");
	}
}

doIceSkaterEntity()
{
    self notify("StopAnimEntity");
    self endon("StopAnimEntity");
    self.SpEffect = "IceSkater";
	while(isdefined(self))
	{
		self RotateYaw(3240, 9);
		self MoveY(-180, 1);
		wait 1;
		self MoveY(180, 1);
		wait 1;
		self MoveX(-180, 1);
		wait 1;
		self MoveX(180, 1);
		wait 1;
		self MoveZ(90, .5);
		wait .5;
		self MoveZ(-90, .5);
		wait .5;
		self MoveY(180, 1);
		wait 1;
		self MoveY(-180, 1);
		wait 1;
		self MoveX(180, 1);
		wait 1;
		self MoveX(-180, 1);
		wait 1;
	}
}

doTrapEntity() 
{ 
    self notify("StopAnimEntity");
    self endon("StopAnimEntity");
    self.SpEffect = "Trap";
	while(isdefined(self))
    { 
	    self RotateYaw(720, 2);
    	self MoveZ(120, 1);
	    wait 1.1;
	    self MoveZ(-120, 1);
	    wait 1.1;
		if (isDefined(level._effect["def_explosion"]))
	   		playfx(level._effect["def_explosion"], self.origin);
	    self playSound("evt_nuked");
	    earthquake(1, .4, self.origin, 512);
	    zombies = GetAiSpeciesArray("axis", "all");
	    for (i = 0; i < zombies.size; i++)
		{
		    if(distance(zombies[i].origin, self.origin ) < 200) 
		    {
		    	zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
				if (isDefined(level._effect["zombie_guts_explosion"]))
			    	playfx(level._effect["zombie_guts_explosion"], zombies[i].origin);
			    zombies[i] playSound("fly_riotshield_zm_impact_flesh");
	    		wait 0.1;
		    }
		}
	    wait 0.1;
    } 
 }

























