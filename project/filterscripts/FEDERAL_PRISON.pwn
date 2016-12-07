// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <streamer>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    new tmpobjid;
	new startcount = GetTickCount();
	//========================================================================NEW AIRPOTR SPAWN=============================================
	CreateDynamicObject(8546, 1028.43408, -350.57019, 69.92440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1028.43408, -318.23019, 69.92640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1028.43408, -296.67020, 69.92240,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1068.39404, -318.23019, 69.92440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1068.39404, -296.67020, 69.92040,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1103.87402, -296.67020, 69.92440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1068.43213, -350.57019, 69.92240,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1103.87402, -318.23019, 69.92840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8546, 1103.87402, -350.57019, 69.92440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1020.88788, -366.14630, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1009.26288, -366.10779, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1039.24390, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1051.24585, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1063.24792, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1075.24988, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1087.25195, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1099.25391, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1111.25586, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1123.25793, -366.17429, 73.36220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(16327, 1012.21332, -363.09259, 73.30540,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16327, 1120.46472, -363.12939, 73.30640,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1123.32385, -354.13730, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1123.32385, -342.12930, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1123.32385, -330.12131, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1123.32385, -318.11331, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1123.32385, -306.10529, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1123.32385, -294.09729, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1123.32385, -282.08929, 73.36220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1009.26288, -354.09979, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1009.26288, -342.09180, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1009.26288, -330.08380, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1009.26288, -318.07581, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1009.26288, -306.06781, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1009.26288, -294.05981, 73.36220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 1111.31592, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1099.30786, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1087.29993, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1075.29187, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1063.28394, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1051.27588, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1039.26794, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1027.25989, -282.08929, 73.36220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1015.33087, -282.08929, 73.35220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1009.32489, -282.09131, 73.36420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16327, 1120.46472, -285.12640, 73.30640,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(16327, 1012.21332, -285.08960, 73.30640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1015.33087, -282.08929, 73.35220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19913, 1042.24438, -288.01260, 73.64620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19913, 1092.19312, -288.00531, 73.64620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19913, 1015.06238, -312.95450, 73.64620,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19913, 1015.06042, -340.84549, 73.64620,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19913, 1057.30042, -359.67410, 73.64820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19913, 1092.24939, -359.67609, 73.64620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19913, 1117.20581, -334.69559, 73.64420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19913, 1117.20386, -313.04489, 73.64620,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(985, 1017.24872, -365.88171, 75.14510,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2774, 1027.92224, -366.66110, 68.22480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2774, 1020.28540, -366.66351, 68.22480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8168, 1029.71802, -362.25381, 75.10060,   0.00000, 0.00000, -75.00000);
	CreateDynamicObject(10079, 1027.93994, -367.11249, 83.48470,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(10079, 1020.20490, -367.11249, 83.48470,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1024.11438, -368.72504, 71.62340,   0.00000, 51.00000, 90.00000);
	CreateDynamicObject(16327, 1034.96326, -363.09259, 73.30540,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(4079, 1080.61438, -313.31201, 85.51800,   0.00000, 0.00000, -45.50000);
	CreateDynamicObject(19913, 1037.83691, -340.98996, 73.64420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19913, 1043.31946, -319.68933, 54.13220,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2774, 1038.31177, -315.72879, 68.22480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(964, 1038.32129, -315.76968, 80.39510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, 1036.04236, -354.79868, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1016.83276, -360.96216, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1016.83282, -351.40421, 73.31800,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1016.83282, -341.84619, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1016.83282, -332.28821, 73.31800,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1016.83282, -322.73019, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19399, 1020.18005, -354.01218, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -350.44821, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -347.37021, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -343.80621, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -340.40421, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -337.00220, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -333.92419, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -331.00821, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19913, 1014.97217, -358.54935, 54.10920,   0.00000, 90.00000, 180.00000);
	CreateDynamicObject(2774, 1027.50696, -358.56796, 68.22480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2774, 1020.54102, -358.56799, 68.22480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(985, 1017.53748, -358.48410, 75.03310,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(964, 1027.48181, -358.60413, 80.39510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(964, 1020.52820, -358.54654, 80.39510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19913, 1040.01978, -305.88531, 73.64620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, 1036.04236, -345.16971, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1036.23669, -335.58066, 73.31800,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1036.04236, -326.09369, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1036.04236, -321.32471, 73.31800,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(2774, 1038.31177, -306.19080, 68.22480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(964, 1038.32129, -305.98071, 80.39510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(985, 1038.28210, -310.94232, 75.03310,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19880, 1043.75378, -314.82721, 76.43640,   0.00000, 0.00000, 89.00000);
	CreateDynamicObject(19880, 1117.52625, -314.82721, 78.14040,   0.00000, 0.00000, 89.00000);
	CreateDynamicObject(19447, 1016.83282, -313.37021, 73.31800,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 1016.83282, -310.71021, 73.31890,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19399, 1020.18011, -327.75320, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -324.18820, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -327.75320, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -321.08820, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -317.67819, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -314.11319, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -310.70319, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -354.13126, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1020.18011, -324.18820, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -350.87631, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -347.77631, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -344.52130, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -341.11130, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -337.70129, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -334.29129, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -331.03629, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -327.78131, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -324.52631, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -320.96130, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1032.72693, -317.70630, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(4640, 1042.90894, -308.03189, 75.01720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 1096.53357, -339.68640, 73.35730,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 1058.46960, -339.68640, 73.35630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1496, 1037.80408, -317.24734, 73.42560,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(8674, 1064.73157, -335.08917, 78.31950,   0.00000, 0.00000, -0.60000);
	CreateDynamicObject(8674, 1055.90515, -331.37091, 78.31950,   0.00000, 0.00000, -45.60000);
	CreateDynamicObject(8674, 1048.67761, -324.01517, 78.31950,   0.00000, 0.00000, -45.60000);
	CreateDynamicObject(8674, 1075.07727, -335.10553, 78.31950,   0.00000, 0.00000, 0.40000);
	CreateDynamicObject(8674, 1078.51331, -335.07120, 78.31950,   0.00000, 0.00000, 0.40000);
	CreateDynamicObject(8674, 1086.39233, -330.63287, 78.31950,   0.00000, 0.00000, 58.50000);
	CreateDynamicObject(8674, 1091.63184, -330.51459, 78.31950,   0.00000, 0.00000, -0.30000);
	CreateDynamicObject(8674, 1097.51697, -330.54440, 78.31950,   0.00000, 0.00000, -0.30000);
	CreateDynamicObject(8674, 1106.97742, -327.66708, 78.31950,   0.00000, 0.00000, 34.00000);
	CreateDynamicObject(8674, 1107.68896, -327.18188, 78.31950,   0.00000, 0.00000, 34.00000);
	CreateDynamicObject(3279, 1068.94250, -313.70108, 82.05320,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 1092.07874, -313.79913, 82.05320,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3109, 1071.64099, -306.77768, 83.38690,   0.00000, 0.00000, 269.00000);
	CreateDynamicObject(3109, 1088.25586, -306.74109, 83.38690,   0.00000, 0.00000, 271.00000);
	CreateDynamicObject(975, 1081.16663, -329.29233, 74.90410,   0.00000, 0.00000, 59.00000);
	CreateDynamicObject(10675, 1050.02332, -296.25839, 76.47850,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19913, 1069.93115, -327.62357, 71.88420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3819, 1043.09131, -356.76221, 74.30940,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(3819, 1052.92578, -356.75800, 74.30940,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1052.78101, -354.02328, 71.57860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1043.24500, -354.02328, 71.57800,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1043.24500, -337.33530, 71.57800,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1052.78101, -337.33530, 71.57600,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1052.78101, -337.33530, 71.57860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1062.31702, -337.33530, 71.57800,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1062.31702, -354.02328, 71.57800,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1038.47009, -349.29419, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1038.47009, -342.06000, 71.57970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1067.07813, -342.06000, 71.57970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1067.07813, -349.29419, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1052.92310, -342.06000, 71.57970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1052.92310, -349.29419, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1041.52808, -345.76559, 71.57970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19399, 1039.99036, -341.04028, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1039.99036, -350.57629, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1065.46936, -341.04031, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1063.87805, -345.76559, 71.57970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19399, 1065.46936, -350.57629, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19399, 1052.83679, -345.93607, 71.58860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(14782, 1064.24060, -334.60687, 74.35150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3819, 1042.83826, -334.58691, 74.30940,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3819, 1052.37427, -334.58691, 74.30940,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3819, 1062.61084, -356.75800, 74.30940,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(947, 1065.01880, -345.87711, 75.48420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(947, 1040.59875, -345.87711, 75.48420,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1278, 1038.52588, -337.39319, 71.51250,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(1278, 1067.09973, -337.33661, 71.51250,   0.00000, 0.00000, -45.00000);
	CreateDynamicObject(1278, 1067.02466, -354.06229, 71.51250,   0.00000, 0.00000, -135.00000);
	CreateDynamicObject(1278, 1038.59851, -353.87341, 71.51250,   0.00000, 0.00000, -225.00000);
	CreateDynamicObject(14791, 1107.21814, -354.56229, 75.29300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14782, 1098.43494, -329.97223, 74.35150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2629, 1096.78149, -357.96057, 73.34170,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2629, 1101.17029, -357.97729, 73.34170,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2629, 1098.95032, -357.97729, 73.34170,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3819, 1114.61926, -355.18610, 74.16180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2913, 1100.71838, -358.51541, 74.31090,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2913, 1098.46240, -358.51541, 74.31090,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2913, 1096.75037, -358.83313, 73.60590,   0.00000, 90.00000, 18.00000);
	CreateDynamicObject(2628, 1097.05969, -355.07050, 73.31440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2628, 1097.05969, -353.19049, 73.31440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19445, 1091.88245, -335.17819, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1091.88245, -344.70020, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1091.88245, -354.29321, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1091.88245, -354.83621, 71.57900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9345, 1077.57092, -349.39023, 73.49810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2649, 1072.90283, -335.85010, 73.86010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2649, 1076.34180, -335.85010, 73.86010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(671, 1074.06641, -349.52356, 73.74580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(671, 1081.79492, -350.27484, 73.74580,   0.00000, 0.00000, -62.00000);
	CreateDynamicObject(19445, 1087.10364, -352.44669, 71.57860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1278, 1091.84009, -352.47281, 71.51250,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1278, 1117.01575, -345.16013, 71.51250,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18201, 1027.76428, -291.07642, 74.30650,   0.00000, 0.00000, -179.00000);
	CreateDynamicObject(934, 1030.38489, -291.75967, 74.55440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3427, 1019.98560, -302.22867, 64.43280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1684, 1030.34668, -298.23981, 74.94270,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 1111.91516, -338.53470, 73.28320,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(3928, 1108.50598, -315.47397, 98.29290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3928, 1052.77759, -315.43176, 98.29290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3928, 1070.74121, -297.27872, 98.29290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3928, 1091.74792, -297.13095, 98.29290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1480, 1115.24768, -334.74536, 74.52010,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1480, 1113.51965, -334.74539, 74.52010,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1480, 1111.79175, -334.74539, 74.52010,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16, 1111.84778, -337.49759, 74.35700,   90.00000, 90.00000, -179.00000);
	CreateDynamicObject(1280, 1107.13586, -341.83920, 73.75940,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1280, 1107.18640, -337.85867, 73.75940,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1330, 1107.28381, -339.75259, 73.81230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1436, 1112.80078, -342.08835, 73.51010,   0.00000, 180.00000, 0.00000);
	CreateDynamicObject(1436, 1110.59729, -342.08832, 73.04010,   0.00000, 180.00000, 0.00000);
	CreateDynamicObject(2388, 1110.39575, -339.83160, 73.04010,   0.00000, 180.00000, 0.00000);
	CreateDynamicObject(19622, 1111.93372, -337.53241, 75.87710,   0.00000, -90.00000, -90.00000);
	CreateDynamicObject(2371, 1115.37671, -338.00168, 73.27060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2371, 1115.37671, -341.51169, 73.27060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3524, 1111.96021, -338.22021, 73.32630,   0.00000, 180.00000, 0.00000);
	CreateDynamicObject(3524, 1111.96021, -336.84021, 73.32630,   0.00000, 180.00000, 0.00000);
	CreateDynamicObject(19622, 1111.93372, -338.91241, 75.44210,   0.00000, -90.00000, -90.00000);
	CreateDynamicObject(3524, 1111.96021, -339.58521, 72.86130,   0.00000, 180.00000, 0.00000);
	CreateDynamicObject(2630, 1109.43958, -334.89587, 73.37130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2630, 1108.17957, -334.89590, 73.37130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19445, 1096.75391, -348.32559, 71.57860,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1106.38489, -348.32559, 71.57920,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19445, 1112.37891, -348.32559, 71.57800,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(642, 1094.74292, -346.48547, 74.66790,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(642, 1094.74292, -342.40549, 74.66790,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(642, 1094.74292, -338.32550, 74.66790,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 1107.44348, -332.58929, 74.10070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 1110.14954, -332.58929, 74.10070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 1112.85547, -332.58929, 74.10070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 1115.80750, -332.58929, 74.10070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, 1037.87500, -346.26370, 80.73400,   0.00000, 0.00000, 0.00000);

	
	printf("PRISON FEDERAL loaded! %d ms",GetTickCount()-startcount);
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