// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    new tmpobjid;
	//=============================================================LSPD_SANTA_MARIA_GARASH=====================
	tmpobjid = CreateDynamicObject(19377,541.890,-1757.341,-21.398,90.099,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14668, "711c", "forumstand1_LAe", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(7244,517.010,-1792.140,-14.479,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(10575,541.960,-1757.520,-21.639,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	
	printf("LSPD SANTA MARIA GARAGE loaded! %d ms",GetTickCount());
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif
