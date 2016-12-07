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

//================================================================================================================================
stock SCM(playerid,color,string[])
{
	new newcolor;
	new editstr[1024];
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
	//string[0] = 0;
	//return 1;
}
#if defined _ALS_SendClientMessage
    #undef SendClientMessage
#else
    #define _ALS_SendClientMessage
#endif
#define SendClientMessage SCM
//================================================================================================================================

