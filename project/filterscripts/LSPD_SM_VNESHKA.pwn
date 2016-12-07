// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    new tmpobjid;
	//===========================================================LSPD_SANTA_MARIA_VHESKA=====================================
	tmpobjid = CreateDynamicObject(1237,421.839,-1785.260,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(1237,473.170,-1762.040,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(1237,471.209,-1769.449,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(1237,485.690,-1762.040,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(1237,485.690,-1764.869,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(1237,485.690,-1767.609,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(1237,485.690,-1770.439,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
	tmpobjid = CreateDynamicObject(3337,434.320,-1784.650,4.539,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19962, "samproadsigns", "greenbackgroundsign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	tmpobjid = CreateDynamicObject(19477,440.724,-1806.771,7.766,0.000,0.000,-89.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "SANTA", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,442.225,-1806.769,7.766,0.000,0.000,-89.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "MARIA", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,443.484,-1806.767,7.766,0.000,0.000,-89.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "BAY", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,444.824,-1806.763,7.766,0.000,0.000,-89.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,446.564,-1806.760,7.766,0.000,0.000,-89.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "STATION", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,434.291,-1784.518,8.016,0.000,0.000,90.199,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "LOS SANTOS", 130, "Ariel", 60, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,434.291,-1784.518,7.636,0.000,0.000,90.199,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 130, "Ariel", 60, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19477,434.291,-1784.518,7.256,0.000,0.000,90.199,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(tmpobjid, 0, "DEPARTMENT", 130, "Ariel", 60, 1, 0xFFFFFFFF, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(9320,443.609,-1797.989,9.739,0.000,0.000,89.459,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2745,489.399,-1793.910,6.239,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,420.720,-1813.699,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,420.720,-1803.329,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,420.720,-1793.010,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,420.709,-1790.079,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(966,429.980,-1785.089,4.539,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(967,431.369,-1785.959,4.539,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,437.299,-1784.839,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,447.660,-1784.839,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,463.179,-1784.829,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,468.369,-1790.030,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,468.350,-1813.670,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,468.350,-1803.300,5.980,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,460.630,-1818.869,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,450.269,-1818.869,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,425.899,-1818.869,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,439.899,-1818.869,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8674,463.160,-1818.849,5.980,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(802,456.799,-1807.270,4.920,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(802,456.579,-1794.670,4.920,0.000,0.000,45.299,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(14402,465.489,-1816.859,5.179,0.000,0.000,-70.800,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(14402,454.510,-1816.849,5.179,0.000,0.000,-70.800,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(14402,446.549,-1816.910,5.179,0.000,0.000,-70.800,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(14402,472.329,-1790.829,5.179,0.000,0.000,-70.800,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,450.079,-1787.890,4.780,0.000,0.000,31.379,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,450.140,-1786.209,4.780,0.000,0.000,122.400,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,447.850,-1786.189,4.780,0.000,0.000,122.400,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,448.019,-1788.310,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,445.730,-1786.140,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,445.630,-1788.359,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,443.410,-1788.310,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,443.459,-1786.160,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,441.190,-1786.170,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,441.089,-1788.310,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,438.839,-1788.410,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,438.869,-1786.209,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,436.309,-1786.180,4.780,0.000,0.000,117.239,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(870,436.239,-1788.040,4.780,0.000,0.000,290.519,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8990,461.820,-1801.140,5.219,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(8990,456.809,-1801.109,5.219,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1364,452.079,-1804.640,5.320,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1364,435.029,-1804.709,5.320,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1360,438.929,-1791.250,5.280,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1360,448.079,-1791.250,5.280,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,459.579,-1795.349,4.980,0.000,0.000,65.339,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,457.959,-1795.609,4.980,0.000,0.000,104.699,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,459.959,-1807.030,4.980,0.000,0.000,79.559,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,458.309,-1806.219,4.980,0.000,0.000,-98.580,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,459.839,-1804.000,4.980,0.000,0.000,-12.359,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,459.970,-1800.640,4.980,0.000,0.000,-12.359,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,460.029,-1797.900,4.980,0.000,0.000,-12.359,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,458.299,-1798.209,4.980,0.000,0.000,-12.359,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,457.920,-1800.699,4.980,0.000,0.000,-12.359,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(817,457.869,-1803.739,4.980,0.000,0.000,-12.359,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(634,451.500,-1786.900,4.510,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(634,438.070,-1786.900,4.510,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(634,442.510,-1786.900,4.510,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(634,447.079,-1786.900,4.510,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(624,458.959,-1805.500,2.700,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(624,459.040,-1796.680,2.700,0.000,0.000,108.660,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(624,462.100,-1817.430,2.700,0.000,0.000,16.739,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(624,439.470,-1817.329,2.700,0.000,0.000,16.739,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1256,485.369,-1792.260,5.659,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1256,493.709,-1792.260,5.659,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19352,489.410,-1792.989,5.179,0.000,180.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(10575,479.160,-1761.579,6.500,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2614,443.529,-1806.800,6.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,458.140,-1785.790,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,434.239,-1785.790,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,434.899,-1813.989,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,446.089,-1813.989,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,456.589,-1813.989,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,467.179,-1813.989,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,467.660,-1785.790,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1297,467.660,-1785.790,7.730,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1886,456.220,-1790.979,11.680,20.000,0.000,-112.559,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1886,431.170,-1791.739,11.680,20.000,0.000,-158.160,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1886,431.820,-1804.410,11.680,20.000,0.000,-321.720,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1444,471.040,-1796.589,6.480,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1444,455.420,-1784.880,5.360,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19967,421.339,-1784.670,4.539,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19949,434.950,-1766.880,4.650,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19969,421.269,-1777.839,4.539,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19968,439.109,-1777.750,4.539,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3850,441.633,-1806.588,5.036,0.000,0.000,90.099,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3850,445.473,-1806.582,5.036,0.000,0.000,90.099,-1,-1,-1,300.000,300.000);
	
	printf("LSPD SANTA MARIA loaded! %d ms",GetTickCount());
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
