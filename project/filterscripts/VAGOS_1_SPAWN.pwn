// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    new tmpobjid;
	//=========================================================VAGOS_1_SPAWN=====================================
	tmpobjid = CreateDynamicObject(10575,2681.100,-1114.390,70.370,-1.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(1501,2688.639,-1114.369,68.500,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 5819, "buildtestlawn", "alleydoor8", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1291,2757.879,-1180.829,68.919,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1291,2747.360,-1207.719,66.330,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1291,2747.360,-1223.810,63.430,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1291,2747.360,-1240.739,60.409,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3877,2747.810,-1170.540,79.129,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3877,2747.870,-1136.439,79.129,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3877,2712.750,-1136.219,79.129,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3877,2712.659,-1170.599,79.129,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1257,2715.500,-1126.859,69.849,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1257,2744.419,-1121.489,69.849,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1696,2707.699,-1122.150,76.589,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1696,2707.699,-1112.229,76.589,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1696,2707.699,-1100.329,76.589,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1696,2694.020,-1100.329,76.589,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1696,2674.199,-1100.329,75.710,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1696,2662.010,-1100.329,75.699,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3033,2692.659,-1130.939,76.940,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3033,2692.659,-1124.260,76.940,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3033,2692.659,-1117.630,76.940,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3033,2672.689,-1117.630,76.940,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3033,2672.689,-1124.260,76.940,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3033,2672.689,-1130.939,76.940,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1285,2716.780,-1106.540,69.129,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1286,2716.780,-1106.099,69.129,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1287,2716.780,-1105.660,69.129,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1288,2716.780,-1105.219,69.129,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1289,2716.780,-1104.770,69.129,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1285,2743.320,-1171.890,69.129,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1287,2743.320,-1172.780,69.129,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1289,2743.320,-1172.339,69.129,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1236,2700.709,-1124.369,69.239,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1236,2700.729,-1121.540,69.239,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2677,2699.530,-1122.500,68.860,0.000,0.000,339.779,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(910,2693.449,-1117.310,69.849,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1219,2699.889,-1118.560,68.779,0.000,0.000,-26.579,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1299,2699.129,-1118.760,69.449,0.000,0.000,-28.739,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1462,2693.159,-1115.829,68.580,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(12957,2698.530,-1108.510,69.260,0.000,0.000,45.180,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1442,2700.139,-1113.729,69.180,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(18688,2700.129,-1113.930,67.990,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(850,2674.050,-1108.750,68.389,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(850,2669.469,-1110.270,68.410,0.000,0.000,-39.180,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1438,2665.959,-1107.089,68.379,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1438,2663.899,-1107.520,68.379,0.000,0.000,-46.979,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1440,2664.639,-1106.550,69.529,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3119,2700.300,-1116.969,68.870,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2673,2700.270,-1114.229,68.680,0.000,0.000,-86.699,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2673,2700.149,-1113.050,68.680,0.000,0.000,-42.959,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1368,2761.570,-1179.810,69.089,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1368,2750.919,-1179.810,69.089,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);

	
	printf("VAGOS SPAWN loaded! %d ms",GetTickCount());
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
