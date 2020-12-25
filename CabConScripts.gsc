
//---------------------------------------//
//				Tests					 //
//---------------------------------------//



setVieWeapModel()
{
//
}
dvar_cg_fov()
{

}

Toggle_SuperSpeed() 
{
	if(!isDefined(self.SuperSpeed))
		self.SuperSpeed = false;
	self.SuperSpeed = !self.SuperSpeed;
	if(self.SuperSpeed)
       setDvar("g_speed", "500"); 
    else
       setDvar("g_speed", "200"); 
	self stealth_iprintln("Super Speed " + (self.SuperSpeed ? "^2ON" : "^1OFF"));
}


Toggle_Gravity() 
{
	if(!isDefined(self.Toggle_Gravity))
		self.Toggle_Gravity = false;
	self.Toggle_Gravity = !self.Toggle_Gravity;
	if(self.Toggle_Gravity)
       setDvar("bg_gravity", "100"); 
    else
       setDvar("bg_gravity", "800"); 
	self stealth_iprintln("Super Speed " + (self.Toggle_Gravity ? "^2ON" : "^1OFF"));
}










