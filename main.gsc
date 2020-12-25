/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : Vizion
*	 Project : SharkBase
*    Mode : Zombies
*	 Date : 2015/05/19 - 15:26:00	
*


 ______       ________        _______       ______       ______       ___   __      
/_____/\     /_______/\     /_______/\     /_____/\     /_____/\     /__/\ /__/\    
\:::__\/     \::: _  \ \    \::: _  \ \    \:::__\/     \:::_ \ \    \::\_\\  \ \   
 \:\ \  __    \::(_)  \ \    \::(_)  \/_    \:\ \  __    \:\ \ \ \    \:. `-\  \ \  
  \:\ \/_/\    \:: __  \ \    \::  _  \ \    \:\ \/_/\    \:\ \ \ \    \:. _    \ \ 
   \:\_\ \ \    \:.\ \  \ \    \::(_)  \ \    \:\_\ \ \    \:\_\ \ \    \. \`-\  \ \
    \_____\/     \__\/\__\/     \_______\/     \_____\/     \_____\/     \__\/ \__\/
    
 _______ .__   __.   ______   ______   .______       _______ 
|   ____||  \ |  |  /      | /  __  \  |   _  \     |   ____|
|  |__   |   \|  | |  ,----'|  |  |  | |  |_)  |    |  |__   
|   __|  |  . `  | |  |     |  |  |  | |      /     |   __|  
|  |____ |  |\   | |  `----.|  `--'  | |  |\  \----.|  |____ 
|_______||__| \__|  \______| \______/  | _| `._____||_______|
                                                     
 */	           
//---------------------------------------------
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_hud_message;
//---------------------------------------------
#include maps/mp/gametypes_zm/_globallogic;
#include maps/mp/gametypes_zm/_weapons;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_perks;
//---------------------------------------------	

//---------------------------------------------	
//maps/mp/_serverfaceanim_mp.gsc
//---------------------------------------------	


/*

7.1 
- Add Round Menu
- Ufo and Jetpack now faster ! 
- Small bugs fixed and chnages at all 
- added some new functions
- Forge mode revised
*/

getVersion()
{
return "^1Version 0.95 | Beta V2";
}
init_serverfaceanim()
{
	self.do_face_anims = 1;
	if (!isDefined(level.face_event_handler))
	{
		level.face_event_handler = spawnstruct();
		level.face_event_handler.events = [];
		level.face_event_handler.events["death"] = "face_death";
		level.face_event_handler.events["grenade danger"] = "face_alert";
		level.face_event_handler.events["bulletwhizby"] = "face_alert";
		level.face_event_handler.events["projectile_impact"] = "face_alert";
		level.face_event_handler.events["explode"] = "face_alert";
		level.face_event_handler.events["alert"] = "face_alert";
		level.face_event_handler.events["shoot"] = "face_shoot_single";
		level.face_event_handler.events["melee"] = "face_melee";
		level.face_event_handler.events["damage"] = "face_pain";
		level thread wait_for_face_event();
	}
}

wait_for_face_event()
{
	while (1)
	{
		level waittill("face", face_notify, ent);
		if (isDefined(ent) && isDefined(ent.do_face_anims) && ent.do_face_anims)
		{
			if (isDefined(level.face_event_handler.events[face_notify]))
				ent sendfaceevent(level.face_event_handler.events[face_notify]);
		}
	}
}

//---------------------------------------------	

init()
{
	//Auto DisableStudio
	setdvar("demo_enabled", "0");
	setdvar("demo_recordPrivateMatch", "0");
	//Auto ForceHost
	setdvar("party_connectToOthers", "0");
    setdvar("partyMigrate_disabled", "1");
    setdvar("party_mergingEnabled", "0");
    //Additionnal Models
   	precacheModel("defaultactor");
	precacheModel("defaultvehicle");
	//init FX 
	
	
	level.SavedAccessLevel = [];
    level thread onplayerconnect();
    if (isDefined(level.player_out_of_playable_area_monitor) && level.player_out_of_playable_area_monitor)
        	self notify("stop_player_out_of_playable_area_monitor");
}

				
onplayerconnect()
{
    level endon("game_ended");
    for(;;)
    {
        level waittill( "connecting", player );
		
        if(player isHost() || player islocaltohost())
        {
            player.AccessLevel = "Access Level 5";
            level.SavedAccessLevel[getPlayerName(player)] = player.AccessLevel;
        }
        else if (isDefined(level.SavedAccessLevel[getPlayerName(player)]))
        {
            player.AccessLevel = level.SavedAccessLevel[getPlayerName(player)];
            level.SavedAccessLevel[getPlayerName(player)] = player.AccessLevel;
        }
        else
        {
            player.AccessLevel = "No Access";
            level.SavedAccessLevel[getPlayerName(player)] = player.AccessLevel;
        }
        
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon("disconnect");
    level endon("game_ended");
    
    self.MenuInit = false;
    self.menu.stealth = true;
    //self.stealth_iprintln = true;
    self.firstWelcome = true;
   // self thread maps\mp\zombies\_zm::add_bots(); add bots null
    for(;;)
    {
        self waittill("spawned_player");
		self thread init_serverfaceanim(); //maps/mp/_serverfaceanim_mp.gsc
		if(self isAllowed(1))
           		self thread welcomeMessage();
        if (!self.MenuInit)
        {
            self.MenuInit = true;
            self thread MenuInit();
            self thread closeMenuOnDeath();
            thread initOverFlowFix();
        }

    }
}

welcomeMessage()
{
    self endon("disconnect");
    level endon("game_ended");
    self endon("death");
    if(self.firstWelcome)
    {
    	wait 1;
        welcome = spawnstruct();
        welcome2 = spawnstruct();
        welcome3 = spawnstruct();
    
        welcome clear(self);
        welcome2 clear(self);
        welcome3 clear(self);
    
        welcome = self createText("objective", 2, "CENTER", "BOTTOM", -250, -60, 3, (1, 1, 1), 1, (.3, 0, 0), 1, "Welcome " + self.name + " To Menu");
        welcome2 = self createText("objective", 2, "CENTER", "BOTTOM", -250, -30, 3, (1, 1, 1), 1, (.3, 0, 0), 1, "I AM ZOMBIE v2 By NzV and CabCon");
        welcome3 = self createText("objective", 2, "CENTER", "BOTTOM", -250, 0, 3, (1, 1, 1), 1, (.3, 0, 0), 1, "You Have " + self.AccessLevel);
        welcome.hideWhenInMenu = true;
        welcome2.hideWhenInMenu = true;
        welcome3.hideWhenInMenu = true;
    
        if(!self.menu.stealth)
        {
            welcome.archived = true;
            welcome2.archived = true;
            welcome3.archived = true;
        }
        else
        {
            welcome.archived = false;
            welcome2.archived = false;
            welcome3.archived = false;
        }
    
        welcome setCOD7DecodeFX( 100, int(10*1000), 600 );
        welcome2 setCOD7DecodeFX( 100, int(10*1000), 600 );
        welcome3 setCOD7DecodeFX( 100, int(10*1000), 600 );
    
        welcome setPulseFX( 100, int(10*1000), 1000 );
        welcome2 setPulseFX( 100, int(10*1000), 1000 );
        welcome3 setPulseFX( 100, int(10*1000), 1000 );
    
        wait 5.5;//TODO: you set 4.3 i do 5.5
    
        welcome elemFade(.3, 0);
        welcome2 elemFadeWait(.3, 0);
        welcome3 elemFadeWait(.3, 0);
    
        welcome clear(self);
        welcome2 clear(self);
        welcome3 clear(self);
        self setClientUiVisibilityFlag("hud_visible", 1);
        self.firstWelcome = false;
    }
    else
    {
        notifyData = spawnstruct();
        notifyData.titleText = "Welcome " + self.name + " To Menu I AM ZOMBIE v2 By NzV and CabCon";
        notifyData.notifyText = "You Have " + self.AccessLevel;
        notifyData.glowColor = (.2, 0, 0);
        notifyData.duration = 7;
        notifyData.font = "objective";
        notifyData.hideWhenInMenu = true;
    
        if(!self.menu.stealth)
            notifyData.archived = true;
        else
            notifyData.archived = false;
            
        self thread maps\mp\gametypes_zm\_hud_message::notifyMessage(notifyData);
    }
}


//monitoring
MenuInit()
{
    self endon("disconnect");
    self endon("destroyMenu");
    level endon("game_ended");
    
    self.menu = spawnstruct();
   
    self.menu.open = false;
   
    self StoreShaders();
    self CreateMenu();
    
    while(1)
    {  
        if(!self.menu.open && self isAllowed(1) && self MeleeButtonPressed() && self adsbuttonpressed())
                openMenu();
        if(self.menu.open)
        {
            if(self actionSlotThreeButtonPressed())
            {
                if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
                    self submenu(self.menu.previousmenu[self.menu.currentmenu]);
                else
                    closeMenu();
                self playLocalSound("fly_lsat_close");
                wait 0.2;
            }
            else if(self actionslotonebuttonpressed() || self actionslottwobuttonpressed())
            {   
                self.menu.curs[self.menu.currentmenu] += (self actionSlotTwoButtonPressed() ?  1 : -1);
                self.menu.curs[self.menu.currentmenu] = (self.menu.curs[self.menu.currentmenu] < 0) ? self.menu.menuopt[self.menu.currentmenu].size-1 : ((self.menu.curs[self.menu.currentmenu] > (self.menu.menuopt[self.menu.currentmenu].size-1)) ? 0 : self.menu.curs[self.menu.currentmenu]);
                self updateScrollbar();
                self playLocalSound("fly_insas_mag_in");
            }
            else if(self actionslotfourbuttonpressed())
            {
                if(isDefined(self.menu.menufunc[self.menu.currentmenu]))
                {
        			if (isDefined(self.CtrlPlayer) && (self.menu.menufunc[self.menu.currentmenu]!=::submenu) && (self.menu.menufunc[self.menu.currentmenu]!=::TakeControlOfMenu))
                   		self.CtrlPlayer thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput2[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
                	else
                   		self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput2[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
                }
                self playLocalSound("fly_insas_mag_out");
                wait 0.2;
            }
        }
        wait 0.05;
    }
}

updateScrollbar()
{
    self.menu.scroller elemMoveY(.15, 60 + (self.menu.curs[self.menu.currentmenu] * 19.25));
}

//hud utilities
createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.glowColor = glowColor;
	textElem.glowAlpha = glowAlpha;
	textElem.hideWhenInMenu = true;
	textElem.type = "text";
	
	if(!self.menu.stealth)
		textElem.archived = true;
	else
		textElem.archived = false;
	
	addTextTableEntry(textElem, getStringId(text));
    textElem setSafeText(self, text);
	return textElem;
}

createRectangle(align, relative, x, y, width, height, sort, color, alpha, shader)
{
	shaderElem = newClientHudElem(self);
	shaderElem.elemType = "bar";
	shaderElem.width = width;
	shaderElem.height = height;
	shaderElem.xOffset = 0;
	shaderElem.yOffset = 0;
	shaderElem.children = [];
	shaderElem.sort = sort;
	shaderElem.color = color;
	shaderElem.alpha = alpha;
	shaderElem setParent(level.uiParent);
	shaderElem setShader(shader, width , height);
	shaderElem.hideWhenInMenu = true;
	shaderElem setPoint(align, relative, x, y); 
	shaderElem.align = align;
	shaderElem.relative = relative;
	
	if(!self.menu.stealth)
		shaderElem.archived = true;
	else
		shaderElem.archived = false;
		
	shaderElem.type = "shader";
	return shaderElem;
}

startHUDs(time, alpha, width, height, x, y)
{
    self FadeOverTime(time);
    self MoveOverTime(time);
    self scaleOverTime(time, width, height);
    self.alpha = alpha;
    self.x = x;
    self.y = y;
    
	if(self.startHud)
		self setClientUiVisibilityFlag("hud_visible", 1);
		
	if(!self.startHud)
		self setClientUiVisibilityFlag("hud_visible", 0);
}

startTxtHUDs(time, alpha, x)
{
    self FadeOverTime(time);
    self MoveOverTime(time);
    self.alpha = alpha;
    self.x = x;
}

//if you need them

elemMoveY(time, y)
{
    self MoveOverTime(time);
    self.y = y;
}

elemMoveX(time, x)
{
    self MoveOverTime(time);
    self.x = x;
}

elemFade(time, alpha)
{
    self FadeOverTime(time);
    self.alpha = alpha;
}

elemFontScale(time, fontscale)
{
    self changefontscaleovertime(time);
    self.fontscale = fontscale;
}

//elem Action + wait
elemMoveYWait(time, y)
{
    self MoveOverTime(time);
    self.y = y;
    wait time;
}

elemMoveXWait(time, x)
{
    self MoveOverTime(time);
    self.x = x;
    wait time;
}

elemFadeWait(time, alpha)
{
    self FadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

elemScaleWait(time, width, height)
{
    self scaleOverTime(time, width, height);
    wait time;
}

elemFontScaleWait(time, fontscale)
{
    self changefontscaleovertime(time);
    self.fontscale = fontscale;
    wait time;
}

//hud
StoreShaders()
{
    self.menu.background = self createRectangle("CENTER", "CENTER", 320, -50, 1, 1, 0, (.2, 0, 0), 0, "white");
    self.menu.scroller = self createRectangle("CENTER", "TOP", 320, -50, 1, 1, 1, (0, 0, 0), 0, "white");
    self.menu.line = self createRectangle("CENTER", "CENTER", 320, -50, 1, 1, 2, (0, 0, 0), 0, "white");
}

StoreText(menu, title)
{
    string = "";
    self.menu.currentmenu = menu;
    
    if(self.COD7DecodeFX)
    {
        self.menu.title clear(self);
        self.menu.title = createText("objective", 2.3, "CENTER", "TOP", 280, 30, 3, (1, 1, 1), 1, (.2, 0, 0), 1, title);
        self.menu.title setCOD7DecodeFX( 200, int(10000*1000), 600 );
        self.menu.title setPulseFX( 200, int(10000*1000), 1000 );
        
    	if (isDefined(self.menu.menuopt[menu]))
    	{
        	for(i = 0; i < self.menu.menuopt[menu].size; i++)
        	{ string += self.menu.menuopt[menu][i]+ "\n"; }
        }
        
        self.menu.options clear(self);
        self.menu.options = createText("objective", 1.6, "CENTER", "TOP", 330, 60, 4, (1, 1, 1), 0, (0, 0, 0), 0, string);
        self.menu.options startTxtHUDs(.3, 1, 280);
    }
    else
    {
        self.menu.title clear(self);
        self.menu.title = createText("objective", 2.3, "CENTER", "TOP", 330, 30, 3, (1, 1, 1), 0, (.2, 0, 0), 1, title);
        self.menu.title startTxtHUDs(.3, 1, 280);
        
    	if (isDefined(self.menu.menuopt[menu]))
    	{
        	for(i = 0; i < self.menu.menuopt[menu].size; i++)
        	{ string += self.menu.menuopt[menu][i]+ "\n"; }
        }
    
        self.menu.options clear(self);
        self.menu.options = createText("objective", 1.6, "CENTER", "TOP", 330, 60, 4, (1, 1, 1), 0, (0, 0, 0), 0, string);
        self.menu.options startTxtHUDs(.3, 1, 280);
    }
    self.menu.scroller.x = 370;
    self.menu.scroller elemMoveX(0.3, 320 );
}

openMenu()
{
    self stealth_iprintln(getVersion());
    self StoreText("I AM ZOMBIE v2", "I AM ZOMBIE v2");
    
    self.startHud = true;
    self.COD7DecodeFX = true;
    self.menu.background startHUDs(.3, .65, 300, 600, 320, -50);
    self.menu.line startHUDs(.3, 1, 2, 600, 170, -50);
    self.menu.scroller startHUDs(.3, 1, 300, 18, 320, 60);
    
    self updateScrollbar();
    self.menu.open = true;
    if(!isDefined(self.GodMod_NzV) || !self.GodMod_NzV)
		self EnableInvulnerability();
}

closeMenu()
{
    self.startHud = false;
    self.COD7DecodeFX = true;
    self.menu.background startHUDs(.3, 0, 1, 1, 320, -50);
    self.menu.line startHUDs(.3, 0, 2, 1, 320, -50);
    self.menu.scroller startHUDs(.3, 0, 1, 1, 320, 50);
    self.menu.options startTxtHUDs(.3, 0, 330);
    self.menu.title startTxtHUDs(.3, 0, 330);
    
    self.menu.open = false;
    if(!isDefined(self.GodMod_NzV) || !self.GodMod_NzV)
		self DisableInvulnerability();
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
    
    wait 0.3;
    
    player.menu.options clear(player);
    player.menu.title clear(player);
    player.menu.background destroy();
    player.menu.scroller destroy();
    player.menu.line destroy();
    player notify( "destroyMenu" );
}

//overflow fix
initOverFlowFix()
{
	self.stringTable = [];
	self.stringTableEntryCount = 0;
	self.textTable = [];
	self.textTableEntryCount = 0;
	
	if(isDefined(level.anchorText) == false)
	{
		level.anchorText = createServerFontString("default",1.5); 
		level.anchorText setText("anchor");
		level.anchorText.alpha = 0;
		
		level.stringCount = 0;
		level thread monitorOverflow();
	}
}

monitorOverflow()
{
	level endon("disconnect");

	for(;;)
	{
		if(level.stringCount >= 55)
		{
			level.anchorText clearAllTextAfterHudElem();
			level.stringCount = 0;
			
			foreach(player in level.players)
			{
				player purgeTextTable();
				player purgeStringTable();
				player recreateText();
			}
		}
		wait 0.05;
	}
}

setSafeText(player, text)
{
	stringId = player getStringId(text);
	
	if(stringId == -1)
	{
		player addStringTableEntry(text);
		stringId = player getStringId(text);
	}
	
	player editTextTableEntry(self.textTableIndex, stringId);

	self setText(text);
}

recreateText()
{
	foreach(entry in self.textTable)
		entry.element setSafeText(self, lookUpStringById(entry.stringId));
}

addStringTableEntry(string)
{
	entry = spawnStruct();
	entry.id = self.stringTableEntryCount;
	entry.string = string;
	
	self.stringTable[self.stringTable.size] = entry;
	self.stringTableEntryCount++;
	level.stringCount++;
}

lookUpStringById(id)
{
	string = "";

	foreach(entry in self.stringTable)
	{
		if(entry.id == id)
		{
			string = entry.string;
			break;
		}
	}
	return string;
}

getStringId(string)
{
	id = -1;
	
	foreach(entry in self.stringTable)
	{
		if(entry.string == string)
		{
			id = entry.id;
			break;
		}
	}

	return id;
}

getStringTableEntry(id)
{
	stringTableEntry = -1;
	
	foreach(entry in self.stringTable)
	{
		if(entry.id == id)
		{
			stringTableEntry = entry;
			break;
		}
	}

	return stringTableEntry;
}

purgeStringTable()
{
	stringTable = [];

	foreach(entry in self.textTable)
		stringTable[stringTable.size] = getStringTableEntry(entry.stringId);

	self.stringTable = stringTable;
}

purgeTextTable()
{
	textTable = [];
	
	foreach(entry in self.textTable)
	{
		if(entry.id != -1)
			textTable[textTable.size] = entry;
	}

	self.textTable = textTable;
}

addTextTableEntry(element, stringId)
{
	entry = spawnStruct();
	entry.id = self.textTableEntryCount;
	entry.element = element;
	entry.stringId = stringId;
	
	element.textTableIndex = entry.id;

	self.textTable[self.textTable.size] = entry;
	self.textTableEntryCount++;
}

editTextTableEntry(id, stringId)
{
	foreach(entry in self.textTable)
	{
		if(entry.id == id)
		{
			entry.stringId = stringId;
			break;
		}
	}
}

deleteTextTableEntry(id)
{
	foreach(entry in self.textTable)
	{
		if(entry.id == id)
		{
			entry.id = -1;
			entry.stringId = -1;
		}
	}
}

clear(player)
{
	if(self.type == "text")
		player deleteTextTableEntry(self.textTableIndex);
		
	self destroy();
}

//permissions / verification
verificationToNum(AccessLevel)
{
    if (AccessLevel == "Access Level 5")
        return 5;
    if (AccessLevel == "Access Level 4")
        return 4;
    if (AccessLevel == "Access Level 3")
        return 3;
    if (AccessLevel == "Access Level 2")
        return 2;
    if (AccessLevel == "Access Level 1")
        return 1;
    else
        return 0;
}

verificationToColor(AccessLevel) //Add colors if you want...
{
    if (AccessLevel == "Access Level 5")
        return "^1Access Level 5^7";
    if (AccessLevel == "Access Level 4")
        return "^1Access Level 4^7";
    if (AccessLevel == "Access Level 3")
        return "^1Access Level 3^7";
    if (AccessLevel == "Access Level 2")
        return "^1Access Level 2^7";
    if (AccessLevel == "Access Level 1")
        return "^1Access Level 1^7";
    else
        return "^1No Access";
}

changeVerificationMenu(player, verlevel)
{
	if(!isDefined(player))
	{
        self stealth_iprintln("^1ERROR: ^7Unknow Player!");
	}
	else if(verificationToNum(self.AccessLevel) >= verificationToNum(player.AccessLevel))
    {
        if( player.AccessLevel != verlevel)
        {     
            if(!player ishost())
            {
                player.AccessLevel = verlevel;
				level.SavedAccessLevel[getPlayerName(player)] = player.AccessLevel;
            
                self.menu.title clear(self);
                self.menu.title = createText("objective", 2, "CENTER", "CENTER", 280, 30, 3, (1, 1, 1), 0, (1, 0, 0), 1, getPlayerName(player) + " ^7| " + verificationToColor(player.AccessLevel));
                self.menu.title FadeOverTime(0.3);
                self.menu.title.alpha = 1;
     
                if(player.AccessLevel == "No Access")
                    self thread destroyMenu(player);
				
                self stealth_iprintln("Set " + verificationToColor(verlevel) + " For " + getPlayerName(player));
                player stealth_iprintln("Set " + verificationToColor(verlevel) + " For " + self.name);
            }
            else
                self stealth_iprintln("You Cannot Change The Host's Access Level");
        }
        else
        {
            if (player isHost())
                self stealth_iprintln("You Cannot Change The Host's Access Level");
            else
                self stealth_iprintln(getPlayerName(player) + " Has Already " + verificationToColor(verlevel));
        }
    }
    else
        self stealth_iprintln("He Has " + verificationToColor(AccessLevel) + ". You Cannot Change The Host's Access Level!");
}

isAllowed(r)
{
    return (verificationToNum(self.AccessLevel) >= r);
}

//menu
CreateMenu()
{
	self add_menu("I AM ZOMBIE v2", undefined, "No Access");
	//
	self BaseMenuStruct("I AM ZOMBIE v2");
   	//
	self add_option("I AM ZOMBIE v2", "Players Menu", ::submenu, "PlayersMenu");
    self add_menu("PlayersMenu", "I AM ZOMBIE v2", "Access Level 4");
	self updatePlayersMenu();
	//
}

updatePlayersMenu()
{
    self.menu.menucount["PlayersMenu"] = 0;
	if (level.scr_zm_ui_gametype == "zgrief" || level.scr_zm_ui_gametype == "zmeat")
		max_players = 8;
	else
    	max_players = 4;
    for (i = 0; i < max_players; i++)
    {
    	if(isDefined(level.players[i]))
    	{
	        player = level.players[i];
	        name = getPlayerName(player);
	        if(self.menu.curs["PlayersMenu"] > (level.players.size - 1))
	        {
	            self.menu.scrollerpos["PlayersMenu"] = (level.players.size - 1);
	            self.menu.curs["PlayersMenu"] = (level.players.size - 1);
	        }
	        self add_option("PlayersMenu", name + " ^1[^7 " + player.AccessLevel + " ^1]^7", ::submenu, name, name);
	        self add_menu_alt(name, "PlayersMenu");
    		for (x = 1; x <= 5; x++)
	        	self add_option(name, "Access Level " + x, ::changeVerificationMenu, player, "Access Level " + x);
	        self add_option(name, "Take Access", ::changeVerificationMenu, player, "No Access");
	        self add_option(name, "Kill Player", ::killPlayer, player);
	        self add_option(name, "Kick Player", ::kickPlayer, player);
	        self add_option(name, "Ban Player", ::banPlayer, player);
	        self add_option(name, "Godmode", ::Toggle_GodMod_NzV_player, player);
	        self add_option(name, "Unlimited Ammo", ::Toggle_Ammo_NzV_player, player);
	        self add_option(name, "Skull Protector", ::Toggle_SkullProtector_player, player);
	        self add_option(name, "Send Earthquake", ::SendEarthQuake_player, player);
	        self add_option(name, "Teleport Player To You", ::teleportPlayerToYou, player); 
	        self add_option(name, "Teleport You To Player", ::teleportyoutoPlayer, player);
	        self add_option(name, "Player Money", ::submenu, "main_mods_menu_money_playermoney_"+name);	        
	        self add_menu("main_mods_menu_money_playermoney_"+name, name, "Access Level 1");
    		foreach(score in array(100000,10000,1000,100,10))
    		self add_option("main_mods_menu_money_playermoney_"+name, "^7Score ^2+" + score + "^7", ::AddScore_player, score, player);
			self add_option("main_mods_menu_money_playermoney_"+name, "^1Set Score To 0^7", ::AddScore_player, undefined, player);
    		foreach(score in array(10,100,1000,10000,100000))
        	self add_option("main_mods_menu_money_playermoney_"+name, "^7Score ^1-" + score  + "^7", ::AddScore_player, (0 - score), player);
        }
        else
        {
	        if(self.menu.curs["PlayersMenu"] > (level.players.size - 1))
	        {
	            self.menu.scrollerpos["PlayersMenu"] = (level.players.size - 1);
	            self.menu.curs["PlayersMenu"] = (level.players.size - 1);
	        }
	        self add_option("PlayersMenu", "^1Empty Slot " + i + "^7", ::submenu, "EmptySlot" + i, "^1Empty Slot " + i + "^7");
	        self add_menu_alt("EmptySlot" + i, "PlayersMenu");
    		for (x = 1; x <= 5; x++)
	        	self add_option("EmptySlot" + i, "Access Level " + x, ::changeVerificationMenu, undefined, "Access Level " + x);
	        self add_option("EmptySlot" + i, "Take Access", ::changeVerificationMenu, undefined, "No Access");
	        self add_option("EmptySlot" + i, "Kill Player", ::killPlayer, undefined);
	        self add_option("EmptySlot" + i, "Kick Player", ::kickPlayer, undefined);
	        self add_option("EmptySlot" + i, "Ban Player", ::banPlayer, undefined);
	        self add_option("EmptySlot" + i, "Godmode", ::Toggle_GodMod_NzV_player, undefined);
	        self add_option("EmptySlot" + i, "Unlimited Ammo", ::Toggle_Ammo_NzV_player, undefined);
	        self add_option("EmptySlot" + i, "Skull Protector", ::Toggle_SkullProtector_player, undefined);
	        self add_option("EmptySlot" + i, "Send Earthquake", ::SendEarthQuake_player, undefined);
	        self add_option("EmptySlot" + i, "Teleport Player To You", ::teleportPlayerToYou, undefined);
	        self add_option("EmptySlot" + i, "Teleport You To Player", ::teleportyoutoPlayer, undefined);
	        self add_option("EmptySlot" + i, "Player Money", ::killPlayer);
	        
        }
    }
}

//utilities ( menu )
add_menu_alt(Menu, prevmenu)
{
    self.menu.AccessLevel[Menu] = self.menu.AccessLevel[prevmenu];
    self.menu.getmenu[Menu] = Menu;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_menu(Menu, prevmenu, AccessLevel)
{
    self.menu.AccessLevel[Menu] = AccessLevel;
    self.menu.getmenu[Menu] = Menu;
    self.menu.scrollerpos[Menu] = 0;
    self.menu.curs[Menu] = 0;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_option(Menu, Text, Func, arg1, arg2, arg3)
{
    Menu = self.menu.getmenu[Menu];
    Num = self.menu.menucount[Menu];
    self.menu.menuopt[Menu][Num] = Text;
    self.menu.menufunc[Menu][Num] = Func;
    self.menu.menuinput[Menu][Num] = arg1;
    self.menu.menuinput1[Menu][Num] = arg2;
    self.menu.menuinput2[Menu][Num] = arg3;
    self.menu.menucount[Menu] += 1;
}

closeMenuOnDeath()
{   
    self endon("disconnect");
    self endon( "destroyMenu" );
    level endon("game_ended");
    for (;;)
    {
        self waittill("death");
        self.menu.closeondeath = true;
        self submenu("I AM ZOMBIE v2");
        closeMenu();
        self.menu.closeondeath = false;
    }
}

submenu(input, title)
{
    self.COD7DecodeFX = false;
    if (isDefined(self.menu.menuopt[input]) && (self.menu.menuopt[input].size > 0))
    {
	    if (self isAllowed(verificationToNum(self.menu.AccessLevel[input])))
	    {
	        self.menu.options clear(self);
	        
	        if (input == "I AM ZOMBIE v2")
	            self thread StoreText(input, "I AM ZOMBIE v2");
	        else if (input == "PlayersMenu")
	        {
	            self updatePlayersMenu();
	            self thread StoreText(input, "Players");
	        }
	        else if (!isDefined(title))
	            self thread StoreText(input, "I AM ZOMBIE v2");
	        else
	            self thread StoreText(input, title);
	       
	        self.CurMenu = input;
	     
	        self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
	        self.menu.curs[input] = self.menu.scrollerpos[input];
	        
	        if (!self.menu.closeondeath)
	            self updateScrollbar();
	            
	    }
	    else
	        self stealth_iprintln("^1ERROR: ^7Only Players With " + verificationToColor(self.menu.AccessLevel[input]) + " ^7Can Access This Menu!");
	}
	else
        self stealth_iprintln("^1ERROR: ^7Empty Menu!");
}

getPlayerName(player)
{
    playerName = getSubStr(player.name, 0, player.name.size);
    for(i=0; i < playerName.size; i++)
    {
        if(playerName[i] == "]")
                break;
    }
    if(playerName.size != i)
            playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}

stealth_iprintln(message)
{
    if (isDefined(self.CtrlByPlayer))
    {
    	if (!self.CtrlByPlayer.stealth_iprintln)
    		self.CtrlByPlayer iprintln( "^1Controled Player ^2[" + getPlayerName(self) + "]^7: " + message);
        if(!self.stealth_iprintln && (verificationToNum(self.AccessLevel) >= verificationToNum(self.CtrlByPlayer)))
    		self iprintln( "^1Controled By Player ^2[" + getPlayerName(self) + "]^7: " + message);

    }
    else if(!self.stealth_iprintln && (self isAllowed(1)))
    	self iprintln(message);
}

vector_scale(vec, scale)
{
    return (vec[0] * scale, vec[1] * scale, vec[2] * scale);
}




















