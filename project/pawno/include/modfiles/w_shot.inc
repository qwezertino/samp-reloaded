#include <a_samp>
#include <ColAndreas>

forward OnPlayerWatherShot(playerid, Float:x, Float:y, Float:z);
forward UpdateShotWather(playerid);
new loopshotr[MAX_PLAYERS];
enum Matrix
{
	mp_PITCH,
	mp_ROLL,
	mp_YAW,
	mp_POS
};

enum MatrixID
{
	Float:mi_X,
	Float:mi_Y,
	Float:mi_Z
};


public UpdateShotWather(playerid)
{
	new Keys,ud,lr;
	GetPlayerKeys(playerid,Keys,ud,lr);
	if (!(Keys & KEY_FIRE) || GetVehicleModel(GetPlayerVehicleID(playerid)) != 407) return KillTimer(loopshotr[playerid]);
	new Float:sx, Float:sy, Float:sz, Float:rx, Float:rz;
	GetCameraRotation(playerid, rx, rz);
	if(rx < 240) rx = 250; else if(rx > 285) rx = 295; else rx += 10.0;
	PositionFromVehicle(GetPlayerVehicleID(playerid), 0.0, 1.63, 1.725, sx, sy, sz);
	if(CA_RayCastLine(sx, sy, sz, sx+floatcos(rz, degrees) * 25.0, sy+floatsin(rz, degrees) * 25.0, sz+floatcos(rx, degrees) * 25.0, sx, sy, sz)) return OnPlayerWatherShot(playerid, sx, sy, sz);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 407) loopshotr[playerid] = SetTimerEx("UpdateShotWather", 200, true, "d", playerid);
	#if defined est_OnPlayerKeyStateChange
	    est_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#endif
 	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange est_OnPlayerKeyStateChange
#if defined est_OnPlayerKeyStateChange
forward est_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerExitVehicle(playerid, vehicleid)
{
   	if(GetVehicleModel(vehicleid) == 407) KillTimer(loopshotr[playerid]);
#if defined est_OnPlayerExitVehicle
    est_OnPlayerExitVehicle(playerid, vehicleid);
#endif
    return 1;
}
#if defined _ALS_OnPlayerExitVehicle
    #undef OnPlayerExitVehicle
#else
    #define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle est_OnPlayerExitVehicle
#if defined est_OnPlayerExitVehicle
forward est_OnPlayerExitVehicle(playerid, vehicleid);
#endif


stock GetCameraRotation(playerid,&Float:rx,&Float:rz)
{
	new Float:mx,Float:my,Float:mz;
	GetPlayerCameraFrontVector(playerid,mx,my,mz);
	NormalizateRotation(-(acos(mz)),rx);
	NormalizateRotation((atan2(my,mx)),rz);
}

stock NormalizateRotation(Float:rotation,&Float:cr)
{
	cr = rotation;
	while(cr < 0.0) cr += 360.0;
	while(cr >= 360.0) cr -= 360.0;
}

stock GetMatrix(vehicleid,Mat4x3[Matrix][MatrixID])
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:w,
		Float:Pos[3];

	GetVehicleRotationQuat(vehicleid,w,x,y,z);
	GetVehiclePos(vehicleid,Pos[0],Pos[1],Pos[2]);
	new
		Float:x2 = x * x,
	 	Float:y2 = y * y,
	 	Float:z2 = z * z,
	 	Float:xy = x * y,
	 	Float:xz = x * z,
		Float:yz = y * z,
		Float:wx = w * x,
		Float:wy = w * y,
		Float:wz = w * z;
	Mat4x3[mp_PITCH][mi_X] = 1.0 - 2.0 * (y2 + z2);
	Mat4x3[mp_PITCH][mi_Y] = 2.0 * (xy - wz);
	Mat4x3[mp_PITCH][mi_Z] = 2.0 * (xz + wy);
	Mat4x3[mp_ROLL][mi_X] = 2.0 * (xy + wz);
	Mat4x3[mp_ROLL][mi_Y] = 1.0 - 2.0 * (x2 + z2);
	Mat4x3[mp_ROLL][mi_Z] = 2.0 * (yz - wx);
 	Mat4x3[mp_YAW][mi_X] = 2.0 * (xz - wy);
 	Mat4x3[mp_YAW][mi_Y] = 2.0 * (yz + wx);
 	Mat4x3[mp_YAW][mi_Z] = 1.0 - 2.0 * (x2 + y2);
  	Mat4x3[mp_POS][mi_X] = Pos[0];
  	Mat4x3[mp_POS][mi_Y] = Pos[1];
  	Mat4x3[mp_POS][mi_Z] = Pos[2];

	return 1;
}

stock PositionFromVehicle(vehicle,Float:offX,Float:offY,Float:offZ,&Float:x,&Float:y,&Float:z)
{
	new
		Mat4x3[Matrix][MatrixID];

    GetMatrix(vehicle,Mat4x3);
	x = offX * Mat4x3[mp_PITCH][mi_X] + offY * Mat4x3[mp_ROLL][mi_X] + offZ * Mat4x3[mp_YAW][mi_X] + Mat4x3[mp_POS][mi_X];
	y = offX * Mat4x3[mp_PITCH][mi_Y] + offY * Mat4x3[mp_ROLL][mi_Y] + offZ * Mat4x3[mp_YAW][mi_Y] + Mat4x3[mp_POS][mi_Y];
	z = offX * Mat4x3[mp_PITCH][mi_Z] + offY * Mat4x3[mp_ROLL][mi_Z] + offZ * Mat4x3[mp_YAW][mi_Z] + Mat4x3[mp_POS][mi_Z];
	return 1;
}
