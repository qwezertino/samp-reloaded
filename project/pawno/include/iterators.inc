#include <foreach>
new Iterator:Vehicle<MAX_VEHICLES>;

stock foreach_wr_CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay, addsiren)
{
new veh = CreateVehicle(modelid, x, y, z, angle, color1, color2, respawn_delay, addsiren);
Itter_Add(Vehicle, veh);
return veh;
}
#if defined _ALS_CreateVehicle
#undef CreateVehicle
#else
#define _ALS_CreateVehicle
#endif
#define CreateVehicle(%0) foreach_wr_CreateVehicle(%0)

stock foreach_wr_AddStaticVehicleEx(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay, addsiren)
{
new veh = AddStaticVehicleEx(modelid, x, y, z, angle, color1, color2, respawn_delay, addsiren);
Itter_Add(Vehicle, veh);
return veh;
}
#if defined _ALS_AddStaticVehicleEx
#undef AddStaticVehicleEx
#else
#define _ALS_AddStaticVehicleEx
#endif
#define AddStaticVehicleEx(%0) foreach_wr_AddStaticVehicleEx(%0)

stock foreach_wr_AddStaticVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2)
{
new veh = AddStaticVehicle(modelid, x, y, z, angle, color1, color2);
Itter_Add(Vehicle, veh);
return veh;
}
#if defined _ALS_AddStaticVehicle
#undef AddStaticVehicle
#else
#define _ALS_AddStaticVehicle
#endif
#define AddStaticVehicle(%0) foreach_wr_AddStaticVehicle(%0)

stock foreach_wr_DestroyVehicle(veh)
{
Itter_Remove(Vehicle, veh);
return DestroyVehicle(veh);
}
#if defined _ALS_DestroyVehicle
#undef DestroyVehicle
#else
#define _ALS_DestroyVehicle
#endif
#define DestroyVehicle(%0) foreach_wr_DestroyVehicle(%0)