/*===========================================MODINFO===========================
	Creator: qwezert
	Start creation: 2014
	Version: 0.4 SR
	Проверку на координаты машины - старые координаты - новые и насколько больше, если толкаешь - ложный варинг.
	Обновляем данные машины каждую секнуду и сравниваем координаты - если игрок пытается зайти в машину где координаты машины старые и новые больше 15 метров
	Это чит и кик. (автоматом проверка на аирбрейк,тп в машине)
	- FlyMode добавлен/есть проверка на админа(можно использовать в дальнейшем  проверку на нажатие клавиш и движение обьектов)
	- Рабочее правельное ускорение, поменять параметры и вывести иделаьное ускорение
	- Доделать античит на самые распространенные читы
	- Начать работу над перфоманс тюнингом
	- Начать работу над тюнингом внешки
	
	- Переехал на павнцмд + мускул р41
	
	
	- СРОЧНО !!!!! Перенести все перехваченные функции в инклуды
	
==============================================================================*/
//======================================MAIN INCLUDES
#include <a_samp>
#include <ColAndreas>
#include <Pawn.CMD>
#include <iterators>//foreach
#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <vehicleutil>
//======================================MODFILES
#include <modfiles\m_removes>
#include <modfiles\m_textdraw>
#include <modfiles\m_pickups>
#include <modfiles\getvehiclecolor>
#include <modfiles\colors>//===================COLORS
#include <modfiles\flymode>
#include <modfiles\sendfunc>
//#include <modfiles\FakeOnline>

//==================================MYSQL DATA
/*#define mysql_host "localhost"
#define mysql_db "samp"
#define mysql_user "root"
#define mysql_pass ""*/

/*#define mysql_host "yandex.od.ua"
#define mysql_db "samp"
#define mysql_user "root"
#define mysql_pass "da2W.Pvd"*/

#define FIRE_POWER_SOUND 1039
#define Explosion_Rad 5
#define Explosion_Type 1


#define MAX_STRING 1024
#define MAX_WEAPONS 47

#define WEAPON_BODY_PART_CHEST 3
#define WEAPON_BODY_PART_CROTCH 4
#define WEAPON_BODY_PART_LEFT_ARM 5
#define WEAPON_BODY_PART_RIGHT_ARM 6
#define WEAPON_BODY_PART_LEFT_LEG 7
#define WEAPON_BODY_PART_RIGHT_LEG 8
#define WEAPON_BODY_PART_HEAD 9
//===========================================================================

/*stock SPD(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
 ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
 SetPVarInt(playerid, "USEDIALOGID", dialogid);
 return true;
}
#define ShowPlayerDialog SPD*/


//#define Name(%1) PlayerInfo[%1][pName]*/

#define function%0(%1) forward%0(%1); public%0(%1)
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
// PRESSED(keys)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
// RELEASED(keys)
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	

#define SCMA(%0) SendClientMessageToAdmins(%0)

#define SCA(%0,%1,%2) SendCheaterToAdmins(%0,%1,%2)

function KickEx(giveplayerid)//Кик игрока
{
	Kick(giveplayerid);
	return true;
}
#define KickEx(%0) SetTimerEx("KickEx",100,false,"i",%0)
//==============================================================HOOKS CALLBACKS
//========================
stock ac_SetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
    SCM(playerid,0,"SET POS");
	SetCameraBehindPlayer(playerid);
	SetPVarInt(playerid, "AirBreak", 3);
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
//========================


//==============================


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
	//Если вызванный диалог не равен сохраненному то вызываем паблик сообщения о читере
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
//======================================================FORWARDS

//forward KickEx(giveplayerid);
//forward SkinMenu();
//forward HourTimer();
//forward SecTimer();
//forward GameTime();
//forward GameHWTimer();
//new name[MAX_PLAYER_NAME];
//GetPlayerName(playerid, name, sizeof(name));
//=====================================================NEWVARS


//==================================MYSQL=================
new MySQL:mysql_connect_ID;
//========================================================

new dhour,dminute,dsecond;
new strallg[256];
new strd[128];
new Text3D: DeadText;

new niggskin[MAX_PLAYERS];
new euroskin[MAX_PLAYERS];
new aziaskin[MAX_PLAYERS];
//new connectionHandle = 0;
new bool:PlayerLoggedIn[MAX_PLAYERS];
new firstspawn[MAX_PLAYERS];
//new Menu:SelectRegSkin;
//new rskin[MAX_PLAYERS] = 0;
//new cmdstr[1024];
//new Text:TextDraw[28];


//new Text:RegTextdraw[7];
new PlayerTimer[MAX_PLAYERS];
new VehicleTimer[MAX_VEHICLES];
new hour,minute,second;//,randwea
new ghour = 0,gminute = 0,gsecond = 0;
//new wcheck;

//new engine, lights, alarm, doors, bonnet, boot, objective;

new timerin;
//new timertalk;
//new PlayerText:NextBox[MAX_PLAYERS];
//new PlayerText:ButtonNext[MAX_PLAYERS];
//new PlayerText:box2criminal[MAX_PLAYERS];
//new PlayerText:Criminal[MAX_PLAYERS];
//new PlayerText:box2gov[MAX_PLAYERS];
//new PlayerText:box2norm[MAX_PLAYERS];
//new PlayerText:GovWorker[MAX_PLAYERS];
//new PlayerText:NormalPed[MAX_PLAYERS];


//new clickText[5];
new AfroNormal[] = {6,7,18,24,22,25,66,67};
new AfroGov[]= {7,20,296,297,176,185,221,262};
new AfroCrime[] = {19,21,28,144,142,143,180,241,249,293};

new EuroNormal[] = {2,23,37,46,60,72,73,170,188,51,96,261};
new EuroGov[] = {3,46,101,119,217,223,250,258,259,240};
new EuroCrime[] = {29,30,47,48,177,184,202,206,242,292};

new AsiaNormal[] = {60,170,289};
new AsiaGov[] = {59,228,227};
new AsiaCrime[] = {180,121,122};
//=====================================Females SKINS=======================================
new AsiaFemCrime[] = {56};
new EuroFemCrime[] = {298};
new AfroFemCrime[] = {190};

new AsiaFemGov[] = {263};
new EuroFemGov[] = {55};
new AfroFemGov[] = {219,76};

new AsiaFemNormal[] = {226};
new EuroFemNormal[] = {216};
new AfroFemNormal[] = {148};

//=========================================================================================
enum DIALOG_IDS
{
    dKickMessage,//Автоматически займёт ID 0
    dRegister,//ID 1
    dAuth,//id 2...
	dSaveMail,//3
	dAdminAuth,//4
	dGiveLic,//5
	dAdminTP//6
	
};
enum wInfo
{
    pAmmo,
    pWeapon
}
new PlayerWeapon[MAX_PLAYERS][wInfo][13];

enum radio_info
{
	radio_name[64],
	radio_url[128]
}

/*new ChangeSkin[MAX_PLAYERS];//Переменная для выбора скина
new SkinMan[2] = { 60,72 };
new SkinWoman[2] = { 211,225 };*/

enum pInfo
{
	pID,
	pName[MAX_PLAYER_NAME+2],
	pPassword[20],
	pLevel,
	pSex,
	pSkin,
	pRace,
	pMail[50],
	pDriveLic,
	pGunLic,
	pAdmin,
	pAdminCode[10],
	pStory,
	pMoney,
	pDeagleSkill,
	pLatchkey,
	pMember,
	Float: pHealth,
	Float: pArmour
}
new PlayerInfo[MAX_PLAYERS][pInfo];
enum vInfo
{
	vID,
	Model,
	Engine,
	Light,
	Float:Fuel,
	Fueltank,
 	bool:Temp,
	Color1,
	Color2,
	Float:posX,
	Float:posY,
	Float:posZ,
	Float:angleZ,
	Owner[MAX_PLAYER_NAME+2]
};
new VehInfo[MAX_VEHICLES][vInfo];
//============================================================================
stock ac_SetPlayerArmour(playerid, Float: amount)
{
    SetPVarInt(playerid,"ac_health",2);
	PlayerInfo[playerid][pArmour] = amount;
	return SetPlayerArmour(playerid,amount);
}
#if defined _ALS_SetPlayerArmour
    #undef SetPlayerArmour
#else
    #define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour ac_SetPlayerArmour


stock ac_SetPlayerHealth(playerid, Float: amount)
{
	SetPVarInt(playerid,"ac_health",2);
	PlayerInfo[playerid][pHealth] = amount;
	printf("SET PLAYER HEALTH amount = %f",amount);
	printf("SET PLAYER HEALTH array = %f",PlayerInfo[playerid][pHealth]);
	return SetPlayerHealth(playerid, amount);
}
#if defined _ALS_SetPlayerHealth
    #undef SetPlayerHealth
#else
    #define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth ac_SetPlayerHealth



stock ac_ResetPlayerWeapons(playerid)
{
	printf("RESET WEAPON!");
	SCM(playerid,0,"RESET WEAPON");
	for(new i = 0; i< 13; i++)
	{
	    PlayerWeapon[playerid][pAmmo][i] = 0;
	    PlayerWeapon[playerid][pWeapon][i] = 0;
	    //PlayerWeapon[playerid][pWeapon][i] = 0;
	    printf("RESET AMMO = %d RESET WEAPON = %d",PlayerWeapon[playerid][pAmmo][i],PlayerWeapon[playerid][pWeapon][i]);
	}
 	ResetPlayerWeapons(playerid);
	return 1;
}
#if defined _ALS_ResetPlayerWeapons
    #undef ResetPlayerWeapons
#else
    #define _ALS_ResetPlayerWeapons
#endif
#define ResetPlayerWeapons ac_ResetPlayerWeapons


stock ac_GivePlayerWeapon(playerid,weaponid,ammo)
{
	//if(GetPVarInt(playerid,"forspawn")==0)
	//{
	if(PlayerWeapon[playerid][pAmmo][GetWS(weaponid)] == 0) PlayerWeapon[playerid][pAmmo][GetWS(weaponid)] = ammo;
	else PlayerWeapon[playerid][pAmmo][GetWS(weaponid)] += ammo;
	PlayerWeapon[playerid][pWeapon][GetWS(weaponid)] = weaponid;
	printf("GIVER WEAPID = %d, AMMO = %d",weaponid,ammo);
	 	
 	//}
 	return GivePlayerWeapon(playerid,weaponid,ammo);
}
#if defined _ALS_GivePlayerWeapon
    #undef GivePlayerWeapon
#else
    #define _ALS_GivePlayerWeapon
#endif
#define GivePlayerWeapon ac_GivePlayerWeapon


stock ac_DestroyVehicle(vehicleid)
{
	SACM(0,"Destroy Vehicle Timer");
    KillTimer(VehicleTimer[vehicleid]);
    
    if(VehInfo[vehicleid][Temp] == true) return DestroyVehicle(vehicleid);
    
    new query_string[128];
    
	
	
	format(query_string,sizeof(query_string),"DELETE FROM `vehicles` WHERE `vID` = '%d'",VehInfo[vehicleid][vID]);
	
	mysql_tquery(mysql_connect_ID, query_string, "", "");
	
	printf("QUERY VEH = %s",query_string);
	
	printf("ERRORNO = %d", mysql_errno());
	
	VehInfo[vehicleid][Temp] = true;
	
	printf("[SYSTEM] Транспорт успешно удален!");
	
	
	
	
	return DestroyVehicle(vehicleid);
}
#if defined _ALS_DestroyVehicle
    #undef DestroyVehicle
#else
    #define _ALS_DestroyVehicle
#endif
#define DestroyVehicle ac_DestroyVehicle



//=================================================================================================MAIN CODE===========================================================================================


main()
{
}

public OnGameModeInit()
{
	new cmdstr[32];
	CA_Init();

	SetGravity(0.009);
	SetTeamCount(1);
	EnableVehicleFriendlyFire();
	
	GetServerVarAsString("password",cmdstr,sizeof(cmdstr));
	if(!isnull(cmdstr)) SendRconCommand("password 0");
	
    
   	new MySQLOpt: option_id = mysql_init_options();
	mysql_set_option(option_id, AUTO_RECONNECT, true);
	
    mysql_connect_ID = mysql_connect_file();
    
    if (mysql_connect_ID == MYSQL_INVALID_HANDLE || mysql_errno(mysql_connect_ID) != 0)
		printf("Подключение к базе данных не активно"), SendRconCommand("exit");
	else printf("Подключение к базе данных активно");
	

	
    mysql_tquery(mysql_connect_ID, !"SET CHARACTER SET 'utf8'", "", "");
	mysql_tquery(mysql_connect_ID, !"SET NAMES 'utf8'", "", "");
	mysql_tquery(mysql_connect_ID, !"SET character_set_client = 'cp1251'", "", "");
	mysql_tquery(mysql_connect_ID, !"SET character_set_connection = 'cp1251'", "", "");
	mysql_tquery(mysql_connect_ID, !"SET character_set_results = 'cp1251'", "", "");
	mysql_tquery(mysql_connect_ID, !"SET SESSION collation_connection = 'utf8_general_ci'", "", "");
    
    gettime(hour,minute,second);
    ghour = hour;
    gminute = minute;
    gsecond = second;
    
	GameHW(ghour);
	SetTimer("HourTimer",1000*3600,true);
	SetTimer("SecTimer",1000,true);
	SetTimer("GameTime",200,true);
	//SetTimer("WeatherTimer",1000*1800,true);
	//SetTimer("GameHWTimer",1000*720,true);
	//SkinMenu();
	//=====================================================
	ShowPlayerMarkers (PLAYER_MARKERS_MODE_STREAMED) ;
	ShowNameTags(1) ;
	SetNameTagDrawDistance(10.0) ;
	DisableInteriorEnterExits() ;
	ManualVehicleEngineAndLights() ;
	AllowInteriorWeapons(1) ;
	LimitPlayerMarkerRadius(30.0) ;
	EnableStuntBonusForAll(0);
	
	
	SetGameModeText("SR v0.4");
	//======================================================
	LoadTextDraws();
	LoadPickups();
	
	cmdstr = "SELECT * FROM `vehicles`";
	mysql_tquery(mysql_connect_ID, cmdstr, "LoadVehicles", "");
	//AddPlayerClass(0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);

	return 1;
}

public OnGameModeExit()
{
    foreach(new pl:Player)
	{
		if(noclipdata[pl][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(pl);
	}
	
	SaveVehicles();
    mysql_close(mysql_connect_ID);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	OnPlayerLogin(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
    if(!IsRPNick(playerid))
	{
		SCM(playerid, 2,"=======================================================");
		SCM(playerid, 2, " Твой NickName не корректен! Нужен по форме Имя_Фамилия");
		SCM(playerid, 2, " NickName не может быть короче 5 и длиннее 23 букв!");
		SCM(playerid, 2,"=======================================================");
		KickEx(playerid);
		return 1;
	}
	
	
	RemoveBuildings(playerid);
	
    TogglePlayerClock(playerid, 0);
    
	LoadAnimLib(playerid);
	
	PlayerLoggedIn[playerid]= false;
	
	niggskin[playerid] = 0;
	euroskin[playerid] = 0;
	aziaskin[playerid] = 0;
	
	
	PlayerHeal(playerid);

	SetPlayerColor(playerid,COLOR_WHITE);
	
    PlayerTimer[playerid] = SetTimerEx("PlayerUpdate", 1000, 0, "d", playerid);
    SetTimerEx("CheckForCheat", 250, 1, "d", playerid);
    SetTimerEx("VehicleAccelTimer", 500, 1, "d", playerid);
    
    TextDrawShowForPlayer(playerid,LogoText);

	return 1;
}

OnPlayerLogin(playerid)
{
	new query_string[64];
	new plName[MAX_PLAYER_NAME+2];
	GetPlayerName(playerid,plName,sizeof(plName));

	mysql_escape_string(Name(playerid),plName);

	format(query_string,sizeof(query_string),"SELECT * FROM `players` WHERE `pName` = '%s'",plName);

	printf("QUERY = %s",query_string);

	mysql_tquery(mysql_connect_ID, query_string, "FindPlayerInTable","i", playerid);

	/*mysql_query(cmdstr);
	mysql_store_result();*/
	
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(PlayerTimer[playerid]);
	if(PlayerLoggedIn[playerid]) SavePlayer(playerid);
	SaveWeapons(playerid);
	ResetPlayerVars(playerid);
	TextDrawHideForPlayer(playerid,LogoText);
	return 1;
}

public OnPlayerSpawn(playerid)
{
//	new cmdstr[128];
    if(!PlayerLoggedIn[playerid] && firstspawn[playerid] == 0)
	{
		SCM(playerid, 2, "Необходимо авторизоваться!");
		KickEx(playerid);
		return true;
	}
	//if(GetPVarInt(playerid,"spawned") == 1) return 0;
	/*else if (firstspawn[playerid] == 1 && logged[playerid] == 0)
	{
	    
	    for(new i = 0; i< sizeof(RegTextdraw); i++)
	    {
	        TextDrawShowForPlayer(playerid,RegTextdraw[i]);
	    }
		PlayerTextDrawShow(playerid,NextBox[playerid]);
		PlayerTextDrawShow(playerid,box2criminal[playerid]);
		PlayerTextDrawShow(playerid,Criminal[playerid]);
		PlayerTextDrawShow(playerid,box2gov[playerid]);
		PlayerTextDrawShow(playerid,box2norm[playerid]);
		PlayerTextDrawShow(playerid,GovWorker[playerid]);
		PlayerTextDrawShow(playerid,NormalPed[playerid]);
		SelectTextDraw(playerid,COLOR_LIGHTBLUE);
		TogglePlayerControllable(playerid,0);
        InterpolateCameraLookAt(playerid, 50.0, 50.0, 10.0, -50.0, 50.0, 10.0, 10000, CAMERA_MOVE);
	}*/
	if(PlayerLoggedIn[playerid])
	{
	    
	    printf("VIZOV SPAWN");
	    //DeletePVar(playerid,"forspawn");
	    SetPlayerToTeamColor(playerid);
	    SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
	    SetPlayerVirtualWorld(playerid,0);
	    SetPlayerInterior(playerid,0);
	    SetPlayerTeam(playerid, 1);
	    
	    SetPVarInt(playerid,"spawned",1);
	    
		if(PlayerInfo[playerid][pHealth] < 0) SetPlayerHealth(playerid,20.0);
	    SetPlayerHealth(playerid,PlayerInfo[playerid][pHealth]);
	    SetPlayerArmour(playerid,PlayerInfo[playerid][pArmour]);
	    
	    //ResetPlayerWeapons(playerid);
	    
        //
        
	    
	    //OnPlayerCommandText(playerid,"/audiomsg 0");
	    if(firstspawn[playerid] == 1)
	    {
			switch(PlayerInfo[playerid][pStory])
		    {
		        case 1: //Интро если игрок - бандит.
		        {
	                TextDrawShowForPlayer(playerid, td_intro[0]);
					TextDrawShowForPlayer(playerid, td_intro[1]);
					SetPVarInt(playerid,"story",1);
					SetPVarInt(playerid,"part",1);
					SetPVarInt(playerid,"count",0);
	    			SetPlayerPos(playerid,265.9044,77.9883,1001.0391);
	    			SetPlayerInterior (playerid, 6);
					SetPlayerVirtualWorld (playerid, playerid+1);
				    TogglePlayerControllable(playerid,0);
					timerin = SetTimerEx("TimerIntro",3000,true,"d",playerid);
					return 0;
					//SetPVarString(playerid,"",infostr);

		        }
		        case 2://Интро если игрок - бизнесмен.
		        {
		            TextDrawShowForPlayer(playerid, td_intro [0]);
					TextDrawShowForPlayer(playerid, td_intro [1]);
		            SetPVarInt(playerid,"story",2);
					SetPVarInt(playerid,"part",1);
					SetPlayerPos(playerid,2.8469, 28.0878, 1200.0781);
					SetPlayerInterior(playerid, 1);
					SetPlayerVirtualWorld (playerid, playerid+1);
					TogglePlayerControllable(playerid,0);
					ApplyAnimation(playerid, "FOOD", "FF_Sit_Eat2", 4.1, 0, 1, 1, 1, 1);
					SetPlayerCameraPos(playerid, 0.7122, 30.5538, 1200.0479);
					SetPlayerCameraLookAt(playerid, 1.4914, 29.9293, 1199.9037);
					timerin = SetTimerEx("TimerIntro",3000,true,"d",playerid);
					return 0;
		        }
		    }
	    }
	    else
	    {
			SetPlayerPos(playerid,1682.9122,-2243.4753,13.5413);
			SetPlayerFacingAngle(playerid, 90);
			SetCameraBehindPlayer(playerid);
			if(PlayerInfo[playerid][pAdmin] >=1 && GetPVarInt(playerid,"adminacces") == 0)
		    {
		        SPD(playerid,4,DIALOG_STYLE_INPUT,"Доступ к администрированию","Введите ваш админ. пароль в поле ниже для авторизации","Далее","");
		    }
		    return 0;
	    }
	}
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    new cmdstr[144];
    new slot = GetWS(weaponid);

	//printf("PATRONI = %d",PlayerWeapon[playerid][pAmmo][slot]);
	
    
    /*format(cmdstr, sizeof(cmdstr), "Weapon %i fired. hittype: %i   hitid: %i   pos: %f, %f, %f", weaponid, hittype, hitid, fX, fY, fZ);
    SCM(playerid, 0, cmdstr);*/
   
	//if(PlayerWeapon[playerid][pAmmo][slot] > 0)
	PlayerWeapon[playerid][pAmmo][slot]--;
	if(PlayerWeapon[playerid][pAmmo][slot] == 0)
	{
	    format(cmdstr,sizeof(cmdstr),"DELETE FROM `player_weapons` WHERE `pwID` = '%d' AND `weaponid` = '%d'",PlayerInfo[playerid][pID],weaponid);
	    mysql_tquery(mysql_connect_ID, cmdstr, "", "");
		PlayerWeapon[playerid][pWeapon][slot] = 0;
	}
	else if(PlayerWeapon[playerid][pAmmo][slot] < 0)
	{
	    ResetPlayerWeapons(playerid);
		return SCA(playerid,6,0);
	}
	
//	format(cmdstr, sizeof(cmdstr), "PATRONI = %d SHOTS = %d",PlayerWeapon[playerid][pAmmo][slot],shots[playerid]);
   // SCM(playerid, 0, cmdstr);
    
	
	if(hitid != INVALID_PLAYER_ID && PlayerLoggedIn[hitid]) GiveDamageForPlayer(hitid,weaponid);
	
	
	
    
    return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
	PlayerInfo[playerid][pHealth] = PlayerInfo[playerid][pHealth] - amount;
    if(weaponid == WEAPON_COLLISION && issuerid == INVALID_PLAYER_ID && amount >= 4.95)
	{
		SCM(playerid,0,"COLLISION DAMAGE");
		
	}

   	if(weaponid == WEAPON_VEHICLE && issuerid != INVALID_PLAYER_ID)
	{
    	SCM(playerid,0,"VEHICLE DAMAGE FROM PLAYER");
	}

	if(weaponid == WEAPON_FLAMETHROWER)
	{
 		SCM(playerid,0,"FLAMEDAMAGE");
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
    //PlayerHeal(playerid);
    //ResetPlayerWeapons(playerid);
	//SetPlayerHealth(playerid, 25.0);
	DeletePVar(playerid,"firepower");
	SetPVarInt(playerid, "CheckFall", 0);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    new Float:vehx, Float:vehy, Float:vehz, Float:vehangle;
    GetVehicleZAngle(vehicleid, vehangle);
    GetVehiclePos(vehicleid, vehx, vehy, vehz);
    VehInfo[vehicleid][posX] = vehx;
    VehInfo[vehicleid][posY] = vehy;
    VehInfo[vehicleid][posZ] = vehz;
    VehInfo[vehicleid][angleZ] = vehangle;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{

	return 1;
}

public OnPlayerText(playerid, text[])
{
	new cmdstr[512];
	if(!PlayerLoggedIn[playerid]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "PED", "IDLE_CHAT",4.1,0,1,1,1,1);
		SetTimerEx("TimerTalk",5000,false,"u",playerid);
	}
	format(cmdstr, sizeof(cmdstr), "- %s[%d]: %s", Name(playerid),playerid, text);
	SetPlayerChatBubble(playerid, text, 0x6495EDFF, 20.0, 10000);
	ProxDetector(20.0, playerid, cmdstr,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	return false;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!PlayerLoggedIn[playerid])
    {
           SCM(playerid,2,"Вы не можете писать команды не авторизовавшись!");
		   KickEx(playerid);
           return 0;
    }
	return 1;
}
//=====================================================================IZCMD commands========================================
CMD:lights(playerid,params[] )
{
	new vehicleid = GetPlayerVehicleID(playerid);
	ToggleLightState(vehicleid);
	return 1;
}
CMD:en(playerid,params[] )
{
	new vehicleid = GetPlayerVehicleID(playerid);
	ToggleEngineState(vehicleid);
	return 1;
}
CMD:accdeath(playerid,params[] )
{
	new str[128];
	SetPVarInt(playerid,"teh_dead",1);
	Delete3DTextLabel(DeadText);
	TogglePlayerControllable(playerid,1);
	SetPlayerHealth(playerid,0.0);
	PlayerHeal(playerid);
	format(str,sizeof(str),"{AA3333}(( Игрок %s принял свою техническую смерть ))",Name(playerid));
	SetPlayerChatBubble(playerid,str,-1,10,3000);
	return 1;
}
CMD:damages(playerid,params[] )
{
	new targetid;
	if(sscanf(params,"d",targetid)) return SCM(playerid,0,"Введите /damages [id]");
	//new Float: posp[3];
	new Float:pospX,Float:pospY,Float:pospZ;
	pospX = GetPVarFloat(targetid,"xpos");
	pospY = GetPVarFloat(targetid,"ypos");
	pospZ = GetPVarFloat(targetid,"zpos");
	if(!IsPlayerInRangeOfPoint(playerid,3.0,pospX,pospY,pospZ)) return SCM(playerid,1,"Вы должны находится рядом!");
	//SCM(playerid,0,strallg);
	ShowPlayerDialog(playerid,1313,DIALOG_STYLE_LIST,"Информация",strallg,"Ок","");

	return 1;
}
CMD:money(playerid,params[] )
{
	new cmdstr[64];
	new dollars = 100; new cents = 50; new rupis = 0;
	format(cmdstr,sizeof(cmdstr),"У вас на руках: %i долларов\n%i центов\n%i рупий",dollars,cents,rupis);
	SCM(playerid,0,cmdstr);
	return 1;
}
CMD:time(playerid,params[] )
{
	new cmdstr[64];
	new string[128];
	if(gminute <= 9) format(string,sizeof(string),"Текущее игровое время %d:0%d",ghour,gminute);
	else format(string,sizeof(string),"Текущее игровое время %d:%d",ghour,gminute);
	SCM(playerid,1,string);
    gettime(hour,minute,second);
	if (minute <= 9) format(cmdstr,sizeof(cmdstr),"Текущее реальное время %d:0%d",hour,minute);
 	else format(cmdstr,sizeof(cmdstr),"Текущее реальное время %d:%d",hour,minute);
 	SCM(playerid,1,cmdstr);
 	return 1;
}
//===============================================================pawnCMD ADMINS COMMANDS======================================================================
CMD:shapass(playerid,params[])
{
	new string[64+1];
	new myhash[64+1];
	if(sscanf(params,"s",string)) return SCM(playerid,0,"Введите /shapass [string]");
    if(IsAdmin(playerid)<4) return 1;
    SHA256_PassHash(string,"1234",myhash,sizeof(myhash));
    printf("Returned hash: %s", myhash);
	return 1;
}
CMD:takedmg(playerid,params[])
{
	if(IsAdmin(playerid)<4) return 1;
	OnPlayerTakeDamage(playerid,0,50,WEAPON_COLLISION,3);
	return 1;
}
CMD:setwt(playerid,params[])
{
	new wtime;
	if(IsAdmin(playerid)<4) return 1;
	if(sscanf(params,"d",wtime)) return SCM(playerid,1,"Введите /setwt [time]");
	SetWorldTime(wtime);
	return 1;
}
CMD:object(playerid,params[])
{
    for(new i=0; i<6; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
    }
	/*SetPlayerAttachedObject(playerid, 2, 18693   , 5, 0.1, 0, 0, 0, 0, 0, 0, 0, 0); //18688 - good fire
	SetPlayerAttachedObject(playerid, 1, 18693   , 6, 0.1, 0, 0, 0, 0, 0, 0, 0, 0);*/
	
	SetPlayerAttachedObject( playerid, 0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000);
	SetPlayerAttachedObject( playerid, 1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 2, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 3, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	
	SetPlayerAttachedObject( playerid, 6, 18693, 9, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 7, 18693, 10, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	return 1;
}
CMD:firepower(playerid,params[])
{
	if(IsAdmin(playerid)<4) return 1;
	if(GetPVarInt(playerid,"firepower") == 1)
	{
	    for(new i=0; i<=7; i++)
	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
	    }
		DeletePVar(playerid,"firepower");
		return 1;
	}

	SetPlayerAttachedObject( playerid, 0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000);
	SetPlayerAttachedObject( playerid, 1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 2, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 3, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );

	SetPlayerAttachedObject( playerid, 6, 18688, 9, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 7, 18688, 10, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );

	SetPVarInt(playerid,"firepower",1);
	return 1;
}
CMD:delguns(playerid,params[])
{
    if(IsAdmin(playerid)<4) return 1;
   	new target;
	if(sscanf(params,"u",target)) return SCM(playerid,0,"Введите /delgun [playerid]");
	ResetPlayerWeapons(playerid);
	return 1;
}
CMD:setw(playerid,params[])
{
	if(IsAdmin(playerid)<4) return 1;
	new weather;
	if(sscanf(params,"d",weather)) return SCM(playerid,0,"Введите /setw [weather id]");
	SetWeather(weather);
	return 1;
}
CMD:flymode(playerid,params[])
{
	if(IsAdmin(playerid)<1) return 1;
    // Place the player in and out of edit mode
	if(GetPVarType(playerid, "FlyMode")) CancelFlyMode(playerid);
	else FlyMode(playerid);
	return 1;
}
CMD:pltext(playerid,params[])
{
	new targetid;
	if(IsAdmin(playerid)<4) return 1;
	if(sscanf(params,"us",targetid,params)) return SCM(playerid,0,"Введите /pltext [playerid] [text]");
	OnPlayerText(targetid,params);
	return 1;
}
/*CMD:cmd(playerid,params[])
{
	if(IsAdmin(playerid)<4) return 1;
	new strtemp[128];
	format(strtemp,sizeof(strtemp),"%s",params[1]);
	if(sscanf(params,"us",params[0],params[1])) return SCM(playerid,0,"Введите /cmd [playerid] [command]");
	printf("CMD = %s",params[1]);
	OnPlayerCommandText(params[0],strtemp);
	return 1;
}*/
CMD:a(playerid,params[])
{
	new msg[128];
	if(IsAdmin(playerid)<1) return 1;
	if(sscanf(params,"s[128]",msg)) return SCM(playerid,0,"Введите: /a text");
	new cmdstr[512];
	format(cmdstr,sizeof(cmdstr),"[A] %s[%d]: %s",Name(playerid),playerid,msg);
	SCMA(cmdstr);
 	printf("STRLEN SCMDSTR /a = %d",strlen(cmdstr));
	return 1;
}
alias:a("achat");

/*CMD:nostock(playerid,params[] )
{
	if(sscanf(params,"d",params[0])) return SCM(playerid,0,"но");
	new cmdstr[12];
	format(cmdstr,sizeof(cmdstr),"%d",TestNoStock(params[0]));
	SCM(playerid,0,cmdstr);
	return 1;
}*/
CMD:setvel(playerid,params[] )
{
	new vid = GetPlayerVehicleID(playerid);
	setVehicleSpeed(vid,100);
	return 1;
}
CMD:givegun(playerid,params[] )
{
	new targetid,gunid,ammo;
    if(IsAdmin(playerid) <=3 ) return true;
	if(sscanf(params,"iii",targetid,gunid,ammo)) return SCM(playerid,0,"Введите /givegun [id] [id gun] [ammo]");
	if(targetid == INVALID_PLAYER_ID) return SCM(playerid,1,"Такого игрока не существует!");
	GivePlayerWeapon(targetid, gunid, ammo);
	
	return 1;
}
CMD:setar(playerid,params[] )
{
	new targetid,Float:ar;
    if(IsAdmin(playerid) <=2 ) return true;
    if(sscanf(params,"df",targetid,ar)) return SCM(playerid,0,"Введите /setar [id] [ar]");
	SetPlayerArmour(targetid,ar);
	return 1;
}
CMD:sethp(playerid,params[] )
{
	new targetid,Float:hp;
    if(IsAdmin(playerid) <=2 ) return true;
    if(sscanf(params,"df",targetid,hp)) return SCM(playerid,0,"Введите /sethp [id] [hp]");
	SetPlayerHealth(targetid,hp);
	return 1;
}
CMD:givemoney(playerid,params[] )
{
    new targetid,money;
    if(IsAdmin(playerid) <=4 ) return true;
	if(sscanf(params,"ud",targetid,money)) return SCM(playerid,0,"Введите /givemoney [id] [money]");
	if(targetid == INVALID_PLAYER_ID) return SCM(playerid,0,"Такого игрока не существует!");
	GivePlayerMoney(targetid,money);
	PlayerInfo[playerid][pMoney] += money;
	return 1;
}
CMD:secretcode(playerid,params[] )
{
    if(IsAdmin(playerid) <=0 ) return true;
    SPD(playerid,4,DIALOG_STYLE_INPUT,"Доступ к администрированию","Введите ваш админ. пароль в поле ниже для авторизации","Далее","");
	return 1;
}

CMD:testadmin(playerid,params[] )
{
	PlayerInfo[playerid][pAdmin] = 5;
	format(PlayerInfo[playerid][pAdminCode],10,"test");
	SPD(playerid,4,DIALOG_STYLE_INPUT,"Доступ к администрированию","Введите ваш админ. пароль в поле ниже для авторизации","Далее","");
	return 1;
}
CMD:setadmin(playerid,params[] )
{
    new targetid,level;
	if(IsAdmin(playerid) <=4 ) return true;
	if(sscanf(params,"ud",targetid,level)) return SCM(playerid,0,"Введите /setadmin [id] [lvl]");
	if(level < 0 && level >5) return SCM(playerid,0,"Нельзя меньше 0 и больше 5!");
	
	new cmdstr[128];
	if(level == 0)
	{
	    PlayerInfo[targetid][pAdmin] = level;
		format(cmdstr,sizeof(cmdstr),"Вы сняли админ. права с игрока %s",Name(targetid));
		SCM(playerid,1,cmdstr);
		format(cmdstr,sizeof(cmdstr),"{FFFFFF}Администратор снял с вас админ. права");
		SPD(targetid,10005,DIALOG_STYLE_MSGBOX,"Системное сообщение",cmdstr,"Закрыть","");
		return 1;
	}
	new message[10];
	format(cmdstr,sizeof(cmdstr),"Вы выдали игроку %s админ. права %i уровня",Name(targetid),level);
	SCM(playerid,1,cmdstr);
	new randmsg[3];
	format(message,sizeof(message),"%s",RandText(6));
	format(randmsg,sizeof(randmsg),"%d",random(100));
	strcat(message,randmsg);
	format(cmdstr,sizeof(cmdstr),"{FFFFFF}Администратор выдал вам админ. права %i уровня.\nВаш админ. пароль доступа {FF0000} %s\nОбязательно сохраните ваш пароль! Вы его не сможете больше посмотреть!\n",targetid,message);
	PlayerInfo[targetid][pAdminCode] = message;
	PlayerInfo[targetid][pAdmin] = level;
	SPD(targetid,10005,DIALOG_STYLE_MSGBOX,"Системное сообщение",cmdstr,"Закрыть","");
	return 1;
}
CMD:saveallacc(playerid,params[] )
{
    if(IsAdmin(playerid)<= 4 ) return true;
    SaveAllPlayers();
	return 1;
}
CMD:agl(playerid,params[] )
{
    new targetid;
    if(IsAdmin(playerid)<= 3 ) return true;
    if(sscanf(params, "u", targetid)) return SCM(playerid,0, "Введите: /agl [id]");
    SetPVarInt(playerid, "player", targetid);
	SPD(playerid,5,DIALOG_STYLE_LIST,"Выдать лицензии","Выдать лицензию на вождение\nВыдать лицензию на оружие","Выбрать","Отмена");
	return 1;
}
CMD:setlvl(playerid,params[] )
{
	new targetid,level;
    if(IsAdmin(playerid)<= 3 ) return true;
    if(sscanf(params, "ud", targetid,level)) return SCM(playerid,0, "Введите: /setlvl [id] [lvl]");
	PlayerInfo[targetid][pLevel] = level;
	return 1;
}

/*CMD:text(playerid,params[] )
{
    
	for(new i = 0;i< sizeof(RegTextdraw); i++)
	{
		TextDrawShowForPlayer(playerid,RegTextdraw[i]);
	}
	SelectTextDraw(playerid,COLOR_LIGHTBLUE);
	return 1;
}*/
CMD:g(playerid,params[] )
{
    new targetid;
    if(IsAdmin(playerid)<= 3 ) return true;
	if(sscanf(params,"u",targetid)) return SCM(playerid,0,"Введите /g [id игрока]");
	if(targetid == INVALID_PLAYER_ID) return SCM(playerid,0,"Такого игрока не существует!");
	new cmdstr[128];
	new Float: px, Float: py, Float: pz;
	GetPlayerPos(targetid,px,py,pz);
	SetPlayerPos(playerid,px,py+1,pz);
	format(cmdstr,sizeof(cmdstr),"Вы телепортировались к игроку %s [%d]",Name(targetid),targetid);
	SCM(playerid,0,cmdstr);
	return 1;
}
alias:g("goto");
CMD:gpt(playerid,params[])
{
	new targetid,team;
	new cmdstr[64];
	if(sscanf(params,"d",targetid)) return SCM(playerid,0,"Введите /gpt id");
	team = GetPlayerTeam(targetid);
	format(cmdstr,sizeof(cmdstr),"Команда игрока = %d",team);
	SCM(playerid,0,cmdstr);
	return 1;
}
CMD:gh(playerid,params[] )
{
	new targetid;
    if(IsAdmin(playerid)<= 3 ) return true;
	if(sscanf(params,"d",targetid)) return SCM(playerid,0,"Введите /gh [id игрока]");
	//if(targetid == INVALID_PLAYER_ID) return SCM(playerid,0,"Такого игрока не существует!");
	if(!IsPlayerConnected(targetid)) return SCM(playerid,0,"Такого игрока нет!");
	new cmdstr[128];
	new Float: px, Float: py, Float: pz;
	GetPlayerPos(playerid,px,py,pz);
	SetPlayerPos(targetid,px,py+1,pz);
	format(cmdstr,sizeof(cmdstr),"Вы телепортировали к себе игрока %s [%d]",Name(targetid),targetid);
	SCM(playerid,0,cmdstr);
	return 1;
}
//ALTX:gh("/gethere");

CMD:tpcor(playerid,params[] )
{
    if(IsAdmin(playerid)<= 2 ) return true;
	//new Float: coord[3];
	new Float:coordX,Float:coordY,Float:coordZ;
	new interior;
	if(sscanf(params,"p<,>fffi",coordX,coordY,coordZ,interior)) return SCM(playerid,0,"Введите /tpcor x y z int");
	SetPlayerPos(playerid,coordX,coordY,coordZ);
	SetPlayerInterior(playerid,interior);
	SetCameraBehindPlayer(playerid);
	return 1;
}
CMD:tp(playerid,params[] )
{
    if(IsAdmin(playerid)<= 2 ) return true;
	SPD(playerid,6,DIALOG_STYLE_LIST,"Телепорт","1. Аэропорт\n2. Мэрия\n3. АвтоШкола\n4. Grove\n5. Ballas\n6. СМИ\n7. Банк\n8. \n{33FFCC}Интерьеры:\n\
	{ffffff}1. АвтоШкола\n2. Мэрия Интерьер\n3. Ammo Nation\n4. Магазин Одежды\n5. СМИ\n6. Больница\n7. Grove\n8. Ballas","Выбрать","Отмена");
	return 1;
}
CMD:saveveh(playerid,params[])
{
    if(IsAdmin(playerid)<= 3 ) return true;
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,0,"Введите: /saveveh только в машине!");
    new Float:X,Float:Y,Float:Z,Float:ang;
	GetPlayerPos(playerid, X,Y,Z);
	GetPlayerFacingAngle(playerid,ang);
	new vehid = GetPlayerVehicleID(playerid);
	new vehmodel = GetVehicleModel(vehid);
	new col1,col2;
	GetVehicleColor(vehid,col1,col2);
	VehInfo[vehid][vID] = vehid;
	VehInfo[vehid][Model] = vehmodel;
	VehInfo[vehid][posX] = X;
	VehInfo[vehid][posY] = Y;
	VehInfo[vehid][posZ] = Z;
	VehInfo[vehid][angleZ] = ang;
	VehInfo[vehid][Color1] = col1;
	VehInfo[vehid][Color2] = col2;
	VehInfo[vehid][Owner] = Name(playerid);
	SaveVehicles();
	return 1;
}
CMD:veh(playerid,params[] )
{
	new vehid, color1,color2;
    if(IsAdmin(playerid)<= 3 ) return true;
    if(sscanf(params,"ddd",vehid,color1,color2)) return SCM(playerid,0,"Введите /veh [id машины] [цвет1] [цвет2]");
    if(vehid > 611 && vehid < 400) return SCM(playerid,0,"ID не может быть больше 611 и меньше 400!");
  	new Float:X,Float:Y,Float:Z,Float:ang;
	GetPlayerPos(playerid, X,Y,Z);
	GetPlayerFacingAngle(playerid,ang);
	new addvehid = AddVehicle(vehid,X,Y,Z,ang,color1,color2,0,0);
	PutPlayerInVehicle(playerid, addvehid, 0);
	return 1;
}
CMD:hp(playerid,params[] )
{
	if(IsAdmin(playerid)<3) return 1;
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehid = GetPlayerVehicleID(playerid);
	    SetVehicleHealth(vehid,1000.0);
    	RepairVehicle(vehid);
	}
	SetPlayerHealth(playerid,100.0);

	return 1;
}
CMD:refill(playerid,params[] )
{
    if(IsAdmin(playerid)<= 2 ) return true;
	new carid = GetPlayerVehicleID(playerid);
	SetVehicleFuel(carid,GetVehicleFuelTank(carid));
	return 1;
}
CMD:spveh(playerid,params[])
{
	if(IsAdmin(playerid)<4) return 1;
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,0,"Вы должены находится в машине!");
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	return 1;
}
CMD:dv(playerid,params[] )
{
    if(IsAdmin(playerid)<= 3 ) return true;
    new carid = GetPlayerVehicleID(playerid);
    DestroyVehicle(carid);
	return 1;
}
CMD:dav(playerid,params[])
{
	if(IsAdmin(playerid)<3) return true;
	new cmdstr[128];
	new startcount = GetTickCount();
	new ammount = 0;
	for(new vehid = 0; vehid< sizeof(VehInfo); vehid++)
	{
	    if(VehInfo[vehid][Temp] == true)
		{
			DestroyVehicle(vehid);
			ammount++;
		}
	}
	format(cmdstr,sizeof(cmdstr),"Успешно удаленно %d автомобилей! (%d ms)",ammount,GetTickCount()-startcount);
	SCM(playerid,1,cmdstr);
	return 1;
}
alias:dav("dc");

CMD:aveh(playerid,params[] )
{
    if(IsAdmin(playerid)<= 3 ) return true;
    new vehid = 0;
    if(sscanf(params,"%d",vehid)) return SCM(playerid,0,"Введите /aveh [id]");
    if(vehid < 400 || vehid > 611) return SCM(playerid,0,"Нельзя меньше 411 и больше 600!");
  	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	new carid = AddVehicle(vehid, X,Y,Z, 0.0, 1, 1, 1,1);
	PutPlayerInVehicle(playerid, carid, 0);
	return 1;
}
CMD:setskin(playerid,params[] )
{
	new targetid,skinid;
	if(IsAdmin(playerid)<= 3 ) return true;
	if(sscanf(params,"ud",targetid,skinid)) return SCM(playerid,0,"Введите /setskin [id] [id скина]");
	if(skinid > 311 && skinid < 2) return SCM(playerid,0,"ID скина не может быть больше 311 и меньше 2!");
	SetPlayerSkin(targetid,skinid);
	PlayerInfo[targetid][pSkin] = skinid;
	return 1;
}
CMD:skin(playerid,params[] )
{
    new skinid;
	if(IsAdmin(playerid)<= 3 ) return true;
	if(sscanf(params,"d",skinid)) return SCM(playerid,0,"Введите /skin [id скина]");
	if(skinid > 311 && skinid < 2) return SCM(playerid,0,"ID скина не может быть больше 311 и меньше 2!");
	SetPlayerSkin(playerid,skinid);
	PlayerInfo[playerid][pSkin] = skinid;
	return 1;
}
CMD:restart(playerid,params[])
{
	if(IsAdmin(playerid)<4) return 1;
	SendRconCommand("password resTarT322");
	SaveAllPlayers();
	SACM(2,"Через 5 секунд произойдет рестарт сервера! Все аккаунты были успешно сохранены!");
	SetTimer("Restart",5000,false);
	/*foreach(new pl: Player)
	{
	    SCM(pl,2,"Происходит рестарт сервера! Вы были кикнуты для предотвращения сбоя информации!");
	    KickEx(pl);
	}*/
	return 1;
}
CMD:gmx(playerid, params[] )
{
    if(IsAdmin(playerid)<= 4 ) return true;
	//format(cmdstr, sizeof(cmdstr), "~b~RESTART");
	SendRconCommand("gmx");
	return true;
}
//==============================================================================================================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new loadtime = GetTickCount();
	SetPVarInt(playerid,"TimeLoadEV",loadtime);
	
	new cmdstr[128];
	SetPVarInt(playerid,"IsEnterV",1);
    if(!PlayerLoggedIn[playerid] )
	{
	    SCM(playerid,2,"Для начала авторизуйтесь!");
		KickEx(playerid);
		return 1;
	}
	//new Float:pos[3];
	new Float:new_posX,Float:new_posY,Float:new_posZ;
	GetPlayerPos(playerid,new_posX,new_posY,new_posZ);
	if(GetPlayerDistanceFromPoint(playerid, VehInfo[vehicleid][posX], VehInfo[vehicleid][posY], VehInfo[vehicleid][posZ]) > 15)
	{
	    if(!GetVehicleDriver(vehicleid))
	    {
		    printf("POS PLAYER: %f",new_posX);
		    printf("POS CAR: %f",VehInfo[vehicleid][posX]);
		    printf("CARID: %d",vehicleid);
			SCA(playerid,3,0);
		}
		//SetVehiclePos(vehicleid,VehInfo[vehicleid][posX],VehInfo[vehicleid][posY],VehInfo[vehicleid][posZ]);
	}
	if(GetPVarInt(playerid,"vehicleid") != 0) SCA(playerid,1,0);
	SetPVarInt(playerid,"ispassenger",ispassenger);
	//SetPVarInt(playerid,"vehicleid",vehicleid);
	printf("Time load public OnPlayerEnterVehicle = %d",loadtime);
	format(cmdstr,sizeof(cmdstr),"Time load public OnPlayerEnterVehicle = %d",loadtime);
	SCMA(cmdstr);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new loadtime = GetTickCount();
    //printf("Time load public OnPlayerStateChange = %d\nCurrent newSTATE = %d and oldSTATE = %d",loadtime,newstate,oldstate);
	//format(cmdstr,sizeof(cmdstr),"Time load public OnPlayerStateChange = %d\nCurrent newSTATE = %d and oldSTATE = %d",loadtime,newstate,oldstate);
	//SCMA(cmdstr);
	new cmdstr[128];
	
	if((newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER) && oldstate == PLAYER_STATE_ONFOOT)
	{
		if(GetPVarInt(playerid,"IsEnterV") == 0) SCA(playerid,1,0);
		if(loadtime - GetPVarInt(playerid,"TimeLoadEV") < 500) SCA(playerid,1,0);
		SetPVarInt(playerid,"vehicleid",GetPlayerVehicleID(playerid));
		if(GetPVarInt(playerid,"ispassenger") == 0 )
		{
			for(new i = 0; i<sizeof(SpeedoDraw); i++) PlayerTextDrawShow(playerid, SpeedoDraw[i][playerid]);
	    	//printf("%d",sizeof(SpeedoDraw));
	    	SCM(playerid,1,"ВЫЗОВ STATE CHANGE");
	    	format(cmdstr,sizeof(cmdstr),"Для того что бы завести/заглушить двигатель нажмите клавишу {FF0000}'SPACE+Y'");
		    SCM(playerid,1,cmdstr);
	    	format(cmdstr,sizeof(cmdstr),"Для того что бы включить/выключить фары нажмите клавишу {FF0000}'SPACE+N'");
		    SCM(playerid,1,cmdstr);
			if(PlayerInfo[playerid][pDriveLic] == 0)
			{
		    	SCM(playerid,1,"У вас нет прав на вождение Т.С категории B! Езда без прав преследуется по закону!");
			}
		}
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
	    for(new i = 0; i<sizeof(SpeedoDraw); i++) PlayerTextDrawHide(playerid, SpeedoDraw[i][playerid]);
	    new vehicleid = GetPVarInt(playerid,"vehicleid");
		GetPlayerPos(playerid,VehInfo[vehicleid][posX],VehInfo[vehicleid][posY],VehInfo[vehicleid][posZ]);
		GetVehicleZAngle(vehicleid,VehInfo[vehicleid][angleZ]);
		DeletePVar(playerid,"vehicleid");
		DeletePVar(playerid,"IsEnterV");
		DeletePVar(playerid,"ispassenger");
	}
	/*if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) //if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Игрок сел на место водителя
	{
    	
	}*/
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == mayor[0])
	{
		SetPlayerPos(playerid,2838.3684,2927.2964,2034.6959);
		SetPlayerFacingAngle(playerid,82.6381);
	}
	else if(pickupid == mayor[1]) SetPlayerPos(playerid,1481.3043,-1768.6271,18.7958);
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    return 1;
}
public OnPlayerClickTextDraw(playerid,Text:clickedid)
{
	if(clickedid == TextDraw[9]) //Пароль
	{
	    SPD(playerid,1,1,"Регистрация","Укажите пароль:","Ок","Выход");
	}
	if(clickedid == TextDraw[12])
	{
	    SPD(playerid,3,1,"Электронная почта","Вводите только действующий E-mail адрес!","Далее","Выход");
	}
	
	//================================================================SEX=============================================================
	if(clickedid == TextDraw[18] && PlayerInfo[playerid][pSex] == 1)
	{
	    PlayerInfo[playerid][pSex] = 2;
	    PlayerTextDrawSetString(playerid,TextSex[playerid],RusToGame("Женский"));
	}
	else if(clickedid == TextDraw[18] && PlayerInfo[playerid][pSex] == 2)
	{
	    PlayerInfo[playerid][pSex] = 1;
	    PlayerTextDrawSetString(playerid,TextSex[playerid],RusToGame("Мужской"));
	}
	
	//=====================================================Выбор расы==================================================
	if(clickedid == TextDraw[20] && PlayerInfo[playerid][pRace] == 1)
	{
	    PlayerInfo[playerid][pRace] = 2;
	    PlayerTextDrawSetString(playerid,TextRace[playerid],RusToGame("Европеец"));
	}
	else if(clickedid == TextDraw[20] && PlayerInfo[playerid][pRace] == 2)
	{
	    PlayerInfo[playerid][pRace] = 3;
	    PlayerTextDrawSetString(playerid,TextRace[playerid],RusToGame("Азиат"));
	}
	else if(clickedid == TextDraw[20] && PlayerInfo[playerid][pRace] == 3)
	{
	    PlayerInfo[playerid][pRace] = 1;
	    PlayerTextDrawSetString(playerid,TextRace[playerid],RusToGame("Афроамериканец"));
	}
	//======================================================================Story============================================
	if(clickedid == TextDraw[41])
	{
	    PlayerTextDrawSetString(playerid,history[1][playerid],RusToGame("Вы - бывший бандит с богатым"));
		PlayerTextDrawSetString(playerid,history[2][playerid],RusToGame("криминальным прошлым."));
		PlayerTextDrawSetString(playerid,history[3][playerid],RusToGame("После долгих лет преследований"));
		PlayerTextDrawSetString(playerid,history[4][playerid],RusToGame("вас все же посадили. Спустя"));
		PlayerTextDrawSetString(playerid,history[5][playerid],RusToGame("некоторое время, переводом"));
		PlayerTextDrawSetString(playerid,history[6][playerid],RusToGame("попав в тюрьму этого штата,"));
		PlayerTextDrawSetString(playerid,history[7][playerid],RusToGame("вы были досрочно освобождены."));

		for(new i = 1; i < sizeof(history); i++)
		{
		    PlayerTextDrawShow(playerid,history[i][playerid]);
		}
		PlayerInfo[playerid][pStory] = 1;
	}
	if(clickedid == TextDraw[44])
	{
	    for(new i = 1; i < sizeof(history); i++)
		{
		    PlayerTextDrawHide(playerid,history[i][playerid]);
		}
		
	    PlayerTextDrawSetString(playerid,history[1][playerid],RusToGame("Вы - бывший успешный гос.рабочий"));
		PlayerTextDrawSetString(playerid,history[2][playerid],RusToGame("с огромным состоянием, но"));
		PlayerTextDrawSetString(playerid,history[3][playerid],RusToGame("после проблем с местной мафией,"));
		PlayerTextDrawSetString(playerid,history[4][playerid],RusToGame("потеряв все свое имущество,"));
		PlayerTextDrawSetString(playerid,history[5][playerid],RusToGame("не считая некоторых вещей."));
		PlayerTextDrawSetString(playerid,history[6][playerid],RusToGame("Вы переехали в новый штат"));
		PlayerTextDrawSetString(playerid,history[7][playerid],RusToGame("и начали все с самого начала."));

		for(new i = 1; i < sizeof(history); i++)
		{
		    PlayerTextDrawShow(playerid,history[i][playerid]);
		}
		PlayerInfo[playerid][pStory] = 2;
	
	}
	if(clickedid == TextDraw[46])
	{
	    for(new i = 1; i < sizeof(history); i++)
		{
		    PlayerTextDrawHide(playerid,history[i][playerid]);
		}

	    PlayerTextDrawSetString(playerid,history[1][playerid],RusToGame("Вы - местный житель."));
		PlayerTextDrawSetString(playerid,history[2][playerid],RusToGame("Вы родились здесь и ведёте"));
		PlayerTextDrawSetString(playerid,history[3][playerid],RusToGame("спокойный и размеренный образ"));
		PlayerTextDrawSetString(playerid,history[4][playerid],RusToGame("жизни. Эта рутина вам надоела"));
		PlayerTextDrawSetString(playerid,history[5][playerid],RusToGame("и вы решили изменить всю"));
		PlayerTextDrawSetString(playerid,history[6][playerid],RusToGame("вашу жизнь,покинув близких."));
		PlayerTextDrawSetString(playerid,history[7][playerid],RusToGame("Вы отправились в поиски..."));

		for(new i = 1; i < sizeof(history); i++)
		{
		    PlayerTextDrawShow(playerid,history[i][playerid]);
		}
		PlayerInfo[playerid][pStory] = 3;
	}
	if(clickedid == TextDraw[51])
	{
	    if(!strlen(PlayerInfo[playerid][pPassword]) || PlayerInfo[playerid][pStory] == 0 || PlayerInfo[playerid][pSex] == 0 || PlayerInfo[playerid][pRace] == 0 || !strlen(PlayerInfo[playerid][pMail]) ) return SPD(playerid,1212,0,"Ошибка!","Вы не заполнили все поля!","Ок","");
	    CancelSelectTextDraw(playerid);
		RegEnd(playerid);
	}
	return 0;
}
public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    /*new Menu:Current = GetPlayerMenu(playerid);
	if(!IsValidMenu(Current)) return true;
	ShowMenuForPlayer(Current, playerid);
	TogglePlayerControllable(playerid,0);*/
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_FIRE)
    {
		if(GetPlayerWeapon(playerid) != 0)return 1;
		if(GetPVarInt(playerid,"firepower") == 0)return 1;
		if(IsPlayerInAnyVehicle(playerid))return 1;
		new Float:pX, Float: pY, Float: pZ, Float:fA, Float: peX, Float: peY, Float: dist;
		dist = 10.0;
		GetPlayerPos(playerid,pX,pY,pZ);
		GetPlayerFacingAngle(playerid,fA);

		GetXYInFrontOfPoint(pX, pY, peX, peY, fA, dist);
    	CreateExplosion(peX,peY,pZ,Explosion_Type,Explosion_Rad);
		//Timer[playerid] = SetTimerEx("Fireman",FIRE_TIMER_INTERVAL,1,"d",playerid);
		//S[playerid] = 0;
		//Fires[playerid] --;
		PlayerPlaySound(playerid,FIRE_POWER_SOUND,0,0,0);

    }
	if(PRESSED(8))
	{
		if(IsPlayerInAnyVehicle(playerid) && VehInfo[GetPlayerVehicleID(playerid)][Engine] == 1) SetPVarInt(playerid,"forwardDrive",1);
	}
	if(RELEASED(8))
	{
	    if(IsPlayerInAnyVehicle(playerid) && VehInfo[GetPlayerVehicleID(playerid)][Engine] == 1) SetPVarInt(playerid,"forwardDrive",0);
	}
	if(PRESSED(KEY_HANDBRAKE | KEY_YES) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	}
    if(RELEASED(KEY_HANDBRAKE | KEY_YES) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		EngineCheck(playerid);
	}
	if(RELEASED(KEY_HANDBRAKE | KEY_NO) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    //CallLocalFunction("OnPlayerCommandText", "is", playerid, "/lights");
	   callcmd::lights(playerid, "");
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}

    if(GetPVarInt(playerid, "AFK") > 0) return SetPVarInt(playerid, "AFK", 0);
    if(GetPVarInt(playerid,"vehicleid") > 0 && GetPVarInt(playerid,"ispassenger")==0) SpeedometrUPD(playerid);
    if(IsPlayerInAnyVehicle(playerid))
	{
        if(GetPlayerVehicleID(playerid) != GetPVarInt(playerid,"vehicleid"))
		{
            SetPVarInt(playerid,"vehicleid",0);
            SCA(playerid,3,0);
		}
	}
	/*new Float:hpval;
    GetPlayerHealth(playerid,hpval);
    if(GetPlayerAnimationIndex(playerid) == 1130 && GetPVarInt(playerid, "CheckFall") == 0) SetPVarFloat(playerid, "SavePlayerHp", hpval), SetPVarInt(playerid, "CheckFall", 1);
    if(GetPlayerAnimationIndex(playerid) == 1208 && GetPVarInt(playerid, "CheckFall") == 1)
 	{
	    if(hpval == GetPVarFloat(playerid, "SavePlayerHp")) SCA(playerid,7,0),SetPVarInt(playerid, "CheckFall", 0);
	    else SetPVarInt(playerid, "CheckFall", 0);
    }*/
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	
	if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) > 15)
	{
			SCA(playerid,3,0);
			SetVehiclePos(vehicleid,VehInfo[vehicleid][posX],VehInfo[vehicleid][posY],VehInfo[vehicleid][posZ]);
			return 0;
	}
	else
	{
	    VehInfo[vehicleid][posX] = new_x;
	    VehInfo[vehicleid][posY] = new_y;
	    VehInfo[vehicleid][posZ] = new_z;
	    return 1;
	    
	}
    // Check if it moved far
    /*if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) > 50)
    {
        // Reject the update
        return 0;
    }*/
    
}
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	if(!GetVehicleDriver(vehicleid))
	{
	    if(VehInfo[vehicleid][Engine]) SetVehicleEngineState(vehicleid,1);
		else SetVehicleEngineState(vehicleid,0);
		if(VehInfo[vehicleid][Light]) SetVehicleLightsState(vehicleid,1);
		else SetVehicleLightsState(vehicleid,0);
		SetVehiclePos(vehicleid,VehInfo[vehicleid][posX],VehInfo[vehicleid][posY],VehInfo[vehicleid][posZ]);
	}

	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{

	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new cmdstr[128];
	//new name[MAX_PLAYER_NAME];
    //GetPlayerName(playerid, name, sizeof(name));
	switch(dialogid)
	{
	    case dRegister: //Регистрация пароль!
	    {
			if(!response) return KickEx(playerid); //Нажатие кнопки выйти
			if(!strlen(inputtext))return SPD(playerid, 1, 1, "Регистрация","{FF0000}Ошибка регистрации: Поле 'Пароль' не может быть пустым\n\nУкажите пароль", "Ок", "Выйти"); //Проверка указан ли пароль
			if(strlen(inputtext)>20 || strlen(inputtext)<4)return SPD(playerid, 1, 1, "Регистрация","{FF0000}Ошибка регистрации: Поле 'Пароль' не может быть больше 20 и меньше 4 символов\n\nУкажите пароль", "Ок", "Выйти"); //Проверка указан ли пароль больше 20 символов и меньше 4
			if(!IsOnlyText(inputtext)) return SPD(playerid, 1, 1, "Регистрация","{FF0000}Ошибка регистрации: В поле 'Пароль' можно вводить только латинские буквы и цифры! \n\nУкажите пароль", "Ок", "Выйти"); //Только буквы и цифры
			format(PlayerInfo[playerid][pPassword],20,inputtext);
			PlayerInfo[playerid][pName] = Name(playerid);
			PlayerTextDrawSetString(playerid,TextPass[playerid],inputtext);
	    }
		case dAuth: //Авторизация
	    {
	        if(!response) return KickEx(playerid); //Нажатие кнопки выйти
	        if(!strlen(inputtext))return SPD(playerid, 2, 3, "Авторизация","{FF0000}Ошибка авторизации: Поле 'Пароль' не может быть пустым\n\nУкажите пароль", "Войти", "Выйти"); //Проверка указан ли пароль
	        if(strlen(inputtext)>20 || strlen(inputtext)<4 )return SPD(playerid, 2, 3, "Авторизация","{FF0000}Ошибка авторизации: Поле 'Пароль' не может быть больше 20 и меньше 4 символов\n\nУкажите пароль", "Войти", "Выйти"); //Проверка указан ли пароль меньше 20 символов
            if(!IsOnlyText(inputtext)) return SPD(playerid, 2, 3, "Регистрация","{FF0000}Ошибка регистрации: В поле 'Пароль' можно вводить только латинские буквы и цифры! \n\nУкажите пароль", "Ок", "Выйти"); //Только буквы и цифры
			//new str[100];
			//new result[500];
			if(!strcmp(PlayerInfo[playerid][pPassword],inputtext,false))
			{
			    new plName[MAX_PLAYER_NAME+2],query_string[128];
				GetPlayerName(playerid,plName,sizeof(plName));
				mysql_escape_string(Name(playerid),plName);
				format(query_string,sizeof(query_string),"SELECT * FROM `players` WHERE `pName` = '%s'",plName);
	            mysql_tquery(mysql_connect_ID, query_string, "UploadPlayerAccount","i", playerid);
			    //UploadPlayerAccount(playerid);
			}
			else
			{
			    SPD(playerid, 2, 3, "Авторизация","{FF0000}Ошибка авторизации: Неверный пароль\n\nУкажите пароль", "Войти", "Выйти"); //Верный ли пароль
			}
	    }
	    case dSaveMail://Сохранение мыла
	    {
			if(!response) return KickEx(playerid);//Exit
			if(!strlen(inputtext)) return SPD(playerid,3,1,"Электронная почта","{FF0000}Поле не должно быть пустым!\n\n Введите действующий E-mail:","Далее","Выход");//
			if(strlen(inputtext)> 50 || strlen(inputtext) < 8) return SPD(playerid,3,1,"Электронная почта","{FF0000}E-mail не может быть длиннее 50 и короче 8 символов !\n\n Введите действующий E-mail:","Далее","Выход");
			if(!IsEmail(inputtext)) return SPD(playerid,3,1,"Электронная почта","{FF0000}E-mail может содержать только латинские буквы, цифры и знаки (@ . - _) !\n\n Введите действующий E-mail:","Далее","Выход");
			format(PlayerInfo[playerid][pMail],50,inputtext); 
			PlayerTextDrawSetString(playerid,TextMail[playerid],inputtext);
	    }

		case dAdminAuth:
		{

			if(!response) return KickEx(playerid);//Exit
			if(strlen(inputtext) == 0) return SPD(playerid,4,DIALOG_STYLE_INPUT,"Доступ к администрированию","Введите ваш админ. пароль в поле ниже для авторизации","Далее","");
		    if(strcmp(PlayerInfo[playerid][pAdminCode],inputtext,false)) return KickEx(playerid);
		    SetPVarInt(playerid,"adminacces",1);
		    SCM(playerid,1,"Вы успешно авторизовались!");
		}
	    case dGiveLic:
	    {
			new pl = GetPVarInt(playerid,"player");
	        switch(listitem)
	        {
				case 0:
				{
				    format(cmdstr,sizeof(cmdstr),"Вы выдали лицензию на вождение игроку %s",Name(pl));
				    SCM(playerid,1,cmdstr);
					PlayerInfo[pl][pDriveLic] = 1;
					SCM(pl,1,"Администратор выдал вам права категории 'B'");
					DeletePVar(playerid, "player");
				}
				case 1:
				{
				    format(cmdstr,sizeof(cmdstr),"Вы выдали лицензию на оружее игроку %s",Name(pl));
				    SCM(playerid,1,cmdstr);
					PlayerInfo[pl][pGunLic] = 1;
					SCM(pl,1,"Администратор выдал вам лицензию на ношение оружия");
					DeletePVar(playerid, "player");
				}
	        }
	    }
		case dAdminTP:
		{
			if(listitem == 0)//Аэропорт
			{
				SetPlayerPos(playerid, 1682.9122,-2243.4753,13.5413);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 180);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 1)//Мэрия Крыша
			{
				SetPlayerPos(playerid, 1480.5674,-1752.7410,33.4297);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 0);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 2)//АвтоШкола
			{
				SetPlayerPos(playerid, 2248.4153,-1344.7151,30.7700);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 90);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 3)//Grove
			{
				SetPlayerPos(playerid, 2529.3967,-1678.0203,19.9302);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 90);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 4)//Ballas
			{
				SetPlayerPos(playerid, 1987.0020,-1114.5956,35.6250);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 180);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 5)//СМИ
			{
				SetPlayerPos(playerid, 1631.8677,-1660.3877,22.5156);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 240);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 6)//Банк
			{
				SetPlayerPos(playerid, 1213.2982,-1205.3108,1201.0859);
				SetPlayerInterior(playerid,2);
				SetPlayerFacingAngle(playerid, 0);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 7)//Мэрия
			{
				SetPlayerPos(playerid, 1479.9113,-1739.8586,13.5469);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 0);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 8)//Школа вождения
			{
				return 1;
			}
			if(listitem == 9)//Школа вождения
			{
				SetPlayerPos(playerid, 2254.7629,-1341.7815,23.9879);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 90);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 10) //МЭрия
			{
				SetPlayerPos(playerid, 1468.5125,-1726.4117,1052.049);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 90);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 11) //Ammo
			{
				SetPlayerPos(playerid, 1397.5310,-1217.7510,1353.1200);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 0);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 12) //Магазин Одежды
			{
				SetPlayerPos(playerid, 895.6147,-1096.5537,1501.0909);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 270);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 13) //СМИ
			{
				SetPlayerPos(playerid, 1742.1470,-1251.2256,1501.0859);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 0);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 14) //Больница
			{
				SetPlayerPos(playerid, 1396.9728,-64.9197,1617.5289);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 90);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 15) //Grove
			{
				SetPlayerPos(playerid, 2478.7141,-1725.1154,2954.0259);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 230);
				SetCameraBehindPlayer(playerid);
			}
			if(listitem == 16) //Ballas
			{
				SetPlayerPos(playerid, 1961.7267,-1139.3711,2501.0859);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 270);
				SetCameraBehindPlayer(playerid);
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(IsAdmin(playerid)<2) return 1;
    SetPlayerPos(playerid, fX, fY, fZ);//FindZ
    return 1;
}

/*public SkinMenu()
{
     SelectRegSkin = CreateMenu("Race", 1, 50.0, 160.0, 100.0);
	 SetMenuColumnHeader(SelectRegSkin, 0, "Choose Race");
	 AddMenuItem(SelectRegSkin, 0, "Negroid");
	 AddMenuItem(SelectRegSkin, 0, "Europioid");
	 AddMenuItem(SelectRegSkin, 0, "Azian");
	 AddMenuItem(SelectRegSkin, 0 , "Select");
}*/
ResetPlayerVars(playerid)
{
	firstspawn[playerid] = 0;
	PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pRace] = 0;
	PlayerInfo[playerid][pPassword] = 0;
	PlayerInfo[playerid][pMail] = 0;
	PlayerInfo[playerid][pSex] = 0;
	PlayerInfo[playerid][pDriveLic] = 0;
	PlayerInfo[playerid][pGunLic] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pAdminCode] = 0;
	PlayerInfo[playerid][pStory] = 0;
	PlayerInfo[playerid][pMoney] = 0;
	PlayerInfo[playerid][pDeagleSkill] = 0;
	PlayerInfo[playerid][pLatchkey] = 0;
	PlayerInfo[playerid][pHealth] = 0;
	PlayerInfo[playerid][pArmour] = 0;
	
	for(new i = 0; i< 13; i++)
	{
	    PlayerWeapon[playerid][pAmmo][i] = 0;
	    PlayerWeapon[playerid][pWeapon][i] = 0;
	}
	
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
	
}

ProxDetector(Float: radi, playerid, ptext[], col1, col2, col3, col4, col5)
{
    new Float: Radius;
    //new Float: pPos[3];
    new Float:pX,Float:pY,Float:pZ;
    GetPlayerPos(playerid,pX,pY,pZ);
    SCM(playerid, col1, ptext);
    foreach(new i: Player)
    {
        Radius = GetPlayerDistanceFromPoint(i, pX,pY,pZ);
        if(playerid == i || PlayerLoggedIn[i] == false || Radius > radi || GetPlayerInterior(playerid) != GetPlayerInterior(i) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(i)) continue;
        if (Radius < radi / 16) SCM(i, col1, ptext);
        else if(Radius < radi / 8) SCM(i, col2, ptext);
        else if(Radius < radi / 4) SCM(i, col3, ptext);
        else if(Radius < radi / 4) SCM(i, col4, ptext);
        else if(Radius < radi / 2) SCM(i, col5, ptext);

    }
    return 1;
}

IsRPNick(playerid)
{
	if(strlen(Name(playerid))>MAX_PLAYER_NAME) return 0;
	new plname[MAX_PLAYER_NAME+2];
	plname = Name(playerid);
	//GetPlayerName(playerid, plname, MAX_PLAYER_NAME);
	for(new i=0;i<strlen(plname);i++)
	{
		if( !((plname[i]>='a'&&plname[i]<='z') || (plname[i]>='A'&&plname[i]<='Z') || plname[i]=='_') )
		{
			return 0; // недопустимые символы в нике
		}
	}
	new d = strfind(plname, "_");
	if( d==-1 ) return 0;   // нет _ в нике
	if(strfind(plname, "_", false, d+1) != -1) return 0; // больше одного _ в нике
	new name[10];
	strmid(name, plname, 0, d, sizeof name);
	new surname[10];
	strmid(surname, plname, d+1, strlen(plname), sizeof surname);
	if(strlen(name)<3 || strlen(name)>9) return 0;  // неверная длина имени
	if(strlen(surname)<3 || strlen(surname)>9) return 0;    // неверная длина фамилии
	if(!(name[0]>='A' && name[0]<='Z')) return 0;   // первая буква имени не заглавная
	if(!(surname[0]>='A' && surname[0]<='Z')) return 0; // первая буква фамилии не заглавная
	for(new i=1;i<strlen(name);i++)
	{
		if(!(name[i]>='a'&&name[i]<='z')) return 0; // неверные буквы в имени
	}
	for(new i=1;i<strlen(surname);i++)
	{
		if(!(surname[i]>='a'&&surname[i]<='z')) return 0;   // неверные буквы в фамилии
	}
	return 1;   // все ok
}
SetVehicleFuel(vehicleid,ammount)
{
	VehInfo[vehicleid][Fuel] = ammount;
	return 1;
}
GetVehicleFuelTank(vehicleid)
{
	new MaxFuel;
	switch(GetVehicleModel(vehicleid))
	{
		case 400: MaxFuel = 93; case 500: MaxFuel = 67;
		case 401: MaxFuel = 54; //501//
		case 402: MaxFuel = 41; case 502: MaxFuel = 79;
		case 403: MaxFuel = 215; case 503: MaxFuel = 79;
		case 404: MaxFuel = 65; case 504: MaxFuel = 68;
		case 405: MaxFuel = 52; case 505: MaxFuel = 98;
		case 406: MaxFuel = 400; case 506: MaxFuel = 54;
		case 407: MaxFuel = 150; case 507: MaxFuel = 78;
		case 408: MaxFuel = 163; case 508: MaxFuel = 120;
		case 409: MaxFuel = 90; //509//
		case 410: MaxFuel = 45; //510//
		case 411: MaxFuel = 67; case 511: MaxFuel = 560;
		case 412: MaxFuel = 55; case 512: MaxFuel = 335;
		case 413: MaxFuel = 120; case 513: MaxFuel = 320;
		case 414: MaxFuel = 130; case 514: MaxFuel = 350;
		case 415: MaxFuel = 70; case 515: MaxFuel = 390;
		case 416: MaxFuel = 95; case 516: MaxFuel = 69;
		case 417: MaxFuel = 700; case 517: MaxFuel = 40;
		case 418: MaxFuel = 115; case 518: MaxFuel = 49;
		case 419: MaxFuel = 60; case 519: MaxFuel = 605;
		case 420: MaxFuel = 53; case 520: MaxFuel = 545;
		case 421: MaxFuel = 68; case 521: MaxFuel = 35;
		case 422: MaxFuel = 95; case 522: MaxFuel = 45;
		case 423: MaxFuel = 110; case 523: MaxFuel = 34;
		case 424: MaxFuel = 35; case 524: MaxFuel = 197;
		case 425: MaxFuel = 850; case 525: MaxFuel = 89;
		case 426: MaxFuel = 53; case 526: MaxFuel = 58;
		case 427: MaxFuel = 105; case 527: MaxFuel = 45;
		case 428: MaxFuel = 110; case 528: MaxFuel = 89;
		case 429: MaxFuel = 43; case 529: MaxFuel = 54;
		case 430: MaxFuel = 200; case 530: MaxFuel = 30;
		case 431: MaxFuel = 98; case 531: MaxFuel = 80;
		case 432: MaxFuel = 300; case 532: MaxFuel = 175;
		case 433: MaxFuel = 190; case 533: MaxFuel = 54;
		case 434: MaxFuel = 54; case 534: MaxFuel = 45;
		case 436: MaxFuel = 39; case 535: MaxFuel = 65;
		case 437: MaxFuel = 200; case 536: MaxFuel = 51;
		case 438: MaxFuel = 67; case 537: MaxFuel = 390;
		case 439: MaxFuel = 54; case 538: MaxFuel = 405;
		case 440: MaxFuel = 89; case 539: MaxFuel = 30;
		case 442: MaxFuel = 76; case 540: MaxFuel = 65;
		case 443: MaxFuel = 345; case 541: MaxFuel = 51;
		case 444: MaxFuel = 150; case 542: MaxFuel = 39;
		case 445: MaxFuel = 68; case 543: MaxFuel = 78;
		case 446: MaxFuel = 430; case 544: MaxFuel = 130;
		case 447: MaxFuel = 400; case 545: MaxFuel = 56;
		case 448: MaxFuel = 20; case 546: MaxFuel = 63;
		case 451: MaxFuel = 65; case 547: MaxFuel = 67;
		case 452: MaxFuel = 330; case 548: MaxFuel = 495;
		case 453: MaxFuel = 430; case 549: MaxFuel = 38;
		case 454: MaxFuel = 450; case 550: MaxFuel = 62;
		case 455: MaxFuel = 230; case 551: MaxFuel = 59;
		case 456: MaxFuel = 156; case 552: MaxFuel = 79;
		case 457: MaxFuel = 30; case 553: MaxFuel = 715;
		case 458: MaxFuel = 76; case 554: MaxFuel = 105;
		case 459: MaxFuel = 87; case 555: MaxFuel = 42;
		case 460: MaxFuel = 350; case 556: MaxFuel = 160;
		case 461: MaxFuel = 32; case 557: MaxFuel = 160;
		case 462: MaxFuel = 20; case 558: MaxFuel = 51;
		case 463: MaxFuel = 34; case 559: MaxFuel = 54;
		case 466: MaxFuel = 54; case 560: MaxFuel = 62;
		case 467: MaxFuel = 56; case 561: MaxFuel = 70;
		case 468: MaxFuel = 27; case 562: MaxFuel = 56;
		case 469: MaxFuel = 205; case 563: MaxFuel = 335;
		case 470: MaxFuel = 87; //564//
		case 471: MaxFuel = 31; case 565: MaxFuel = 57;
		case 472: MaxFuel = 235; case 566: MaxFuel = 64;
		case 473: MaxFuel = 120; case 567: MaxFuel = 54;
		case 474: MaxFuel = 69; case 568: MaxFuel = 31;
		case 475: MaxFuel = 64; //569//
		case 476: MaxFuel = 340; //570//
		case 477: MaxFuel = 45; case 571: MaxFuel = 20;
		case 478: MaxFuel = 79; case 572: MaxFuel = 30;
		case 479: MaxFuel = 78; case 573: MaxFuel = 280;
		case 480: MaxFuel = 56; case 574: MaxFuel = 53;
		case 482: MaxFuel = 100; case 575: MaxFuel = 49;
		case 483: MaxFuel = 83; case 576: MaxFuel = 65;
		case 484: MaxFuel = 470; case 577: MaxFuel = 800;
		case 485: MaxFuel = 50; case 578: MaxFuel = 105;
		case 486: MaxFuel = 114; case 579: MaxFuel = 105;
		case 487: MaxFuel = 335; case 580: MaxFuel = 68;
		case 488: MaxFuel = 215; case 581: MaxFuel = 29;
		case 489: MaxFuel = 98; case 582: MaxFuel = 120;
		case 490: MaxFuel = 91; case 583: MaxFuel = 30;
		case 491: MaxFuel = 56; //584//
		case 492: MaxFuel = 52; case 585: MaxFuel = 57;
		case 493: MaxFuel = 710; case 586: MaxFuel = 43;
		case 494: MaxFuel = 79; case 587: MaxFuel = 48;
		case 495: MaxFuel = 110; case 588: MaxFuel = 130;
		case 496: MaxFuel = 65; case 589: MaxFuel = 61;
		case 497: MaxFuel = 345; //590//
		case 498: MaxFuel = 130; //591//
		case 499: MaxFuel = 115; case 592: MaxFuel = 900;
		case 601: MaxFuel = 230; case 595: MaxFuel = 335;
		case 602: MaxFuel = 46; case 596: MaxFuel = 58;
		case 603: MaxFuel = 58; case 597: MaxFuel = 58;
		case 604: MaxFuel = 56; case 598: MaxFuel = 60;
		case 605: MaxFuel = 78; case 599: MaxFuel = 100;
		case 609: MaxFuel = 120;
		case 600: MaxFuel = 62;
		case 593: MaxFuel = 284;
		default: MaxFuel = 0;//Для остальных
	}
	return MaxFuel;//Возвращаем кол-во
}
setVehicleSpeed(vehicleid, speed_mph)
{
	if ( speed_mph < 1 ) speed_mph = 1;
	new Float: v[3], cur_speed_mph;
	GetVehicleVelocity( vehicleid, v[0], v[1], v[2] );
	//cur_speed_mph = floatround( 200.0 * floatsqroot( v[0]*v[0] + v[1]*v[1] + v[2]*v[2] ), floatround_floor );*/
	cur_speed_mph = GetVehicleSpeed(vehicleid);
	if ( cur_speed_mph <= 0 )
	{
		new Float: zAngle;
		GetVehicleZAngle( vehicleid, zAngle );

		new Float: newVelX = floatcos( (zAngle -= 270.0), degrees ) * speed_mph / 170.0;//200
		SetVehicleVelocity( vehicleid, newVelX, floattan(zAngle,degrees) * newVelX, 0.0 );

		//return 1;
	}

	new Float: vMultiplier = float(speed_mph) / float(cur_speed_mph);
	SetVehicleVelocity( vehicleid, v[0] * vMultiplier, v[1] * vMultiplier, v[2] * vMultiplier );
}
SetEngineState(vehicleid, set)
{
    switch(set)
    {
        case 1: VehInfo[vehicleid][Engine] = 1, SetVehicleEngineState(vehicleid, true);
        case 0: VehInfo[vehicleid][Engine] = 0, SetVehicleEngineState(vehicleid, false);
    }
}

ToggleEngineState(vid)
{
    new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(engine == VEHICLE_PARAMS_UNSET || engine == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective), VehInfo[vid][Engine] = 1;
	else SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective), VehInfo[vid][Engine] = 0;
}
ToggleLightState(vid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
 	GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(lights == VEHICLE_PARAMS_UNSET || lights == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective), VehInfo[vid][Light] = 1;
	else SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective), VehInfo[vid][Light] = 0;
}

SetLightState(vehicleid, set)
{
    switch(set)
    {
        case 1: VehInfo[vehicleid][Light] = 1, SetVehicleLightsState(vehicleid, true);
        case 0: VehInfo[vehicleid][Light] = 0, SetVehicleLightsState(vehicleid, false);
    }
}

GetVehicleSpeed(vehicleid)
{
	new Float: v[3], cur_speed_mph;
	GetVehicleVelocity( vehicleid, v[0], v[1], v[2] );
	cur_speed_mph = floatround( 100.0 * floatsqroot( v[0]*v[0] + v[1]*v[1] + v[2]*v[2] ), floatround_floor );
	return cur_speed_mph;
    /*new Float:st1,Float:st2,Float:st3;
    GetVehicleVelocity(vehicleid,st1,st2,st3);
    new Float:st4 = floatsqroot(floatpower(floatabs(st1), 2.0) + floatpower(floatabs(st2), 2.0) + floatpower(floatabs(st3), 2.0)) * 100.3;
    return floatround(st4);*/
}
GetPlayerSpeed(palyerid)
{
	new Float: v[3], cur_speed_mph;
	GetPlayerVelocity( palyerid, v[0], v[1], v[2] );
	cur_speed_mph = floatround( 100.0 * floatsqroot( v[0]*v[0] + v[1]*v[1] + v[2]*v[2] ), floatround_floor );
	return cur_speed_mph;
    /*new Float:st1,Float:st2,Float:st3;
    GetVehicleVelocity(vehicleid,st1,st2,st3);
    new Float:st4 = floatsqroot(floatpower(floatabs(st1), 2.0) + floatpower(floatabs(st2), 2.0) + floatpower(floatabs(st3), 2.0)) * 100.3;
    return floatround(st4);*/
}
stock SetPlayerToTeamColor(playerid)
{
	switch(PlayerInfo[playerid][pMember])
	{
		case 0:	SetPlayerColor(playerid, TEAM_HIT_COLOR);
		case 1: SetPlayerColor(playerid, 0x110CE7FF);
		default: SetPlayerColor(playerid, TEAM_HIT_COLOR);
	}
	return true;
}

RusToGame(string[])
{ 
    new result[MAX_STRING];
    for(new i;i<MAX_STRING;i++)
    { 
     switch(string[i]) 
     { 
      case 'а':result[i] = 'a'; 
      case 'А':result[i] = 'A'; 
      case 'б':result[i] = '—'; 
      case 'Б':result[i] = 'Ђ'; 
      case 'в':result[i] = 'ў'; 
      case 'В':result[i] = '‹'; 
      case 'г':result[i] = '™'; 
      case 'Г':result[i] = '‚'; 
      case 'д':result[i] = 'љ'; 
      case 'Д':result[i] = 'ѓ'; 
      case 'е':result[i] = 'e'; 
      case 'Е':result[i] = 'E'; 
      case 'ё':result[i] = 'e'; 
      case 'Ё':result[i] = 'E'; 
      case 'ж':result[i] = '›'; 
      case 'Ж':result[i] = '„'; 
      case 'з':result[i] = 'џ'; 
      case 'З':result[i] = '€'; 
      case 'и':result[i] = 'њ'; 
      case 'И':result[i] = '…'; 
      case 'й':result[i] = 'ќ'; 
      case 'Й':result[i] = '…'; 
      case 'к':result[i] = 'k'; 
      case 'К':result[i] = 'K'; 
      case 'л':result[i] = 'ћ'; 
      case 'Л':result[i] = '‡'; 
      case 'м':result[i] = 'Ї'; 
      case 'М':result[i] = 'M'; 
      case 'н':result[i] = '®'; 
      case 'Н':result[i] = 'H'; 
      case 'о':result[i] = 'o'; 
      case 'О':result[i] = 'O'; 
      case 'п':result[i] = 'Ј'; 
      case 'П':result[i] = 'Њ'; 
      case 'р':result[i] = 'p'; 
      case 'Р':result[i] = 'P'; 
      case 'с':result[i] = 'c'; 
      case 'С':result[i] = 'C'; 
      case 'т':result[i] = '¦'; 
      case 'Т':result[i] = 'Џ'; 
      case 'у':result[i] = 'y'; 
      case 'У':result[i] = 'Y'; 
      case 'ф':result[i] = 'Ѓ';
      case 'Ф':result[i] = '?';
      case 'х':result[i] = 'x'; 
      case 'Х':result[i] = 'X'; 
      case 'ц':result[i] = ' ';
      case 'Ц':result[i] = '‰';
      case 'ч':result[i] = '¤'; 
      case 'Ч':result[i] = 'Ќ'; 
      case 'ш':result[i] = 'Ґ'; 
      case 'Ш':result[i] = 'Ћ'; 
      case 'щ':result[i] = 'Ў'; 
      case 'Щ':result[i] = 'Љ'; 
      case 'ь':result[i] = '©'; 
      case 'Ь':result[i] = '’'; 
      case 'ъ':result[i] = 'ђ'; 
      case 'Ъ':result[i] = '§'; 
      case 'ы':result[i] = 'Ё'; 
      case 'Ы':result[i] = '‘'; 
      case 'э':result[i] = 'Є'; 
      case 'Э':result[i] = '“'; 
      case 'ю':result[i] = '«'; 
      case 'Ю':result[i] = '”'; 
      case 'я':result[i] = '¬'; 
      case 'Я':result[i] = '•'; 
      default:result[i]=string[i]; 
     } 
    } 
    return result; 
}
function GameTime()
{

// ===================================================================В кажом игровом часе ~15 реальных минут!
	gsecond++;
	if(gsecond == 60 && gminute < 61)
	{
	    gsecond = 0;
		gminute++;
	}
	else if(gminute == 60 && ghour < 25)
	{
	    gminute = 0;
	    ghour++;
	    GameHW(ghour);
	    
	}
	else if(ghour == 24) ghour = 0;
	//gettime(hour,minute,second);
	//printf("GamEseconds = %d Real = %d %d %d",gsecond,hour,minute,second);
}
GameHW(varhour)
{
	switch (varhour)
 	{
 	    case 0: SetWorldTime(0),SetWeather(39);
 	    case 1: SetWorldTime(1),SetWeather(39);
 	    case 2: SetWorldTime(2),SetWeather(39);
 	    case 3: SetWorldTime(3),SetWeather(39);
 	    case 4: SetWorldTime(4),SetWeather(38);
        case 5: SetWorldTime(5),SetWeather(0);
        case 6: SetWorldTime(6),SetWeather(36);
  	    case 7: SetWorldTime(7),SetWeather(37);
 	    case 8: SetWorldTime(8),SetWeather(37);
 	    case 9: SetWorldTime(9),SetWeather(1);
 	    case 10: SetWorldTime(10),SetWeather(1);
 	    case 11: SetWorldTime(11),SetWeather(1);
 	    case 12: SetWorldTime(12),SetWeather(1);
 	    case 13: SetWorldTime(13),SetWeather(1);
 	    case 14: SetWorldTime(14),SetWeather(1);
 	    case 15: SetWorldTime(15),SetWeather(1);
 	    case 16: SetWorldTime(16),SetWeather(1);
 	    case 17: SetWorldTime(17),SetWeather(0);
 	    case 18: SetWorldTime(18),SetWeather(0);
 	    case 19: SetWorldTime(19),SetWeather(0);
 	    case 20: SetWorldTime(20),SetWeather(17);
 	    case 21: SetWorldTime(21),SetWeather(17);
 	    case 22: SetWorldTime(22),SetWeather(18);
 	    case 23: SetWorldTime(23),SetWeather(39);
 	    case 24: SetWorldTime(24),SetWeather(39);

 	}
    /*case 0..3,23,24: SetWeather(39);
    case 4: SetWeather(38);
    case 5,17..19: SetWeather(0);
    case 6: SetWeather(36);
    case 7,8: SetWeather(37);
    case 9..16: SetWeather(1);
    case 20,21: SetWeather(17);
    case 22: SetWeather(18);*/
	//}
	return 1;
}

function Restart()
{
	SendRconCommand("gmx");
}
//============================================================================================================================
function HourTimer()
{
	gettime(hour,minute,second);
	if(hour == 4 && minute == 0 && second == 0) SetTimer("Restart",5000,false);
	
}
//============================================================Время реальное
function SecTimer()
{
/*	foreach(new vehicleid: Vehicle)//for(new vehicleid = 0; vehicleid<MAX_VEHICLES; vehicleid++)//
	{
		//new Float: vpos[3];
	    
		
	}*/
	//foreach(new playerid : Player)
	//{
		
		//SetPVarInt(playerid,"accelTime",GetPVarInt(playerid,"accelTime")+1);
		
		/*if(GetPVarInt(playerid,"animtalk")>1) SetPVarInt(playerid,"animtalk",GetPVarInt(playerid,"animtalk")-1);
		else if(GetPVarInt(playerid,"animtalk") == 1)
		{
		    ClearAnimations(playerid);
			ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1);
			SetPVarInt(playerid,"animtalk",0);
		}*/
	//}
	//===============================================================================
	
	/*new Float:x, Float:y, Float:z;
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i))
        {
            GetPlayerPos(i, x, y, z);
            if((x > -992.5172 && x < 4000.0000) && (y < 528.0000 && y > -4000.0000)) // Проверям по позиции игрока где он находиться. В данном случае мы в Los Santos
            {
                SCM(i,COLOR_WHITE,"В этом городе действует валютная система: Доллары"); // Доллары в LS
            }
            else if((x > -4000.0000 && x< -992.5172) && (y < 4000.0000 && y > -4000.0000)) // Проверям по позиции игрока где он находиться. В данном случае мы в  San Fierro
            {
                SCM(i,COLOR_WHITE,"В этом городе действует валютная система: Центы"); // Центы в СФ
            }
            else if((x > -992.5172 && x< 4000.0000) && (y < 4000.0000 && y > 528.0000)) // Проверям по позиции игрока где он находиться. В данном случае мы в Las Venturas
            {
                SCM(i,COLOR_WHITE, "В этом городе действует валютная система: Рупии"); // Рупии в LV
            }
        }
    }*/
	//================================================================================================
	//gettime(hour,minute,second);
 	//randwea = random(20);
}
RegEnd(playerid)
{
	
	for(new i = 1; i < sizeof(history); i++)
	{
	    PlayerTextDrawHide(playerid,history[i][playerid]);
	}
    for(new i = 0; i< sizeof(TextDraw); i++)
    {
        TextDrawHideForPlayer(playerid,TextDraw[i]);
    }
	PlayerTextDrawHide(playerid,TextName[playerid]);
	PlayerTextDrawHide(playerid,TextPass[playerid]);
	PlayerTextDrawHide(playerid,TextMail[playerid]);
	PlayerTextDrawHide(playerid,TextSex[playerid]);
	PlayerTextDrawHide(playerid,TextRace[playerid]);
	PlayerTextDrawHide(playerid,TextAccept[playerid]);
	
	switch(PlayerInfo[playerid][pStory])
	{
		case 1:
		{
			switch(PlayerInfo[playerid][pSex])
			{
				case 1:
				{
					switch(PlayerInfo[playerid][pRace])
					{
						case 1: PlayerInfo[playerid][pSkin] = AfroCrime[random(sizeof(AfroCrime))];//Negr
						case 2: PlayerInfo[playerid][pSkin] = EuroCrime[random(sizeof(EuroCrime))];//Euro
						case 3: PlayerInfo[playerid][pSkin] = AsiaCrime[random(sizeof(AsiaCrime))];//Asia
					}
				}
				case 2:
				{
					switch(PlayerInfo[playerid][pRace])
					{
						case 1: PlayerInfo[playerid][pSkin] = AfroFemCrime[random(sizeof(AfroFemCrime))];//Negr
						case 2: PlayerInfo[playerid][pSkin] = EuroFemCrime[random(sizeof(EuroFemCrime))];//Euro
						case 3: PlayerInfo[playerid][pSkin] = AsiaFemCrime[random(sizeof(AsiaFemCrime))];//Asia
					}
				}
			}//switch sex
		}//case story
		case 2:
		{
		    switch(PlayerInfo[playerid][pSex])
		    {
		        case 1:
		        {
	          		switch(PlayerInfo[playerid][pRace])
				    {
				        case 1: PlayerInfo[playerid][pSkin] = AfroGov[random(sizeof(AfroGov))]; //negr
				        case 2: PlayerInfo[playerid][pSkin] = EuroGov[random(sizeof(EuroGov))];// Euro
				        case 3: PlayerInfo[playerid][pSkin] = AsiaGov[random(sizeof(AsiaGov))];//Asia
				    }
		        }
		        case 2:
		        {
		            switch(PlayerInfo[playerid][pRace])
			    	{
				        case 1: PlayerInfo[playerid][pSkin] = AfroFemGov[random(sizeof(AfroFemGov))]; //negr
				        case 2: PlayerInfo[playerid][pSkin] = EuroFemGov[random(sizeof(EuroFemGov))];// Euro
				        case 3: PlayerInfo[playerid][pSkin] = AsiaFemGov[random(sizeof(AsiaFemGov))];//Asia
					}
		        }
		    }//switch Sex
		}// case story
		case 3:
		{
		    switch(PlayerInfo[playerid][pSex])
		    {
		        case 1:
		        {
	          		switch(PlayerInfo[playerid][pRace])
				    {
				        case 1: PlayerInfo[playerid][pSkin] = AfroNormal[random(sizeof(AfroNormal))]; //negr
				        case 2: PlayerInfo[playerid][pSkin] = EuroNormal[random(sizeof(EuroNormal))];// Euro
				        case 3: PlayerInfo[playerid][pSkin] = AsiaNormal[random(sizeof(AsiaNormal))];//Asia
				    }
		        }
		        case 2:
		        {
		            switch(PlayerInfo[playerid][pRace])
			    	{
				        case 1: PlayerInfo[playerid][pSkin] = AfroFemNormal[random(sizeof(AfroFemNormal))]; //negr
				        case 2: PlayerInfo[playerid][pSkin] = EuroFemNormal[random(sizeof(EuroFemNormal))];// Euro
				        case 3: PlayerInfo[playerid][pSkin] = AsiaFemNormal[random(sizeof(AsiaFemNormal))];//Asia
					}
		        }
		    }//switch pSex
		}// - case story
	}
	//PreloadAnimLib(playerid,"PED");
	CreateNewAccount(playerid);
	
}
//=============================================================??? ????? ???? ???????? ??????? ? ??? ?????????? ? ??? ?????????==================
PlayerHeal(playerid)
{
	
	SetPVarFloat(playerid,"xpos",0.0);
	SetPVarFloat(playerid,"ypos",0.0);
	SetPVarFloat(playerid,"zpos",0.0);
	strallg = "";
	strd = "";
	dhour = 0; dminute= 0; dsecond = 0;
	//SetPlayerHealth(playerid,100);
	return 1;
}
//==========================================================================================================================================================
GiveDamageForPlayer(playerid,weaponid)
{
	new Float: phealth;
	//new string[200];
	new Float:dmg;
	GetPlayerHealth(playerid,phealth);
	switch(weaponid)
	{
	    case 0: dmg = 5.0;
		case 1..8: dmg = 15.0;
		case 22: dmg = 30.0;
		case 23: dmg = 30.0;
		case 25: dmg = 55.0;
		case 28: dmg = 25.0;
		case 29: dmg = 30.0;
		case 30: dmg = 60.0;
		case 31: dmg = 55.0;
		case 33: dmg = 45.0;
		case 34: dmg = 200.0;
		case 35: dmg = 400.0;
		//default: dmg = 0.0;
	}
	SetPlayerHealth(playerid,phealth-dmg);
	printf("URON = %f %f",dmg,phealth-dmg);
}
stock GetGunName(fnumbwer)
{
	new string[128];
	switch(fnumbwer)
	{
	case 24: format(string,sizeof(string), "Deagle");
	case 23: format(string,sizeof(string), "SDPistol");
	case 25: format(string,sizeof(string), "????????");
	case 28: format(string,sizeof(string), "???");
	case 29: format(string,sizeof(string), "SMG");
	case 30: format(string,sizeof(string), "??-47");
	case 31: format(string,sizeof(string), "M4");
	case 2: format(string,sizeof(string), "??????");
	case 3: format(string,sizeof(string), "???????");
	case 5: format(string,sizeof(string), "????");
	case 8: format(string,sizeof(string), "??????");
	case 0: format(string,sizeof(string), "Удар");
	default: format(string,sizeof(string),"Упал");
	}
	return string;
}
RandText(value)
{
	new newtext[][] = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
	new sizestr[4];
	//if(value > sizeof(sizestr)) value = sizeof(sizestr);
	for(new i = 0; i < value; i ++)
	{
		strcat(sizestr, newtext[random(sizeof(newtext))]);
	}
	return sizestr;
}

AccelVehicle(vehicleid)
{
    new Float: v[3], Float: cur_speed_mph,Float: speed_mph;
    cur_speed_mph = GetVehicleSpeed(vehicleid);
    if(cur_speed_mph>32)
    {
        if(GetVehicleModel(vehicleid) != 522)
        {
		    if(cur_speed_mph<60.0) speed_mph = cur_speed_mph+8;//30
		    else speed_mph = cur_speed_mph+6;//30
	    }
	    else
	    {
	        if(cur_speed_mph<60) speed_mph = cur_speed_mph+10;//30
		    if(cur_speed_mph>60) speed_mph = cur_speed_mph+35;//30
		    if(cur_speed_mph >130) speed_mph = cur_speed_mph+55;//30
	    }
	    //printf("CURRENT SPEDD = %d SPEEDNEW = %d",cur_speed_mph,speed_mph);
		if ( speed_mph < 1 ) speed_mph = 1;

		GetVehicleVelocity( vehicleid, v[0], v[1], v[2] );
		//cur_speed_mph = floatround( 200.0 * floatsqroot( v[0]*v[0] + v[1]*v[1] + v[2]*v[2] ), floatround_floor );*/

		if ( cur_speed_mph <= 0 )
		{
			new Float: zAngle;
			GetVehicleZAngle( vehicleid, zAngle );

			new Float: newVelX = floatcos( (zAngle -= 270.0), degrees ) * speed_mph / 100.0;//200
			SetVehicleVelocity( vehicleid, newVelX, floattan(zAngle,degrees) * newVelX, 0.0 );

		//return 1;
		}

		new Float: vMultiplier = speed_mph / cur_speed_mph;
		SetVehicleVelocity( vehicleid, v[0] * vMultiplier, v[1] * vMultiplier, v[2] * vMultiplier );
		//printf("MULTIPLIER = %f",vMultiplier,vMultiplier);
	}
}
function TimerTalk(playerid)
{
    //ClearAnimations(playerid);
	ApplyAnimation(playerid, "PED", "facanger",4.1,0,1,1,1,1);
	//ApplyAnimation(playerid, "CARRY", "crry_prtial",4.1,0,1,1,1,1);
	//SetPVarInt(playerid,"animtalk",0);
}
function TimerIntro(playerid)
{
	new cmdstr[512];
	switch(GetPVarInt(playerid,"story"))
	{
		case 1:
		{
			if(GetPVarInt(playerid,"part") == 1)
			{
		        SetPlayerPos(playerid,250.0557,68.1204,1003.6406);
		        SetPlayerInterior(playerid, -1);
				SetPlayerVirtualWorld (playerid, playerid+1);
		        print("CHECK");
			    TogglePlayerControllable(playerid,0);
			    new actorcop;
				actorcop = CreateActor(280,251.2563,68.1541,1003.6406, 92.2091);
			 	ApplyActorAnimation(actorcop, "ped", "IDLE_chat",4.1,1,0,0,0,0);
	 			SetActorVirtualWorld(actorcop, playerid+1) ;
	 			//SetActorInterior(actorcop,6);
			    SetPVarInt(playerid,"count",GetPVarInt(playerid,"count")+1);
			    new str[15];
			    format(str,sizeof(str),"count %s%d",str,GetPVarInt(playerid,"count"));
			    print(str);
			}
		    if(GetPVarInt(playerid,"count") == 3)
		    {
		        print("CHECK2");
	        	PlayerInfo[playerid][pMoney] += 100;
	            PlayerInfo[playerid][pLatchkey] = 1;//Отмычка
	            PlayerInfo[playerid][pDeagleSkill] = 80;
				SetPlayerPos(playerid,1811.5768,-1577.4017,13.5328);
			 	SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld (playerid, 0);
				format(cmdstr,sizeof(cmdstr),"Вы выбрали прошлое бандита. Вы имеете на руках всего 100 долларов, а также:\n\n- Отмычку(Позволяет взламывать замки)\n- Уровень владения пистолетом 80%\n- Наркозависимость\n- 1 уровень взлома\n\nНажмите 'Далее' для продолжения");
				SPD(playerid,10005,DIALOG_STYLE_MSGBOX,"Информационное окно",cmdstr,"Далее","");
				firstspawn[playerid] = 0;
				SetPVarInt(playerid,"part",0);
				DeletePVar(playerid,"count");
				TogglePlayerControllable(playerid,1);
				TextDrawHideForPlayer(playerid, td_intro [0]);
				TextDrawHideForPlayer(playerid, td_intro [1]);
				KillTimer(timerin);
		    }
		}
		case 2:
		{
		    new pl_veh;
		    new pl_actor;
		    new pl_case;
		    new pl_stay;
		    switch(GetPVarInt(playerid,"part"))
			{
			    case 1:
			    {
			        ClearAnimations(playerid);
			        SetPlayerPos(playerid, -1858.30457, 61.83174, 1055.12024);

			        SetPlayerInterior(playerid, 14);
					SetPlayerVirtualWorld (playerid, playerid+1);

			        ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1);

					pl_case = CreateDynamicObject(19624, -1857.52527, 64.81780, 1055.21387, 0.00000, 0.00000, 311.58521, playerid, 14, playerid, 50);
					pl_stay = CreateDynamicObject(19360, -1858.30457, 61.83174, 1054, 0.00000, 90, 0.0000, playerid, 14, playerid, 50);
					MoveDynamicObject(pl_case, -1857.52527, 62.31780, 1055.21387, 0.5);


					SetPlayerCameraPos(playerid, -1860.9407, 64.7888, 1055.2455);
					SetPlayerCameraLookAt(playerid, -1859.1772, 64.1446, 1055.1573);
					SetPVarInt(playerid,"part",2);
			    }
			    case 2:
			    {
			        SetPlayerPos(playerid, 1675.6003,-2333.0229,-2.6797);
			        SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld (playerid, playerid+1);
	                pl_veh = AddVehicle(438, 1690.6229, -2324.4004, -2.8372, 270.0000, 6, 6, 1,0);
	                ClearAnimations(playerid);
					SetVehicleVirtualWorld(pl_veh, playerid+1) ;
	                SetVehicleTrunkState(pl_veh,1);

					pl_actor = CreateActor(142, 1688.8666, -2325.9404, -2.6797, 136.9996);
					SetActorVirtualWorld(pl_actor, playerid+1);

					SetPlayerCameraPos(playerid, 1685.8745, -2332.1663, -1.6566);
					SetPlayerCameraLookAt(playerid, 1686.2665, -2331.2461, -1.8418);

					SetPVarInt(playerid,"part",3);

			    }
			    case 3:
			    {
			        PlayerInfo[playerid][pMoney] += 5000;
		            GivePlayerMoney(playerid,PlayerInfo[playerid][pMoney]);
		            TogglePlayerControllable(playerid,1);
		            SetCameraBehindPlayer(playerid);
					SetPlayerPos(playerid,1682.9122,-2243.4753,13.5413);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld (playerid, 0);
					ClearAnimations(playerid);
					format(cmdstr,sizeof(cmdstr),"Вы выбрали прошлое гос. работника. Вы имеете на руках 5000 долларов\n\nНажмите 'Далее' для продолжения");
					SPD(playerid,10005,DIALOG_STYLE_MSGBOX,"Информационное окно",cmdstr,"Далее","");
					firstspawn[playerid] = 0;
					SetPVarInt(playerid,"part",0);
					DestroyActor(pl_actor);
					DestroyVehicle(pl_veh);
					DestroyDynamicObject(pl_case);
					DestroyDynamicObject(pl_stay);
					TextDrawHideForPlayer(playerid, td_intro [0]);
					TextDrawHideForPlayer(playerid, td_intro [1]);
					KillTimer(timerin);
			    }
			}
		}
	}
}
UpdateMoney(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new money = GetPlayerMoney(playerid);
		if(PlayerInfo[playerid][pMoney] != money)
		{
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
		}
	}
	return ;
}
IsAdmin(playerid)
{

	if(GetPVarInt(playerid,"adminacces") != 1) return 0;
	else return PlayerInfo[playerid][pAdmin];
}
function AddVehInDB(carid)
{
	VehInfo[carid][vID] = cache_insert_id();
	printf("VEH insert = %d",cache_insert_id());
}
AddVehicle(modelid,Float:x,Float:y,Float:z,Float:angle,color1,color2,temp,siren)
{
    new cmdstr[500];
	new carid = CreateVehicle(modelid,x,y,z,angle,color1,color2,-1,siren);
	SetEngineState(carid, 0);
	SetLightState(carid, 0);
	VehInfo[carid][Model] = modelid;
	VehInfo[carid][posX] = x;
	VehInfo[carid][posY] = y;
	VehInfo[carid][posZ] = z;
	VehInfo[carid][angleZ] = angle;
	VehInfo[carid][Color1] = color1;
	VehInfo[carid][Color2] = color2;
	VehInfo[carid][Fueltank] = GetVehicleFuelTank(carid);
	SetVehicleFuel(carid,GetVehicleFuelTank(carid));
 	if(temp)
	{
		VehInfo[carid][Temp] = true;
	}
	else
	{
		VehInfo[carid][Temp] = false;
		format(cmdstr,sizeof(cmdstr),"INSERT INTO `vehicles` (Model,posX,posY,posZ,angleZ,Color1,Color2,Fuel,Fueltank,Owner)\
		 VALUES ('%d','%f','%f','%f','%f','%d','%d','%f','%d','%s')"\
		,VehInfo[carid][Model]\
		,VehInfo[carid][posX]\
		,VehInfo[carid][posY]\
		,VehInfo[carid][posZ]\
		,VehInfo[carid][angleZ]\
		,VehInfo[carid][Color1]\
		,VehInfo[carid][Color2]\
		,VehInfo[carid][Fuel]\
		,VehInfo[carid][Fueltank]\
		,VehInfo[carid][Owner]);
		
		printf("QUERY INSERT VEHICELS = %s",cmdstr);
		mysql_tquery(mysql_connect_ID, cmdstr, "AddVehInDB", "d",carid);
		
	}
	VehicleTimer[carid] = SetTimerEx("VehicleUpdate",1000,0,"d",carid);
	return carid;
}
function SpeedometrUPD(playerid)
{
    new speedstr[16], fuelstr[16], vehicleid = GetPlayerVehicleID(playerid);
    switch(VehInfo[vehicleid][Engine])
    {
        case 1: PlayerTextDrawSetString(playerid, SpeedoDraw[7][playerid],"~g~E");
        case 0: PlayerTextDrawSetString(playerid, SpeedoDraw[7][playerid],"~r~E");
    }
    switch(VehInfo[vehicleid][Light])
    {
        case 1: PlayerTextDrawSetString(playerid, SpeedoDraw[6][playerid],"~g~L");
        case 0: PlayerTextDrawSetString(playerid, SpeedoDraw[6][playerid],"~r~L");
    }
    format(speedstr, sizeof(speedstr), "%d KM/H", GetVehicleSpeed(vehicleid));
    format(fuelstr, sizeof(fuelstr), "%.0f F", VehInfo[vehicleid][Fuel]);
    PlayerTextDrawSetString(playerid, SpeedoDraw[3][playerid],speedstr);
    PlayerTextDrawSetString(playerid, SpeedoDraw[4][playerid],fuelstr);
    
    //PlayerTextDrawTextSize(playerid, SpeedoDraw[11][playerid], (71.500000/100)*VehInfo[vehicleid][Fuel], 18.480005);
    //PlayerTextDrawHide(playerid, SpeedoDraw[11][playerid]);
    //PlayerTextDrawShow(playerid, SpeedoDraw[11][playerid]);
	return true;
}
UpdateAFK(playerid)
{
    if(GetPVarInt(playerid, "AFK") > 5)
    {
    	new stroka[20];
        format(stroka, 20, "AFK: %d секунд", GetPVarInt(playerid, "AFK"));
        SetPlayerChatBubble(playerid, stroka, -1, 20.0, 1100);
        SCM(playerid,0,stroka);
    }
    SetPVarInt(playerid, "AFK", GetPVarInt(playerid, "AFK")+1);
    return 1;
}
LoadAnimLib(playerid)
{
    ApplyAnimation(playerid,"BASEBALL","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"BEACH","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"benchpress","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"BD_FIRE","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"BOMBER","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"CAMERA","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"CAR_CHAT","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"CARRY","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"CASINO","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"COP_AMBIENT","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"CRACK","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"DAM_JUMP","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"DEALER","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"DODGE","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"FOOD","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"GANGS","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"GRAVEYARD","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"HEIST9","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"INT_HOUSE","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"INT_OFFICE","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"KISSING","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"LOWRIDER","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"MD_CHASE","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"ON_LOOKERS","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"PARK","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"PAULNMAC","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"PED","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"RYDER","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"RAPPING","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"RIOT","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"SHOP","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"SMOKING","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"SNM","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"STRIP","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"SUNBATHE","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"SWAT","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"SWEET","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"OTB","null",0.0,0,0,0,0,0);
	ApplyAnimation(playerid,"ROB_BANK","null",0.0,0,0,0,0,0);
	return 1;
    //ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}
/*SetPlayerPos(playerid, Float:x, Float:y, Float:z, Float: angle, interior, world)
{
    if(interior != -1) SetPlayerInterior (playerid, interior);
	if(world != -1) SetPlayerVirtualWorld (playerid, world);
	if(angle != -1) SetPlayerFacingAngle(playerid,angle);
	else SetCameraBehindPlayer(playerid);
	SetPVarFloat(playerid, "AirBreak", 3);
	SetPVarFloat(playerid, "OldPosX", x);
	SetPVarFloat(playerid, "OldPosY", y);
	SetPVarFloat(playerid, "OldPosZ", z);
	return SetPlayerPos(playerid,x,y,z);
}*/
function LoadPlayerWeapons(playerid)
{
	new rows;
    cache_get_row_count(rows);
    
  
	printf("WEAP NUM ROWS = %d",rows);

	new i = 0;
	new bdweap,bdammo;
	
	
    
	while(i < rows) //Пока не дойдет до последнего
	{
	    
	    
	    cache_get_value_name_int(i, "weaponid", bdweap);
	    cache_get_value_name_int(i, "ammo", bdammo);
	    
	    printf("WEAPID = %d AMMO = %d",bdweap,bdammo);

     	GivePlayerWeapon(playerid,bdweap,bdammo);
     	i++;
	}
	printf("[SYSTEM] Успешно загруженно %d оружий!",i);
	
    return 1;
}
SaveWeapons(playerid)
{
    new cmdstr[500];
    new weapon,ammo;
    printf("VIZOF SAVE WEAPON!!!!");
    for(new slot = 0; slot<13; slot++)
	{
	    GetPlayerWeaponData(playerid, slot, weapon, ammo);
	   	printf("SAVE WEAPON = %d",PlayerWeapon[playerid][pWeapon][slot]);
	    if(PlayerWeapon[playerid][pAmmo][slot] > 0)
	    {
   	 		format(cmdstr,sizeof(cmdstr),"INSERT INTO `player_weapons` VALUES \
			('%d','%d','%d') ON DUPLICATE KEY UPDATE `ammo` = '%d'",
			PlayerInfo[playerid][pID],
			PlayerWeapon[playerid][pWeapon][slot],
			PlayerWeapon[playerid][pAmmo][slot],
			PlayerWeapon[playerid][pAmmo][slot]);
			
			printf("PLID = %d, WEAPID = %d, AMMO = %d",PlayerInfo[playerid][pID],PlayerWeapon[playerid][pWeapon][slot],PlayerWeapon[playerid][pAmmo][slot]);
			
			mysql_tquery(mysql_connect_ID, cmdstr, "", "");
			
			printf("QUERY WEAPON = %s",cmdstr);
		}
		
	}
	return 1;
}
function LoadVehicles()
{
	new rows;
    cache_get_row_count(rows);
	new i = 0;
	new veh = i+1;
//	new temp[50];
	while(i < rows) //Пока не дойдет до последнего
	{
	    
	    
	    cache_get_value_name_int(i,"vID",VehInfo[veh][vID]);
	    cache_get_value_name_int(i,"Model",VehInfo[veh][Model]);
	    cache_get_value_name_float(i,"posX",VehInfo[veh][posX]);
	    cache_get_value_name_float(i,"posY",VehInfo[veh][posY]);
	    cache_get_value_name_float(i,"posZ",VehInfo[veh][posZ]);
	    cache_get_value_name_float(i,"angleZ",VehInfo[veh][angleZ]);
	    cache_get_value_name_float(i,"Fuel",VehInfo[veh][Fuel]);
	    cache_get_value_name_int(i,"Fueltank",VehInfo[veh][Fueltank]);
	    cache_get_value_name_int(i,"Color1",VehInfo[veh][Color1]);
	    cache_get_value_name_int(i,"Color2",VehInfo[veh][Color2]);
	    cache_get_value_name(i,"Owner",VehInfo[veh][Owner],32);
	    
	    VehInfo[veh][Temp] = false;

		new carid = CreateVehicle(VehInfo[veh][Model],VehInfo[veh][posX],VehInfo[veh][posY],VehInfo[veh][posZ],VehInfo[veh][angleZ],VehInfo[veh][Color1],VehInfo[veh][Color2],-1,0);
		VehicleTimer[carid] = SetTimerEx("VehicleUpdate",1000,0,"d",carid);
		//SetVehicleZAngle(carid, angle);
	    SetEngineState(carid, 0);
		SetLightState(carid, 0);
		
		
		printf("ZAGRUZKA  = %d",i);
		printf("VEA ID Array  = %d",veh);
		printf("VEA ID posX  = %f",VehInfo[veh][posX]);
		
	    i++;
	    veh++;
        // mysql_fetch_field ? mysql_fetch_field_row ???
	}
	printf("[SYSTEM] Успешно загруженно %d автомобилей!",i);
}
SaveVehicles()
{
	new cmdstr[500];
    new cnttime = GetTickCount();
    new quantity = 0;
    foreach(new vehicleid :Vehicle)
	{
	    if(!VehInfo[vehicleid][Temp])
	    {
			//new string[128];
			
			format(cmdstr,sizeof(cmdstr),"UPDATE `vehicles` SET \
			`vID` = '%d', `Model` = '%d', `posX` = '%f', `posY` = '%f', `posZ` = '%f', `angleZ` = '%f', `Color1` = '%d', \
			`Color2` = '%d',`Fuel` = '%f', `Fueltank` = '%d', `Owner` = '%s'  WHERE `vID` = '%d'",\
			VehInfo[vehicleid][vID],
			VehInfo[vehicleid][Model],
			VehInfo[vehicleid][posX],
			VehInfo[vehicleid][posY],
			VehInfo[vehicleid][posZ],
			VehInfo[vehicleid][angleZ],
			VehInfo[vehicleid][Color1],
			VehInfo[vehicleid][Color2],
			VehInfo[vehicleid][Fuel],
			VehInfo[vehicleid][Fueltank],
			VehInfo[vehicleid][Owner],
			VehInfo[vehicleid][vID]);
			
			mysql_tquery(mysql_connect_ID, cmdstr, "", "");
			
			//printf("Машина c id %d сохранена!",VehInfo[vehicleid][vID]);
			if(strlen(cmdstr) >= 2100) printf("Внимание! Машина %d не смогла сохранится!",VehInfo[vehicleid][vID]);
			quantity++;
		}
	}
	printf("[SYSTEM] Успешно сохранилось %d машин! Затраченно времени: %d ms",quantity,GetTickCount()-cnttime);
	format(cmdstr,sizeof(cmdstr),"Успешно сохранилось %d машин! Затраченно времени: %d ms",quantity,GetTickCount()-cnttime);
	SCMA(cmdstr);
	return true;
}
SaveAllPlayers()
{
    new cnttime = GetTickCount();
    new quantity = 0;
    new cmdstr[128];
	foreach(new playerid :Player)
	{
		SavePlayer(playerid);
		quantity++;
	}
	printf("[SYSTEM] Успешно сохранилось %d аккаунтов! Затраченно времени: %d ms",quantity,GetTickCount()-cnttime);
	format(cmdstr,sizeof(cmdstr),"Успешно сохранилось %d аккаунтов! Затраченно времени: %d ms",quantity,GetTickCount()-cnttime);
	SCMA(cmdstr);
	return 1;
}
SavePlayer(playerid)
{

//	new string[128];
    new query_string[MAX_STRING];
	if(PlayerLoggedIn[playerid])
	{
		format(query_string,sizeof(query_string),"UPDATE `players` SET \
		`pName` = '%s', `pPassword` = '%s',`pLevel` = '%d',`pSex` = '%d',`pSkin` = '%d',`pRace` = '%d',`pMail` = '%s',`pStory` = '%d',`pMoney` = '%d', \
		`pHealth` = '%f', `pArmour` = '%f' \
		WHERE `pName` = '%s'",\
		PlayerInfo[playerid][pName],
		PlayerInfo[playerid][pPassword],
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pSex],
		PlayerInfo[playerid][pSkin],
		PlayerInfo[playerid][pRace],
		PlayerInfo[playerid][pMail],
		PlayerInfo[playerid][pStory],
		PlayerInfo[playerid][pMoney],
		PlayerInfo[playerid][pHealth],
		PlayerInfo[playerid][pArmour],
		PlayerInfo[playerid][pName]);

		mysql_tquery(mysql_connect_ID, query_string, "", "");
		new errno = mysql_errno();
		
		if(PlayerInfo[playerid][pAdmin]>0)
		{
			format(query_string,sizeof(query_string),"INSERT INTO `admins` VALUES \
			('%d','%d','%s') ON DUPLICATE KEY UPDATE `pAdmin` = '%d', `pAdminCode` = '%s'",PlayerInfo[playerid][pID],
			PlayerInfo[playerid][pAdmin],
			PlayerInfo[playerid][pAdminCode],
			PlayerInfo[playerid][pAdmin],
			PlayerInfo[playerid][pAdminCode]);
			mysql_tquery(mysql_connect_ID, query_string, "", "");
			printf("QUERY IN = %s",query_string);
			printf("PLID = %d",PlayerInfo[playerid][pID]);
		}
		
		format(query_string,sizeof(query_string),"INSERT INTO `player_licenses` VALUES \
		('%d','%d','%d') ON DUPLICATE KEY UPDATE `pDriveLic` = '%d', `pGunLic` = '%d'",
		PlayerInfo[playerid][pID],
		PlayerInfo[playerid][pDriveLic],
		PlayerInfo[playerid][pGunLic],
		PlayerInfo[playerid][pDriveLic],
		PlayerInfo[playerid][pGunLic]);
		mysql_tquery(mysql_connect_ID, query_string, "", "");
		printf("QUERY IN = %s",query_string);
		printf("PLID = %d",PlayerInfo[playerid][pID]);
		
		format(query_string,sizeof(query_string),"INSERT INTO `player_specials` VALUES \
		('%d','%d') ON DUPLICATE KEY UPDATE `pLatchkey` = '%d'",
		PlayerInfo[playerid][pID],PlayerInfo[playerid][pLatchkey],PlayerInfo[playerid][pLatchkey]);
		mysql_tquery(mysql_connect_ID, query_string, "", "");
		printf("QUERY IN = %s",query_string);
		printf("PLID = %d",PlayerInfo[playerid][pID]);
		
		format(query_string,sizeof(query_string),"INSERT INTO `player_weapon_skills` VALUES \
		('%d','%d') ON DUPLICATE KEY UPDATE `pDeagleSkill` = '%d'",
		PlayerInfo[playerid][pID], PlayerInfo[playerid][pDeagleSkill],PlayerInfo[playerid][pDeagleSkill]);
		mysql_tquery(mysql_connect_ID, query_string, "", "");
		printf("QUERY IN = %s",query_string);
		printf("PLID = %d",PlayerInfo[playerid][pID]);
		
		printf("Аккаунт успешно сохранен! %s ERROR = %d",query_string,errno);
		//printf("ERROR TEXT = %s",mysql_error(errno));
		if(strlen(query_string) >= 1024) printf("Внимание! Аккаунт %s не смог сохранится!",Name(playerid));

	}
	printf("[SYSTEM] Аккаунт %s успешно сохранился!",Name(playerid));
	return true;
}
SendCheaterToAdmins(cheaterid,reason,dostate)
{
	//if(IsAdmin(cheaterid)>0) return 1;
	new rstring[32];
	new cmdstr[128];
	switch(reason)
	{
	    case 1: rstring = "TP IN CAR / FROM CAR";
	    case 2: rstring = "DIALOG HIDER";
	    case 3: rstring = "TP CARS TO PLAYER";
	    case 4: rstring = "AIRBREAK / TP";
	    case 5: rstring = "FLYHACK";
	    case 6: rstring = "GUNCHEAT";
		case 7: rstring = "GOD MODE";
		default: rstring = "CHEAT";
	}
	if(dostate == 1)
	{
	    format(cmdstr,sizeof(cmdstr),"Игрок %s[id: %d] был кикнут за использование чита - (%s)",Name(cheaterid),cheaterid,rstring);
		KickEx(cheaterid);
	} // Kick
	else
	{
		format(cmdstr,sizeof(cmdstr),"Игрок %s[id: %d] возможно использует чит - (%s)",Name(cheaterid),cheaterid,rstring);
		
	}
	SCMA(cmdstr);
	return 1;
}
SendClientMessageToAdmins(message[])
{
	new cmdstr[512];
	format(cmdstr,sizeof(cmdstr),"%s",message);
    foreach(new playerid : Player)
	{
	    if(IsAdmin(playerid)>0) SCM(playerid,COLOR_LIGHTRED,cmdstr);
	}
	printf("SIZE OF MESSAGE = %d,SIZE OF cmdstr = %d,CMDSTR = %s, MESSAGE = %s",strlen(message),strlen(cmdstr),cmdstr,message);
	return 1;
}
/*acc_int_strcat(query[], len, name[], number)
{
	new string[100];
	format(string, sizeof(string), "`%s` = '%d',",name, number);
	strcat(query, string, len);
	return true;
}

acc_str_strcat(query[], len, name[], str[])
{
	new string[100];
	format(string, sizeof(string), "`%s` = '%s',",name, str);
	strcat(query, string, len);
	return true;
}

stock acc_float_strcat(query[], len, name[], Float:number)
{
	new string[100];
	format(string, sizeof(string), "`%s` = '%f',", name, number);
	strcat(query, string, len);
	return true;
}
TestNoStock(&num)
{
	num += 2;
	return 1;
}*/
IsEmail(text[])
{
    new check_[2], i = strlen(text);
    while(--i != -1)
	{
        switch(text[i])
		{
            case 'A'..'Z', 'a'..'z', '0'..'9': continue;
            case '_':
			{
                if(text[--i] == '_') return 0;
                continue;
            }
            case '-':
			{
                if(text[--i] == '-') return 0;
                continue;
            }
            case '@': check_[0]++;
            case '.':
			{
                if(text[--i] == '.') return 0;
                check_[1] = 1;
            }
            default: return 0;
        }
        if(check_[0] != 1 && check_[1] != 1) return 0;
        // Проверка на правельный Email
    }
    return 1;
}
IsOnlyText(text[])
{
	new i = strlen(text);
	while(--i != -1)//for(new Index = strlen(text)-1; Index != -1; Index--)
	{
		switch(text[i])
		{
			case 'A'..'Z','a'..'z','0'..'9': continue;
			default: return 0;
		}
	}
	return 1;
}
/*VehicleDestroy(vehicleid)
{
    new cmdstr[128];
	if(VehInfo[vehicleid][Temp] == true) return DestroyVehicle(vehicleid);
	format(cmdstr,sizeof(cmdstr),"DELETE FROM `vehicles` WHERE `vID` = '%d'",VehInfo[vehicleid][vID]);
	mysql_query(cmdstr);
	printf("QUERY VEH = %s",cmdstr);
	mysql_store_result();
	if(mysql_affected_rows()<0) return printf("[SYSTEM] Ошибка удаления транспорта!");
	VehInfo[vehicleid][Temp] = true;
	DestroyVehicle(vehicleid);
	printf("[SYSTEM] Транспорт успешно удален!");
	mysql_free_result();
	KillTimer(VehicleTimer[playerid]);
	return 1;
}*/
EngineCheck(playerid)
{
    //new siren = GetVehicleParamsSirenState(GetPlayerVehicleID(playerid));
    new Float:X, Float:Y, Float:Z, Float:Distance = 5.0;
    GetPlayerPos(playerid, X, Y, Z);
	if(VehInfo[GetPlayerVehicleID(playerid)][Engine] == 0)
	{
		PlayAudioStreamForPlayer(playerid, "http://noisefx.ru/noise_base/transport/avtomobili/00292.mp3", X, Y, Z, Distance, 1);
	    SetTimerEx("EngineStart",800,false,"u",playerid);
    }
    else callcmd::en(playerid,"");
	//PlayerPlaySound(playerid,1153,0,0,0);
	return 1;
}
function EngineStart(playerid)
{
    //CallLocalFunction("OnPlayerCommandText", "is", playerid, "/en");
    if(VehInfo[GetPlayerVehicleID(playerid)][Fuel] > 0)
	{
	    callcmd::en(playerid,"");
	}
    StopAudioStreamForPlayer(playerid);
    //PlayerPlaySound(playerid,1154,0,0,0);
	return 1;
}

stock Name(playerid) //Имя игрока
{
	new namestr[MAX_PLAYER_NAME+2];
	GetPlayerName(playerid,namestr,sizeof(namestr));
	return namestr;
}

static stock radio_list[][radio_info] ={
	{ "","Radio off"},
	{ "Grind FM","http://www.grind.fm/sites/grind.fm/themes/grindfm/grind_fm.m3u"},
	{ "Radio Ultra","http://mp3.radioultra.ru/ultra-128.mp3.m3u"},
	{ "Pirate Station","http://www.radiogrom.com/online/russia/piratskaya_stantsiya_radio_online.m3u"},
	{ "Kiss FM","http://radiogrom.com/online/ua_fm/kiss_fm_radio_online.m3u"}
};

stock PlayRadio(playerid,radioid)
{
    new cmdstr[128];
	if(radioid == 0)
	{
		SCM(playerid,0,"Радио выключенно");//GameTextForPlayer(playerid,"Radio Off",3000,5);
		StopAudioStreamForPlayer(playerid);
		return 1;
	}
	//GameTextForPlayer(playerid,radio_list[radioid][radio_name],3000,5);
	format(cmdstr,sizeof(cmdstr),"Вы включили радио: %s",radio_list[radioid][radio_name]);
	SCM(playerid,0,cmdstr);
	PlayAudioStreamForPlayer(playerid,radio_list[radioid][radio_url]);
	return 1;
}
CheckAirBreakTP(playerid)
{
//====================================================================================CHECK FOR TP==========================================================

    new Float:pX,Float:pY,Float:pZ,Float:pvX,Float:pvY,Float:pvZ;
	new Float:Distance = GetPlayerDistanceFromPoint(playerid,GetPVarFloat(playerid, "OldPosX"),GetPVarFloat(playerid, "OldPosY"),GetPVarFloat(playerid, "OldPosZ"));
	GetPlayerPos(playerid,pX,pY,pZ);
	GetPlayerVelocity(playerid,pvX,pvY,pvZ);
	
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehid = GetPlayerVehicleID(playerid);
	    GetVehiclePos(vehid,pX,pY,pZ);
	    GetVehicleVelocity(vehid,pvX,pvY,pvZ);
		if(Distance > 5.0)
		{
		    if(GetVehicleSpeed(vehid) <= 1)
		    {
			    if(GetPVarInt(playerid,"AirBreak")>0) SetPVarInt(playerid, "AirBreak",GetPVarInt(playerid,"AirBreak")-1);
			    else
			    {
					SCA(playerid,4,0);
					SetPVarInt(playerid, "AirBreak",3);
				}
			}
			/*else if(!CA_IsPlayerOnSurface(playerid) && GetVehicleSpeed(vehid) > 10)
			{
			    format(string,sizeof(string),"POZ OLD: %f Z NEW: %f DISTANCE abs NEW- OLD: %f ",GetPVarFloat(playerid, "OldPosZ"),pZ,floatabs(pZ-GetPVarFloat(playerid, "OldPosZ")));
			    SCM(playerid,0,string);

			    if(floatabs(pZ - GetPVarFloat(playerid, "OldPosZ")) < 2.0 || pZ == GetPVarFloat(playerid, "OldPosZ")) SCM(playerid,0,"FLYHACK");

			}*/

		}//if

		//SetPVarInt(playerid, "AirBreak",3);
	}//if
	else
	{
	    if(Distance > 5.0)
		//&& GetPlayerAnimationIndex(playerid) == 1189)//
		{
			if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && (pvX == 0 && pvY == 0 && pvZ == 0 || GetPlayerAnimationIndex(playerid) == 1189))
			{
				printf("PVAR AIRRBREAK = %d",GetPVarInt(playerid,"AirBreak"));
			    if(GetPVarInt(playerid,"AirBreak")>0) SetPVarInt(playerid, "AirBreak",GetPVarInt(playerid,"AirBreak")-1);
			    else
			    {
					SCA(playerid,4,0);
					SetPVarInt(playerid, "AirBreak",3);
				}

			}//if

		}//else if
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    switch(GetPlayerAnimationIndex(playerid))
	    {
	        case 958, 959, 1538, 1539, 1543, 1058:
	        {
	            if(GetPlayerWeapon(playerid) != 46 && !CA_IsPlayerOnSurface(playerid) && GetPlayerSpeed(playerid) > 8)
	            {
		        	SCA(playerid,5,0);
		        	SetPVarInt(playerid, "AirBreak",3);
				}
			}
		}
	}
	SetPVarFloat(playerid, "OldPosX", pX);
	SetPVarFloat(playerid, "OldPosY", pY);
	SetPVarFloat(playerid, "OldPosZ", pZ);
}
CheckGunCheat(playerid)
{
    //=================================================================================GUNCHEAT===================================
	new weapid,ammo;
	for (new i = 0; i < 13; i++)
	{
	    GetPlayerWeaponData(playerid, i, weapid, ammo); // weapons[i][0] ??? ???????? &weapons, ? weapons[i][1] - &ammo
		// i = weapon slot
	//	printf("WEAPON IN ARRAY %d IN SLOT %d",PlayerWeapon[playerid][pWeapon][i],weapid);
		
	    if(PlayerWeapon[playerid][pWeapon][i] != weapid && ammo > 0) //|| PlayerWeapon[playerid][pWeapon][GetWS(weapid)] != weapid)
		{
		    SCA(playerid,6,0);
			ResetPlayerWeapons(playerid);
			printf("IN ARRAY ammp = %d",PlayerWeapon[playerid][pAmmo][i]);
		    printf("IN DATA ammp = %d",ammo);
		    printf("IN ARRAY weap = %d",PlayerWeapon[playerid][pWeapon][i]);
		    printf("IN DATA weap = %d",weapid);
		}
	}
}
CheckGMCheat(playerid)
{
	new Float:health;
	
    GetPlayerHealth(playerid, health);
    
    if(_:PlayerInfo[playerid][pHealth] != _:health)
    {
        printf("PL HEALTH = %f ARRAY health = %f",health,PlayerInfo[playerid][pHealth]);
       /* if(PlayerInfo[playerid][pHealth] > health)
        {
            PlayerInfo[playerid][pHealth] = health;
        }
        //  - HAX detected!
        else if(PlayerInfo[playerid][pHealth] < health)
        {
			SCA(playerid,7,0);
        }*/
        if(GetPVarInt(playerid,"ac_health")>0) SetPVarInt(playerid, "ac_health",GetPVarInt(playerid,"ac_health")-1);
		else
        {
	        if(health > PlayerInfo[playerid][pHealth]) SCA(playerid,7,0), SCM(playerid,0,"GMCHEAT");
			else if(health < PlayerInfo[playerid][pHealth]) SetPlayerHealth(playerid,health);
		}
    }
	
}

function VehicleAccelTimer(playerid)
{
    if(GetPVarInt(playerid,"forwardDrive") == 1 && CA_IsPlayerOnSurface(playerid))//GetPVarInt(playerid,"accelTime") == 5 &&
	{
		AccelVehicle(GetPlayerVehicleID(playerid));
	}
	return 1;
}

function CheckForCheat(playerid)
{
    //new string[256];
    
	if(GetPVarInt(playerid, "AFK") < 1 && GetPlayerState(playerid) !=PLAYER_STATE_SPECTATING && GetPVarInt(playerid,"spawned") == 1)
	{
	    
		CheckAirBreakTP(playerid);
		CheckGunCheat(playerid);
		CheckGMCheat(playerid);
		//CheckGMCheat(playerid);
		

	}//if logged
	return 1;
}
function VehicleUpdate(vehicleid)
{
	//SACM(0,"Vehicle update");
    if(VehInfo[vehicleid][Engine] == 1)
    {
        VehInfo[vehicleid][Fuel] -= 0.1;
        if(VehInfo[vehicleid][Fuel] <= 0) SetEngineState(vehicleid, 0), VehInfo[vehicleid][Fuel] = 0;
    }
    VehicleTimer[vehicleid] = SetTimerEx("VehicleUpdate",1000,0,"d",vehicleid);
	return 1;
}
function PlayerUpdate(playerid)
{
	//SCM(playerid,0,"UPDATE");
	if(GetPVarInt(playerid,"spawned")==1)
	{
			//printf("SPEED = %d",GetPlayerSpeed(playerid));
		UpdateAFK(playerid);

		SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);

		UpdateMoney(playerid);
	}
	PlayerTimer[playerid] = SetTimerEx("PlayerUpdate", 1000, 0, "d", playerid);
}

stock GetWS(weaponid)
{
    switch(weaponid)
    {
        case 0,1: return 0;
        case 2..9: return 1;
        case 10..15: return 10;
        case 16..18,39: return 8;
        case 22..24: return 2;
        case 25..27: return 3;
        case 28,29,32: return 4;
        case 30,31: return 5;
        case 33,34: return 6;
        case 35..38: return 7;
        case 40: return 12;
        case 41..43: return 9;
        case 44..46: return 11;
    }
    return -1;
}

function FindPlayerInTable(playerid)
{
    new cmdstr[128];
    LoadPlayerTextDraws(playerid);

	SetPlayerInterior(playerid, playerid+1);
	//TogglePlayerSpectating(playerid, true);
	
	
	new rows;
    cache_get_row_count(rows);
    
	printf("ERROR = %s %d",mysql_errno(),mysql_errno());
	printf("NAME = %s",Name(playerid));
	printf("NUM ROWS = %d",rows);
	
    

    if(!rows)
    {
        //============================================================Регистрация
    	for(new i = 0;i < sizeof(TextDraw); i++)
        {
            TextDrawShowForPlayer(playerid,TextDraw[i]);
        }
        
		PlayerTextDrawShow(playerid,TextName[playerid]);
		PlayerTextDrawShow(playerid,TextPass[playerid]);
		PlayerTextDrawShow(playerid,TextMail[playerid]);
		PlayerTextDrawShow(playerid,TextSex[playerid]);
		PlayerTextDrawShow(playerid,TextRace[playerid]);
		PlayerTextDrawShow(playerid,TextAccept[playerid]);
		
		SelectTextDraw(playerid,COLOR_LIGHTBLUE);
		
		PlayerTextDrawSetString(playerid,TextName[playerid],Name(playerid));
		PlayerInfo[playerid][pSex] = 1;
		PlayerInfo[playerid][pRace] = 1;
    }
    else
    {
		
		
 		cache_get_value_name(0, "pPassword",PlayerInfo[playerid][pPassword],20);
 		
		printf("USERID = %d",PlayerInfo[playerid][pID]);
		
		//Авторизация

		format(cmdstr,sizeof(cmdstr),"%s добро пожаловать в  RolePlay\nУкажите пароль:",Name(playerid));
		SPD(playerid,2,3,"Авторизация",cmdstr,"Войти","Выход");
		
       // ShowPlayerDialog(playerid, dLogind, DIALOG_STYLE_INPUT, "Авторизация", "Введите пароль от аккаунта для того, чтоб продолжить игру:", "Вход", "Выход");
        //cache_get_value_name(0, "password", pInfo[playerid][pPassword], 31);
    }
    return 1;
}

function UploadPlayerAccount(playerid)
{
    cache_get_value_name_int(0, "pID",PlayerInfo[playerid][pID]);
	cache_get_value_name(0, "pName",PlayerInfo[playerid][pName],32);
	cache_get_value_name_int(0, "pLevel",PlayerInfo[playerid][pLevel]);
	cache_get_value_name_int(0, "pSex",PlayerInfo[playerid][pSex]);
	cache_get_value_name_int(0, "pSkin",PlayerInfo[playerid][pSkin]);
	cache_get_value_name_int(0, "pRace",PlayerInfo[playerid][pRace]);
	cache_get_value_name(0, "pMail",PlayerInfo[playerid][pMail],50);
	cache_get_value_name_int(0, "pStory",PlayerInfo[playerid][pStory]);
	cache_get_value_name_int(0, "pMoney",PlayerInfo[playerid][pMoney]);
	cache_get_value_name_float(0, "pHealth",PlayerInfo[playerid][pHealth]);
	cache_get_value_name_float(0, "pArmour",PlayerInfo[playerid][pArmour]);
	
	
	
	printf("LEVEL: %d",PlayerInfo[playerid][pLevel]);
	printf("SKIN: %d",PlayerInfo[playerid][pSkin]);
	printf("MAIL: %s",PlayerInfo[playerid][pMail]);
	printf("ADMIN: %d",PlayerInfo[playerid][pAdmin]);
	printf("PID: %d",PlayerInfo[playerid][pID]);
	
	PlayerLoggedIn[playerid]=true;
	GivePlayerMoney(playerid,PlayerInfo[playerid][pMoney]);
	//TogglePlayerSpectating(playerid, false);
	
	new cmdstr[128];
	format(cmdstr,sizeof(cmdstr),"SELECT * FROM `admins` WHERE `pID` = '%d'",PlayerInfo[playerid][pID]);
	mysql_tquery(mysql_connect_ID, cmdstr, "LoadAdmins", "i", playerid);
	printf("QUERY IN WEAPONS = %s",cmdstr);
	printf("PLID = %d",PlayerInfo[playerid][pID]);
	
	format(cmdstr,sizeof(cmdstr),"SELECT * FROM `player_weapons` WHERE `pwID` = '%d'",PlayerInfo[playerid][pID]);
	mysql_tquery(mysql_connect_ID, cmdstr, "LoadPlayerWeapons", "i", playerid);
	printf("QUERY IN WEAPONS = %s",cmdstr);
	printf("PLID = %d",PlayerInfo[playerid][pID]);
	
	format(cmdstr,sizeof(cmdstr),"SELECT * FROM `player_weapon_skills` WHERE `pID` = '%d'",PlayerInfo[playerid][pID]);
	mysql_tquery(mysql_connect_ID, cmdstr, "LoadPlayerWeaponSkills", "i", playerid);
	printf("QUERY IN WEAPONS = %s",cmdstr);
	printf("PLID = %d",PlayerInfo[playerid][pID]);
	
	format(cmdstr,sizeof(cmdstr),"SELECT * FROM `player_specials` WHERE `pID` = '%d'",PlayerInfo[playerid][pID]);
	mysql_tquery(mysql_connect_ID, cmdstr, "LoadPlayerSpecials", "i", playerid);
	printf("QUERY IN WEAPONS = %s",cmdstr);
	printf("PLID = %d",PlayerInfo[playerid][pID]);
	
	format(cmdstr,sizeof(cmdstr),"SELECT * FROM `player_licenses` WHERE `pID` = '%d'",PlayerInfo[playerid][pID]);
	mysql_tquery(mysql_connect_ID, cmdstr, "LoadPlayerLicenses", "i", playerid);
	
 	printf("QUERY IN WEAPONS = %s",cmdstr);
	printf("PLID = %d",PlayerInfo[playerid][pID]);

	printf("BIL VIZOV SPAWNA!");
	SpawnPlayer(playerid);
    SendClientMessage(playerid, COLOR_WHITE, "Вы успешно авторизировались!");
    return 1;
}

function UploadPlayerAccountNumber(playerid) PlayerInfo[playerid][pID] = cache_insert_id();

stock CreateNewAccount(playerid)
{
    PlayerInfo[playerid][pHealth] = 100.0;
 	PlayerInfo[playerid][pArmour] = 0;
 	
	new query_string[512];
    format(query_string,sizeof(query_string),"INSERT INTO `players`(pName,pPassword,pLevel,pSex,pSkin,pRace,pMail,pStory,pHealth,pArmour)\
	VALUES('%s','%s','%d','%d','%d','%d','%s','%d', '%f', '%f')",Name(playerid),PlayerInfo[playerid][pPassword],PlayerInfo[playerid][pLevel],PlayerInfo[playerid][pSex],PlayerInfo[playerid][pSkin],PlayerInfo[playerid][pRace],\
	PlayerInfo[playerid][pMail],PlayerInfo[playerid][pStory],PlayerInfo[playerid][pHealth],PlayerInfo[playerid][pArmour]);
	
	mysql_tquery(mysql_connect_ID, query_string, "UploadPlayerAccountNumber", "i", playerid);

	//TogglePlayerSpectating(playerid, false);
	firstspawn[playerid] = 1;
	TogglePlayerControllable(playerid,1);
	PlayerLoggedIn[playerid]=true;
 	ClearAnimations(playerid);
 	
	SpawnPlayer(playerid);
    return 1;
}
function LoadAdmins(playerid)
{
    cache_get_value_name_int(0, "pAdmin",PlayerInfo[playerid][pAdmin]);
	cache_get_value_name(0, "pAdminCode",PlayerInfo[playerid][pAdminCode],50);
}
function LoadPlayerWeaponSkills(playerid)
{
    cache_get_value_name_int(0, "pDeagleSkill",PlayerInfo[playerid][pDeagleSkill]);
    return 1;
}
function LoadPlayerSpecials(playerid)
{
    cache_get_value_name_int(0, "pLatchKey",PlayerInfo[playerid][pLatchkey]);
    return 1;
}
function LoadPlayerLicenses(playerid)
{
    cache_get_value_name_int(0, "pDriveLic",PlayerInfo[playerid][pDriveLic]);
	cache_get_value_name_int(0, "pGunLic",PlayerInfo[playerid][pGunLic]);
	return 1;
}

stock GetXYInFrontOfPoint(Float:x, Float:y, &Float:x2, &Float:y2, Float:A, Float:distance)
{
    x2 = x + (distance * floatsin(-A, degrees));
    y2 = y + (distance * floatcos(-A, degrees));
}
stock GetVehicleDriver(vid)
{
     foreach(new playerid : Player)
     {
          if(!IsPlayerConnected(playerid)) continue;
          if(GetPlayerVehicleID(playerid) == vid && GetPVarInt(playerid,"ispassenger") == 0) return playerid;
     }
     return 0;
}
/*IsPlayerInWater(playerid)
{
        new Float:FXF_wposX,Float:FXF_wposY,Float:FXF_wposZ;
        GetPlayerPos(playerid,FXF_wposX,FXF_wposY,FXF_wposZ);
        if((FXF_wposZ > 0.00) || IsPlayerInRangeOfPoint(playerid,5,1808.2019,1424.5392,-2230.5024)
		|| IsPlayerInRangeOfPoint(playerid,50,1242,-2380,8.31)) return 0;
        else if((FXF_wposZ < 0.00) && (FXF_wposZ > -1.00)) return 1;
        else if(FXF_wposZ < -1.00) return 1;
        return 0;
}*/
/*CheckCheat(playerid)
{
	CheckAirBreak(playerid);
	return 1;
}*/
/**/


