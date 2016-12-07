//==============================================================HOOKS CALLBACKS
stock ac_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{	
	new loadtime = GetTickCount();
	SetPVarInt(playerid,"TimeLoadEV",loadtime);
	SetPVarInt(playerid,"IsEnterV",1);
	new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	if((floatabs(pos[0])-floatabs(VehInfo[vehicleid][posX])) >15 || (floatabs(VehInfo[vehicleid][posX]) - floatabs(pos[0])) >15
	||(floatabs(pos[1])-floatabs(VehInfo[vehicleid][posY]))>15 || (floatabs(VehInfo[vehicleid][posY]) - floatabs(pos[1])) >15
	||(floatabs(pos[2])-floatabs(VehInfo[vehicleid][posZ]))>15 || (floatabs(VehInfo[vehicleid][posZ]) - floatabs(pos[2])) >15)
	{
		SCA(playerid,3,0);
	}
	if(GetPVarInt(playerid,"vehicleid") != 0) SCA(playerid,1,0);
	
	printf("Time load public OnPlayerEnterVehicle = %d",loadtime);
	format(cmdstr,sizeof(cmdstr),"Time load public OnPlayerEnterVehicle = %d",loadtime);
	SCMA(cmdstr);
	
	return OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
}
#if defined _ALS_OnPlayerEnterVehicle
    #undef OnPlayerEnterVehicle
#else
    #define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle ac_OnPlayerEnterVehicle

//======================================================
stock ac_OnPlayerStateChange(playerid, newstate, oldstate)
{
	new loadtime = GetTickCount();
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		if(GetPVarInt(playerid,"IsEnterV") == 0) SCA(playerid,1,0);
		if(loadtime - GetPVarInt(playerid,"TimeLoadEV") < 500) SCA(playerid,1,0);
		SetPVarInt(playerid,"vehicleid",GetPlayerVehicleID(playerid));
	}
	return OnPlayerStateChange(playerid, newstate, oldstate);
}
#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange ac_OnPlayerStateChange

//============================================================
stock ac_SetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
	SetCameraBehindPlayer(playerid);
	SetPVarFloat(playerid, "AirBreak", 3);
	SetPVarFloat(playerid, "OldPosX", x);
	SetPVarFloat(playerid, "OldPosY", y);
	SetPVarFloat(playerid, "OldPosZ", z);
	return SetPlayerPos(playerid,x,y,z);
}
#if defined _ALS_SetPlayerPos
    #undef SetPlayerPos
#else
    #define _ALS_SetPlayerPos
#endif
#define SetPlayerPos ac_SetPlayerPos
//===================================
stock SACM(color,string[])
{
	new newcolor;
	new editstr[128];
	format(editstr,sizeof(editstr),"%s",string);
	switch(color)
	{
	    case 0: newcolor = COLOR_WHITE;
	    case 1:
		{
			format(editstr,sizeof(editstr),"[SYSTEM] %s",string);
			newcolor = COLOR_LIGHTBLUE;
		}
	    case 2:
		{
			format(editstr,sizeof(editstr),"[SYSTEM] %s",string);
			newcolor = COLOR_LIGHTRED;
		}
	    default: newcolor = color;
	}
	return SendClientMessageToAll(newcolor,editstr);
}
#if defined _ALS_SendClientMessageToAll
    #undef SendClientMessageToAll
#else
    #define _ALS_SendClientMessageToAll
#endif
#define SendClientMessageToAll SACM

//=============================================

stock SCM(playerid,color,string[])
{
	new newcolor;
	new editstr[128];
	format(editstr,sizeof(editstr),"%s",string);
	switch(color)
	{
	    case 0: newcolor = COLOR_WHITE;
	    case 1:
		{
		    format(editstr,sizeof(editstr),"[SYSTEM] %s",string);
			newcolor = COLOR_LIGHTBLUE;
		}
	    case 2:
		{
		    format(editstr,sizeof(editstr),"[SYSTEM] %s",string);
			newcolor = COLOR_LIGHTRED;
		}
	    default: newcolor = color;
	}
	return SendClientMessage(playerid,newcolor,editstr);
}
#if defined _ALS_SendClientMessage
    #undef SendClientMessage
#else
    #define _ALS_SendClientMessage
#endif
#define SendClientMessage SCM

//===================================

stock ac_PutPlayerInVehicle(playerid, vehid, seatid)
{
        if(!PutPlayerInVehicle(playerid, vehid, seatid)) return 0;
        SetPVarInt(playerid,"vehicleid",vehid);
        SetPVarInt(playerid,"IsEnterV",1);
        SCMA("PUT");
		//AntiTpInVehicle{playerid} = true;
        if(GetPlayerVehicleSeat(playerid) == 0) OnPlayerStateChange(playerid, PLAYER_STATE_DRIVER, -1);
        else OnPlayerStateChange(playerid, PLAYER_STATE_PASSENGER, -1);
        return PutPlayerInVehicle(playerid, vehid, seatid);
}
#if defined _ALS_PutPlayerInVehicle
    #undef PutPlayerInVehicle
#else
    #define _ALS_PutPlayerInVehicle
#endif
#define PutPlayerInVehicle ac_PutPlayerInVehicle

//=================================================
stock SPD(playerid, dialogid, type, header[], text[], button1[], button2[])
{
    SetPVarInt(playerid,"dh_ac_id",dialogid);//dh_ac_player_dialog_ids[playerid] = dialogid;
    return ShowPlayerDialog(playerid, dialogid, type, header, text, button1, button2);
}
#if defined _ALS_ShowPlayerDialog
    #undef  ShowPlayerDialog
#else
    #define   _ALS_ShowPlayerDialog
#endif
#define  ShowPlayerDialog   SPD

//=====================================================DIALOG HIDER HOOK

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(GetPVarInt(playerid,"dh_ac_id") != dialogid) return SCA(playerid,2,0);
    //if(dh_ac_player_dialog_ids[playerid] != dialogid) return SCA(playerid,2,0);
	//Anee aucaaiiue aeaeia ia ?aaai nio?aiaiiiio oi aucuaaai iaaeee niiauaiey i ?eoa?a
    SetPVarInt(playerid,"dh_ac_id",-1);//dh_ac_player_dialog_ids[playerid] = -1;
#if defined ac_OnDialogResponse
    return ac_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
#endif
}
#if defined _ALS_OnDialogResponse
    #undef    OnDialogResponse
#else
    #define    _ALS_OnDialogResponse
#endif
#define    OnDialogResponse    ac_OnDialogResponse
#if defined ac_OnDialogResponse
forward ac_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

//========================================================================================================END HOOKED CALLBAKCS================================================================================
stock CheckForCheat(playerid)
{
    //new string[256];
	if(PlayerLoggedIn[playerid] == true && GetPVarInt(playerid,"spawned") == 1 && GetPVarInt(playerid, "AFK") < 1 && GetPlayerState(playerid) !=PLAYER_STATE_SPECTATING)
	{
	    //====================================================================================CHECK FOR TP==========================================================
		new Float:pos[3],Float:depth,Float:playerdepth;
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		if(IsPlayerInAnyVehicle(playerid))
		{
			if((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > 80.0 || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > 80.0 ||
			(floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > 80.0 || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > 80.0 ||
			(floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > 80.0/2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > 80.0/2)
			{
			    if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) <= 30)
			    {
				    if(GetPVarInt(playerid,"AirBreak")>0) SetPVarInt(playerid, "AirBreak",GetPVarInt(playerid,"AirBreak")-1);
				    else
				    {
						SCA(playerid,4,0);
						printf("V MAWINE");
						SCM(playerid,0,"V MAWINE");
					}
				}//if
			}//if
			//SetPVarInt(playerid, "AirBreak",3);
		}//if
		else if(!IsPlayerInAnyVehicle(playerid) && !CA_IsPlayerOnSurface(playerid) && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)// нужна проверка на анимацию падения с высоты или полета с парашутом
		{
			if((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > 20 || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > 20 ||
			(floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > 20 || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > 20 ||
			(floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > 40/2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > 40/2)
			{
			    
			    if(GetPVarInt(playerid,"AirBreak")>0) SetPVarInt(playerid, "AirBreak",GetPVarInt(playerid,"AirBreak")-1);
			    else
			    {
					SCA(playerid,4,0);
					printf("NE V MAWINE");
					SCM(playerid,0,"NE V MAWINE");
				}
			    
			}//if
			
		}//else if
		if(!CA_IsPlayerInWater(playerid,depth,playerdepth))
		{
		    switch(GetPlayerAnimationIndex(playerid))
		    {
		        case 958, 959, 1538, 1539, 1543:
		        {
		            if(GetPlayerWeapon(playerid) != 46)//!IsPlayerInRangeOfPoint(50,playerid,1966.8746,-1197.4219,17.4500) && pos[2] > 2)
		            {
			        	SCA(playerid,5,0);
					}
				}
			}//switch
		}
			
		SetPVarFloat(playerid, "OldPosX", pos[0]);
		SetPVarFloat(playerid, "OldPosY", pos[1]);
		SetPVarFloat(playerid, "OldPosZ", pos[2]);
  		//====================================================================================CHECK FOR TP==============================================================================
  		
	}//if logged
}