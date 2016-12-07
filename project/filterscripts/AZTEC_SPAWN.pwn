// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    new tmpobjid;
	//=======================================================AZTEC_SPAWN========================================

	//Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(12945,2167.419,-1781.199,12.050,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 5418, "idlewood3_lae", "sanpedmot3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 10, 5418, "idlewood3_lae", "sanpedmot3", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(2599,2170.219,-1787.479,12.970,0.000,0.000,-28.920,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 1208, "dynjunk", "junk_washer1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(620,2212.790,-1688.979,12.090,0.000,0.000,3.140,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2211.100,-1702.250,12.090,0.000,0.000,3.140,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2209.090,-1718.439,12.090,0.000,0.000,-87.760,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2218.510,-1661.459,12.090,0.000,0.000,-270.339,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2215.699,-1674.449,12.090,0.000,0.000,-309.220,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2198.479,-1671.420,12.090,0.000,0.000,-309.220,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2201.030,-1658.119,12.090,0.000,0.000,-270.339,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2195.820,-1687.099,12.090,0.000,0.000,3.140,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2194.500,-1702.069,12.090,0.000,0.000,3.140,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(620,2192.750,-1717.910,12.090,0.000,0.000,-87.760,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(5676,2165.798,-1806.467,14.460,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2185.290,-1813.719,15.680,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2189.360,-1813.719,15.680,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2193.429,-1813.719,15.680,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2183.209,-1815.800,15.680,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2195.500,-1815.800,15.680,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2195.500,-1819.969,15.680,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2195.500,-1824.130,15.680,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2195.500,-1828.280,15.680,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(970,2135.379,-1830.089,15.699,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(12987,2134.350,-1788.819,15.220,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1373,2206.959,-1726.890,14.939,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1374,2206.280,-1725.329,13.949,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1374,2194.330,-1738.920,13.949,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1373,2193.649,-1737.280,15.079,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1226,2164.689,-1791.920,16.399,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2719,2167.199,-1786.699,14.159,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(1445,2157.719,-1787.719,13.130,0.000,0.000,38.759,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2642,2157.679,-1787.160,14.779,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(3468,2160.649,-1787.040,13.189,0.000,0.000,-8.100,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19326,2162.330,-1786.459,14.399,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2924,2155.219,-1786.050,13.710,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);

	
	printf("AZTEC SPAWN loaded! %d ms",GetTickCount());
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
