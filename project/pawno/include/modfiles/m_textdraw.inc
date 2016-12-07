new Text: TextDraw[60];
new PlayerText: TextName[MAX_PLAYERS];
new PlayerText: TextPass[MAX_PLAYERS];
new PlayerText: TextMail[MAX_PLAYERS];
new PlayerText: TextSex[MAX_PLAYERS];

new PlayerText: TextRace[MAX_PLAYERS];

new PlayerText: TextAccept[MAX_PLAYERS];

new Text: td_intro[5];

new PlayerText:SpeedoDraw[8][MAX_PLAYERS];

new Text:LogoText;

//=========================================Выбор истории тд
new PlayerText:history[8][MAX_PLAYERS];
//====================================================

stock LoadPlayerTextDraws(playerid)
{
	//=====================================================SPEEDOMETR TEXDRAW=============================
	SpeedoDraw[0][playerid] = CreatePlayerTextDraw(playerid, 491.999877, 351.189178, "usebox");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[0][playerid], 0.000000, 6.383331);
	PlayerTextDrawTextSize(playerid, SpeedoDraw[0][playerid], 610.667114, 0.000000);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[0][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[0][playerid], 0);
	PlayerTextDrawUseBox(playerid, SpeedoDraw[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, SpeedoDraw[0][playerid], 102);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[0][playerid], 0);
	PlayerTextDrawFont(playerid, SpeedoDraw[0][playerid], 0);

	SpeedoDraw[1][playerid] = CreatePlayerTextDraw(playerid, 488.666656, 349.688873, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[1][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedoDraw[1][playerid], 2.333343, 60.977760);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[1][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[1][playerid], 255);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[1][playerid], 0);
	PlayerTextDrawFont(playerid, SpeedoDraw[1][playerid], 4);

	SpeedoDraw[2][playerid] = CreatePlayerTextDraw(playerid, 612.000122, 349.444396, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[2][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedoDraw[2][playerid], 2.333343, 60.977760);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[2][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[2][playerid], 255);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[2][playerid], 0);
	PlayerTextDrawFont(playerid, SpeedoDraw[2][playerid], 4);

	SpeedoDraw[3][playerid] = CreatePlayerTextDraw(playerid, 522.666625, 353.422302, "");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[3][playerid], 0.329999, 2.068739);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[3][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[3][playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedoDraw[3][playerid], 51);
	PlayerTextDrawFont(playerid, SpeedoDraw[3][playerid], 2);
	PlayerTextDrawSetProportional(playerid, SpeedoDraw[3][playerid], 1);

	SpeedoDraw[4][playerid] = CreatePlayerTextDraw(playerid, 534.333557, 386.363220, "");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[4][playerid], 0.329999, 2.068739);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[4][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[4][playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedoDraw[4][playerid], 51);
	PlayerTextDrawFont(playerid, SpeedoDraw[4][playerid], 2);
	PlayerTextDrawSetProportional(playerid, SpeedoDraw[4][playerid], 1);

	SpeedoDraw[5][playerid] = CreatePlayerTextDraw(playerid, 490.000000, 378.311157, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[5][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedoDraw[5][playerid], 123.333343, 3.318481);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[5][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[5][playerid], 255);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[5][playerid], 0);
	PlayerTextDrawFont(playerid, SpeedoDraw[5][playerid], 4);

	SpeedoDraw[6][playerid] = CreatePlayerTextDraw(playerid, 492.333404, 380.385284, "L");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[6][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[6][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[6][playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedoDraw[6][playerid], 51);
	PlayerTextDrawFont(playerid, SpeedoDraw[6][playerid], 2);
	PlayerTextDrawSetProportional(playerid, SpeedoDraw[6][playerid], 1);

	SpeedoDraw[7][playerid] = CreatePlayerTextDraw(playerid, 492.666778, 394.244598, "E");
	PlayerTextDrawLetterSize(playerid, SpeedoDraw[7][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, SpeedoDraw[7][playerid], 1);
	PlayerTextDrawColor(playerid, SpeedoDraw[7][playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, SpeedoDraw[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedoDraw[7][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedoDraw[7][playerid], 51);
	PlayerTextDrawFont(playerid, SpeedoDraw[7][playerid], 2);
	PlayerTextDrawSetProportional(playerid, SpeedoDraw[7][playerid], 1);
	
	
	
	//====================================================HISTORY TEXT===================================
    history[1][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 129.683288, "history1");
	PlayerTextDrawLetterSize(playerid, history[1][playerid], 0.266339, 1.547500);
	PlayerTextDrawAlignment(playerid, history[1][playerid], 1);
	PlayerTextDrawColor(playerid, history[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[1][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[1][playerid], 51);
	PlayerTextDrawFont(playerid, history[1][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[1][playerid], 1);

	history[2][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 149.683288, "history[2]");
	PlayerTextDrawLetterSize(playerid, history[2][playerid], 0.270087, 1.722499);
	PlayerTextDrawAlignment(playerid, history[2][playerid], 1);
	PlayerTextDrawColor(playerid, history[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[2][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[2][playerid], 51);
	PlayerTextDrawFont(playerid, history[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[2][playerid], 1);

	history[3][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 169.683288, "history[3]");
	PlayerTextDrawLetterSize(playerid, history[3][playerid], 0.270087, 1.722499);
	PlayerTextDrawAlignment(playerid, history[3][playerid], 1);
	PlayerTextDrawColor(playerid, history[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[3][playerid], 51);
	PlayerTextDrawFont(playerid, history[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[3][playerid], 1);

	history[4][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 189.683288, "history[4]");
	PlayerTextDrawLetterSize(playerid, history[4][playerid], 0.270087, 1.722499);
	PlayerTextDrawAlignment(playerid, history[4][playerid], 1);
	PlayerTextDrawColor(playerid, history[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[4][playerid], 51);
	PlayerTextDrawFont(playerid, history[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[4][playerid], 1);

	history[5][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 209.683288, "history[5]");
	PlayerTextDrawLetterSize(playerid, history[5][playerid], 0.270087, 1.722499);
	PlayerTextDrawAlignment(playerid, history[5][playerid], 1);
	PlayerTextDrawColor(playerid, history[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[5][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[5][playerid], 51);
	PlayerTextDrawFont(playerid, history[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[5][playerid], 1);

	history[6][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 229.683288, "history[6]");
	PlayerTextDrawLetterSize(playerid, history[6][playerid], 0.270087, 1.722499);
	PlayerTextDrawAlignment(playerid, history[6][playerid], 1);
	PlayerTextDrawColor(playerid, history[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[6][playerid], 51);
	PlayerTextDrawFont(playerid, history[6][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[6][playerid], 1);

	history[7][playerid] = CreatePlayerTextDraw(playerid, 414.287567, 249.683288, "history[7]");
	PlayerTextDrawLetterSize(playerid, history[7][playerid], 0.270087, 1.722499);
	PlayerTextDrawAlignment(playerid, history[7][playerid], 1);
	PlayerTextDrawColor(playerid, history[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid, history[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, history[7][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, history[7][playerid], 51);
	PlayerTextDrawFont(playerid, history[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid, history[7][playerid], 1);
	//======================================================NAME======================================
    TextName[playerid] = CreatePlayerTextDraw(playerid,70.732055, 129.333328, "");
	PlayerTextDrawLetterSize(playerid, TextName[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid,TextName[playerid], 1);
	PlayerTextDrawColor(playerid, TextName[playerid], -1);
	PlayerTextDrawSetShadow(playerid,TextName[playerid], 0);
	PlayerTextDrawSetOutline(playerid,TextName[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TextName[playerid], 255);
	PlayerTextDrawFont(playerid,TextName[playerid], 2);
	PlayerTextDrawSetProportional(playerid,TextName[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TextName[playerid], 0);
	//==================================================PASSWORD=================================================
	TextPass[playerid] = CreatePlayerTextDraw(playerid,71.669097, 163.750000, "");
	PlayerTextDrawLetterSize(playerid,TextPass[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid,TextPass[playerid], 1);
	PlayerTextDrawColor(playerid,TextPass[playerid], -1);
	PlayerTextDrawSetShadow(playerid,TextPass[playerid], 0);
	PlayerTextDrawSetOutline(playerid,TextPass[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TextPass[playerid], 255);
	PlayerTextDrawFont(playerid,TextPass[playerid], 2);
	PlayerTextDrawSetProportional(playerid,TextPass[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TextPass[playerid], 0);
	//=====================================================MAIL==================================================
	TextMail[playerid] = CreatePlayerTextDraw(playerid,70.732055, 199.916625, "");
	PlayerTextDrawLetterSize(playerid, TextMail[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid, TextMail[playerid], 1);
	PlayerTextDrawColor(playerid, TextMail[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TextMail[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TextMail[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TextMail[playerid], 255);
	PlayerTextDrawFont(playerid, TextMail[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TextMail[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextMail[playerid], 0);
	//======================================================SEX=============================================
    TextSex[playerid] = CreatePlayerTextDraw(playerid,70.263534, 234.916625, RusToGame("Мужской"));
	PlayerTextDrawLetterSize(playerid, TextSex[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid, TextSex[playerid], 1);
	PlayerTextDrawColor(playerid, TextSex[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TextSex[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TextSex[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TextSex[playerid], 255);
	PlayerTextDrawFont(playerid, TextSex[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TextSex[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextSex[playerid], 0);
	
 	
 	//=======================================================================RACE=============================================
 	
 	
 	TextRace[playerid] = CreatePlayerTextDraw(playerid,70.263534, 274.000000, RusToGame("Афроамериканец"));
	PlayerTextDrawLetterSize(playerid,TextRace[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid,TextRace[playerid], 1);
	PlayerTextDrawColor(playerid,TextRace[playerid], -1);
	PlayerTextDrawSetShadow(playerid,TextRace[playerid], 0);
	PlayerTextDrawSetOutline(playerid,TextRace[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TextRace[playerid], 255);
	PlayerTextDrawFont(playerid,TextRace[playerid], 2);
	PlayerTextDrawSetProportional(playerid,TextRace[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TextRace[playerid], 0);
	
	
	/*TextAsia[playerid] = CreatePlayerTextDraw(playerid,70.263534, 274.000000, RusToGame("Азиат"));
	PlayerTextDrawLetterSize(playerid,TextAsia[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid,TextAsia[playerid], 1);
	PlayerTextDrawColor(playerid,TextAsia[playerid], -1);
	PlayerTextDrawSetShadow(playerid,TextAsia[playerid], 0);
	PlayerTextDrawSetOutline(playerid,TextAsia[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TextAsia[playerid], 255);
	PlayerTextDrawFont(playerid,TextAsia[playerid], 2);
	PlayerTextDrawSetProportional(playerid,TextAsia[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TextAsia[playerid], 0);
	
 	
	
 	TextEuro[playerid] = CreatePlayerTextDraw(playerid,70.263534, 274.000000, RusToGame("Европеец"));
	PlayerTextDrawLetterSize(playerid,TextEuro[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid,TextEuro[playerid], 1);
	PlayerTextDrawColor(playerid,TextEuro[playerid], -1);
	PlayerTextDrawSetShadow(playerid,TextEuro[playerid], 0);
	PlayerTextDrawSetOutline(playerid,TextEuro[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TextEuro[playerid], 255);
	PlayerTextDrawFont(playerid,TextEuro[playerid], 2);
	PlayerTextDrawSetProportional(playerid,TextEuro[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TextEuro[playerid], 0);*/
 	//====================================================================ACCEPT=========================================
	TextAccept[playerid] = CreatePlayerTextDraw(playerid,270.620849, 331.283233, RusToGame("Подтвердить"));
	PlayerTextDrawLetterSize(playerid,TextAccept[playerid], 0.285679, 1.179998);
	PlayerTextDrawAlignment(playerid,TextAccept[playerid], 1);
	PlayerTextDrawColor(playerid,TextAccept[playerid], -1);
	PlayerTextDrawSetShadow(playerid,TextAccept[playerid], 0);
	PlayerTextDrawSetOutline(playerid,TextAccept[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TextAccept[playerid], 255);
	PlayerTextDrawFont(playerid,TextAccept[playerid], 2);
	PlayerTextDrawSetProportional(playerid,TextAccept[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TextAccept[playerid], 0);
	
}
stock LoadTextDraws()
{

	LogoText = TextDrawCreate(503.661437, 4.666678, "SAMP: Reloaded");
	TextDrawLetterSize(LogoText, 0.350673, 2.090000);
	TextDrawTextSize(LogoText, -183.660308, 172.083343);
	TextDrawAlignment(LogoText, 1);
	TextDrawColor(LogoText, -5963521);
	TextDrawSetShadow(LogoText, 0);
	TextDrawSetOutline(LogoText, -257);
	TextDrawBackgroundColor(LogoText, 51);
	TextDrawFont(LogoText, 2);
	TextDrawSetProportional(LogoText, 1);
	
	//====================================[Intro textdraws]======================
	td_intro [ 0 ] = TextDrawCreate(643.000000, 2.000000, "_" ) ;
	TextDrawBackgroundColor(td_intro [ 0 ], 255 ) ;
	TextDrawFont(td_intro [ 0 ], 1 ) ;
	TextDrawLetterSize(td_intro [ 0 ], 0.450000, 7.899997 ) ;
	TextDrawColor(td_intro [ 0 ], -1 ) ;
	TextDrawSetOutline(td_intro [ 0 ], 0 ) ;
	TextDrawSetProportional(td_intro [ 0 ], 1 ) ;
	TextDrawSetShadow(td_intro [ 0 ], 1 ) ;
	TextDrawUseBox(td_intro [ 0 ], 1 ) ;
	TextDrawBoxColor(td_intro [ 0 ], 255 ) ;
	TextDrawTextSize(td_intro [ 0 ], -4.000000, 0.000000 ) ;
	TextDrawSetSelectable(td_intro [ 0 ], 0 ) ;

	td_intro [ 1 ] = TextDrawCreate(643.000000, 378.000000, "_" ) ;
	TextDrawBackgroundColor(td_intro [ 1 ], 255 ) ;
	TextDrawFont(td_intro [ 1 ], 1 ) ;
	TextDrawLetterSize(td_intro [ 1 ], 0.450000, 7.899997 ) ;
	TextDrawColor(td_intro [ 1 ], -1 ) ;
	TextDrawSetOutline(td_intro [ 1 ], 0 ) ;
	TextDrawSetProportional(td_intro [ 1 ], 1 ) ;
	TextDrawSetShadow(td_intro [ 1 ], 1 ) ;
	TextDrawUseBox(td_intro [ 1 ], 1 ) ;
	TextDrawBoxColor(td_intro [ 1 ], 255 ) ;
	TextDrawTextSize(td_intro [ 1 ], -4.000000, 0.000000 ) ;
	TextDrawSetSelectable(td_intro [ 1 ], 0 ) ;


//========================================================================================
	//==============================================================================================TextDraws


	TextDraw[0] = TextDrawCreate(0.453945, 27.833314, "box");
	TextDrawLetterSize(TextDraw[0], 0.000000, 0.254759);
	TextDrawTextSize(TextDraw[0], 665.314941, 0.000000);
	TextDrawAlignment(TextDraw[0], 1);
	TextDrawColor(TextDraw[0], -1);
	TextDrawUseBox(TextDraw[0], 1);
	TextDrawBoxColor(TextDraw[0], 574510335);
	TextDrawSetShadow(TextDraw[0], 0);
	TextDrawSetOutline(TextDraw[0], 0);
	TextDrawBackgroundColor(TextDraw[0], 255);
	TextDrawFont(TextDraw[0], 3);
	TextDrawSetProportional(TextDraw[0], 1);
	TextDrawSetShadow(TextDraw[0], 0);

	TextDraw[1] = TextDrawCreate(-15.031343, 414.840209, "box");
	TextDrawLetterSize(TextDraw[1], 0.000000, 0.161055);
	TextDrawTextSize(TextDraw[1], 638.116882, 0.000000);
	TextDrawAlignment(TextDraw[1], 1);
	TextDrawColor(TextDraw[1], -1);
	TextDrawUseBox(TextDraw[1], 1);
	TextDrawBoxColor(TextDraw[1], 574510335);
	TextDrawSetShadow(TextDraw[1], 0);
	TextDrawSetOutline(TextDraw[1], 0);
	TextDrawBackgroundColor(TextDraw[1], 255);
	TextDrawFont(TextDraw[1], 1);
	TextDrawSetProportional(TextDraw[1], 1);
	TextDrawSetShadow(TextDraw[1], 0);

	TextDraw[2] = TextDrawCreate(54.165481, 80.916656, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[2], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[2], 170.117111, 265.583343);
	TextDrawAlignment(TextDraw[2], 1);
	TextDrawColor(TextDraw[2], 574510335);
	TextDrawSetShadow(TextDraw[2], 0);
	TextDrawSetOutline(TextDraw[2], 0);
	TextDrawBackgroundColor(TextDraw[2], 255);
	TextDrawFont(TextDraw[2], 4);
	TextDrawSetProportional(TextDraw[2], 0);
	TextDrawSetShadow(TextDraw[2], 0);

	TextDraw[3] = TextDrawCreate(55.595123, 83.249931, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[3], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[3], 166.368942, 260.916717);
	TextDrawAlignment(TextDraw[3], 1);
	TextDrawColor(TextDraw[3], 1181323775);
	TextDrawSetShadow(TextDraw[3], 0);
	TextDrawSetOutline(TextDraw[3], 0);
	TextDrawBackgroundColor(TextDraw[3], 255);
	TextDrawFont(TextDraw[3], 4);
	TextDrawSetProportional(TextDraw[3], 0);
	TextDrawSetShadow(TextDraw[3], 0);

	TextDraw[4] = TextDrawCreate(69.182144, 81.499938, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[4], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[4], 139.663238, 18.250017);
	TextDrawAlignment(TextDraw[4], 1);
	TextDrawColor(TextDraw[4], 574510335);
	TextDrawSetShadow(TextDraw[4], 0);
	TextDrawSetOutline(TextDraw[4], 0);
	TextDrawBackgroundColor(TextDraw[4], 255);
	TextDrawFont(TextDraw[4], 4);
	TextDrawSetProportional(TextDraw[4], 0);
	TextDrawSetShadow(TextDraw[4], 0);

	TextDraw[5] = TextDrawCreate(69.158065, 127.583343, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[5], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[5], 139.194717, 14.166683);
	TextDrawAlignment(TextDraw[5], 1);
	TextDrawColor(TextDraw[5], 574510335);
	TextDrawSetShadow(TextDraw[5], 0);
	TextDrawSetOutline(TextDraw[5], 0);
	TextDrawBackgroundColor(TextDraw[5], 255);
	TextDrawFont(TextDraw[5], 4);
	TextDrawSetProportional(TextDraw[5], 0);
	TextDrawSetShadow(TextDraw[5], 0);

	TextDraw[6] = TextDrawCreate(69.158065, 112.416603, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[6], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[6], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[6], 1);
	TextDrawColor(TextDraw[6], 574510335);
	TextDrawSetShadow(TextDraw[6], 0);
	TextDrawSetOutline(TextDraw[6], 0);
	TextDrawBackgroundColor(TextDraw[6], 255);
	TextDrawFont(TextDraw[6], 4);
	TextDrawSetProportional(TextDraw[6], 0);
	TextDrawSetShadow(TextDraw[6], 0);

	TextDraw[8] = TextDrawCreate(70.732055, 114.749992, RusToGame("Имя"));
	TextDrawLetterSize(TextDraw[8], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[8], 1);
	TextDrawColor(TextDraw[8], -1);
	TextDrawSetShadow(TextDraw[8], 0);
	TextDrawSetOutline(TextDraw[8], 0);
	TextDrawBackgroundColor(TextDraw[8], 255);
	TextDrawFont(TextDraw[8], 2);
	TextDrawSetProportional(TextDraw[8], 1);
	TextDrawSetShadow(TextDraw[8], 0);

	TextDraw[9] = TextDrawCreate(69.158065, 162.000015, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[9], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[9], 139.194717, 14.166683);
	TextDrawAlignment(TextDraw[9], 1);
	TextDrawColor(TextDraw[9], 574510335);
	TextDrawSetShadow(TextDraw[9], 0);
	TextDrawSetOutline(TextDraw[9], 0);
	TextDrawBackgroundColor(TextDraw[9], 255);
	TextDrawFont(TextDraw[9], 4);
	TextDrawSetProportional(TextDraw[9], 0);
	TextDrawSetShadow(TextDraw[9], 0);
	TextDrawSetSelectable(TextDraw[9], true);

	TextDraw[10] = TextDrawCreate(69.158065, 146.833282, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[10], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[10], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[10], 1);
	TextDrawColor(TextDraw[10], 574510335);
	TextDrawSetShadow(TextDraw[10], 0);
	TextDrawSetOutline(TextDraw[10], 0);
	TextDrawBackgroundColor(TextDraw[10], 255);
	TextDrawFont(TextDraw[10], 4);
	TextDrawSetProportional(TextDraw[10], 0);
	TextDrawSetShadow(TextDraw[10], 0);

	TextDraw[11] = TextDrawCreate(69.158065, 182.416610, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[11], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[11], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[11], 1);
	TextDrawColor(TextDraw[11], 574510335);
	TextDrawSetShadow(TextDraw[11], 0);
	TextDrawSetOutline(TextDraw[11], 0);
	TextDrawBackgroundColor(TextDraw[11], 255);
	TextDrawFont(TextDraw[11], 4);
	TextDrawSetProportional(TextDraw[11], 0);
	TextDrawSetShadow(TextDraw[11], 0);

	TextDraw[12] = TextDrawCreate(69.158065, 197.583343, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[12], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[12], 139.194717, 14.166683);
	TextDrawAlignment(TextDraw[12], 1);
	TextDrawColor(TextDraw[12], 574510335);
	TextDrawSetShadow(TextDraw[12], 0);
	TextDrawSetOutline(TextDraw[12], 0);
	TextDrawBackgroundColor(TextDraw[12], 255);
	TextDrawFont(TextDraw[12], 4);
	TextDrawSetProportional(TextDraw[12], 0);
	TextDrawSetShadow(TextDraw[12], 0);
	TextDrawSetSelectable(TextDraw[12], true);

	TextDraw[13] = TextDrawCreate(70.732055, 149.166687, RusToGame("Пароль"));
	TextDrawLetterSize(TextDraw[13], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[13], 1);
	TextDrawColor(TextDraw[13], -1);
	TextDrawSetShadow(TextDraw[13], 0);
	TextDrawSetOutline(TextDraw[13], 0);
	TextDrawBackgroundColor(TextDraw[13], 255);
	TextDrawFont(TextDraw[13], 2);
	TextDrawSetProportional(TextDraw[13], 1);
	TextDrawSetShadow(TextDraw[13], 0);

	TextDraw[15] = TextDrawCreate(70.732055, 184.749969, "E-MAIL");
	TextDrawLetterSize(TextDraw[15], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[15], 1);
	TextDrawColor(TextDraw[15], -1);
	TextDrawSetShadow(TextDraw[15], 0);
	TextDrawSetOutline(TextDraw[15], 0);
	TextDrawBackgroundColor(TextDraw[15], 255);
	TextDrawFont(TextDraw[15], 2);
	TextDrawSetProportional(TextDraw[15], 1);
	TextDrawSetShadow(TextDraw[15], 0);

	

	TextDraw[17] = TextDrawCreate(104.465576, 85.583297, RusToGame("Регистрация"));
	TextDrawLetterSize(TextDraw[17], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[17], 1);
	TextDrawColor(TextDraw[17], -1);
	TextDrawSetShadow(TextDraw[17], 0);
	TextDrawSetOutline(TextDraw[17], 0);
	TextDrawBackgroundColor(TextDraw[17], 255);
	TextDrawFont(TextDraw[17], 2);
	TextDrawSetProportional(TextDraw[17], 1);
	TextDrawSetShadow(TextDraw[17], 0);

	TextDraw[18] = TextDrawCreate(69.158065, 233.166687, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[18], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[18], 139.194717, 14.166683);
	TextDrawAlignment(TextDraw[18], 1);
	TextDrawColor(TextDraw[18], 574510335);
	TextDrawSetShadow(TextDraw[18], 0);
	TextDrawSetOutline(TextDraw[18], 0);
	TextDrawBackgroundColor(TextDraw[18], 255);
	TextDrawFont(TextDraw[18], 4);
	TextDrawSetProportional(TextDraw[18], 0);
	TextDrawSetShadow(TextDraw[18], 0);
	TextDrawSetSelectable(TextDraw[18], true);

	TextDraw[19] = TextDrawCreate(69.158065, 217.999923, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[19], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[19], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[19], 1);
	TextDrawColor(TextDraw[19], 574510335);
	TextDrawSetShadow(TextDraw[19], 0);
	TextDrawSetOutline(TextDraw[19], 0);
	TextDrawBackgroundColor(TextDraw[19], 255);
	TextDrawFont(TextDraw[19], 4);
	TextDrawSetProportional(TextDraw[19], 0);
	TextDrawSetShadow(TextDraw[19], 0);

	TextDraw[20] = TextDrawCreate(69.158065, 272.249908, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[20], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[20], 139.194717, 14.166683);
	TextDrawAlignment(TextDraw[20], 1);
	TextDrawColor(TextDraw[20], 574510335);
	TextDrawSetShadow(TextDraw[20], 0);
	TextDrawSetOutline(TextDraw[20], 0);
	TextDrawBackgroundColor(TextDraw[20], 255);
	TextDrawFont(TextDraw[20], 4);
	TextDrawSetProportional(TextDraw[20], 0);
	TextDrawSetShadow(TextDraw[20], 0);
	TextDrawSetSelectable(TextDraw[20], true);

	TextDraw[21] = TextDrawCreate(69.158065, 257.083160, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[21], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[21], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[21], 1);
	TextDrawColor(TextDraw[21], 574510335);
	TextDrawSetShadow(TextDraw[21], 0);
	TextDrawSetOutline(TextDraw[21], 0);
	TextDrawBackgroundColor(TextDraw[21], 255);
	TextDrawFont(TextDraw[21], 4);
	TextDrawSetProportional(TextDraw[21], 0);
	TextDrawSetShadow(TextDraw[21], 0);

	TextDraw[22] = TextDrawCreate(69.158065, 307.249908, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[22], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[22], 139.194717, 14.166683);
	TextDrawAlignment(TextDraw[22], 1);
	TextDrawColor(TextDraw[22], 574510335);
	TextDrawSetShadow(TextDraw[22], 0);
	TextDrawSetOutline(TextDraw[22], 0);
	TextDrawBackgroundColor(TextDraw[22], 255);
	TextDrawFont(TextDraw[22], 4);
	TextDrawSetProportional(TextDraw[22], 0);
	TextDrawSetShadow(TextDraw[22], 0);
	TextDrawSetSelectable(TextDraw[22], true);

	TextDraw[23] = TextDrawCreate(69.158065, 292.083160, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[23], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[23], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[23], 1);
	TextDrawColor(TextDraw[23], 574510591);
	TextDrawSetShadow(TextDraw[23], 0);
	TextDrawSetOutline(TextDraw[23], 0);
	TextDrawBackgroundColor(TextDraw[23], 255);
	TextDrawFont(TextDraw[23], 4);
	TextDrawSetProportional(TextDraw[23], 0);
	TextDrawSetShadow(TextDraw[23], 0);

	TextDraw[24] = TextDrawCreate(70.263534, 220.333297, RusToGame("Пол"));
	TextDrawLetterSize(TextDraw[24], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[24], 1);
	TextDrawColor(TextDraw[24], -1);
	TextDrawSetShadow(TextDraw[24], 0);
	TextDrawSetOutline(TextDraw[24], 0);
	TextDrawBackgroundColor(TextDraw[24], 255);
	TextDrawFont(TextDraw[24], 2);
	TextDrawSetProportional(TextDraw[24], 1);
	TextDrawSetShadow(TextDraw[24], 0);

	TextDraw[26] = TextDrawCreate(70.263534, 259.416656, RusToGame("Раса"));
	TextDrawLetterSize(TextDraw[26], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[26], 1);
	TextDrawColor(TextDraw[26], -1);
	TextDrawSetShadow(TextDraw[26], 0);
	TextDrawSetOutline(TextDraw[26], 0);
	TextDrawBackgroundColor(TextDraw[26], 255);
	TextDrawFont(TextDraw[26], 2);
	TextDrawSetProportional(TextDraw[26], 1);
	TextDrawSetShadow(TextDraw[26], 0);

	TextDraw[28] = TextDrawCreate(70.263534, 294.416625, RusToGame("Нация"));
	TextDrawLetterSize(TextDraw[28], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[28], 1);
	TextDrawColor(TextDraw[28], -1);
	TextDrawSetShadow(TextDraw[28], 0);
	TextDrawSetOutline(TextDraw[28], 0);
	TextDrawBackgroundColor(TextDraw[28], 255);
	TextDrawFont(TextDraw[28], 2);
	TextDrawSetProportional(TextDraw[28], 1);
	TextDrawSetShadow(TextDraw[28], 0);

	TextDraw[29] = TextDrawCreate(70.263534, 309.583312, RusToGame("Американец"));
	TextDrawLetterSize(TextDraw[29], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[29], 1);
	TextDrawColor(TextDraw[29], -1);
	TextDrawSetShadow(TextDraw[29], 0);
	TextDrawSetOutline(TextDraw[29], 0);
	TextDrawBackgroundColor(TextDraw[29], 255);
	TextDrawFont(TextDraw[29], 2);
	TextDrawSetProportional(TextDraw[29], 1);
	TextDrawSetShadow(TextDraw[29], 0);

	TextDraw[30] = TextDrawCreate(-16.314571, 420.175201, "box");
	TextDrawLetterSize(TextDraw[30], 0.000000, 3.963106);
	TextDrawTextSize(TextDraw[30], 814.059570, 0.000000);
	TextDrawAlignment(TextDraw[30], 1);
	TextDrawColor(TextDraw[30], 0);
	TextDrawUseBox(TextDraw[30], 1);
	TextDrawBoxColor(TextDraw[30], 120);
	TextDrawSetShadow(TextDraw[30], 0);
	TextDrawSetOutline(TextDraw[30], 0);
	TextDrawBackgroundColor(TextDraw[30], 255);
	TextDrawFont(TextDraw[30], 1);
	TextDrawSetProportional(TextDraw[30], 1);
	TextDrawSetShadow(TextDraw[30], 0);

	TextDraw[31] = TextDrawCreate(0.057645, -0.905706, "box");
	TextDrawLetterSize(TextDraw[31], 0.000000, 2.718662);
	TextDrawTextSize(TextDraw[31], 663.765502, 0.000000);
	TextDrawAlignment(TextDraw[31], 1);
	TextDrawColor(TextDraw[31], -1);
	TextDrawUseBox(TextDraw[31], 1);
	TextDrawBoxColor(TextDraw[31], 120);
	TextDrawSetShadow(TextDraw[31], 0);
	TextDrawSetOutline(TextDraw[31], 0);
	TextDrawBackgroundColor(TextDraw[31], 255);
	TextDrawFont(TextDraw[31], 1);
	TextDrawSetProportional(TextDraw[31], 1);
	TextDrawSetShadow(TextDraw[31], 0);

	TextDraw[32] = TextDrawCreate(396.931945, 80.916648, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[32], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[32], 189.672592, 265.583343);
	TextDrawAlignment(TextDraw[32], 1);
	TextDrawColor(TextDraw[32], 574510335);
	TextDrawSetShadow(TextDraw[32], 0);
	TextDrawSetOutline(TextDraw[32], 0);
	TextDrawBackgroundColor(TextDraw[32], 255);
	TextDrawFont(TextDraw[32], 4);
	TextDrawSetProportional(TextDraw[32], 0);
	TextDrawSetShadow(TextDraw[32], 0);

	TextDraw[33] = TextDrawCreate(399.154083, 83.405517, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[33], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[33], 185.228164, 259.610076);
	TextDrawAlignment(TextDraw[33], 1);
	TextDrawColor(TextDraw[33], 1181323775);
	TextDrawSetShadow(TextDraw[33], 0);
	TextDrawSetOutline(TextDraw[33], 0);
	TextDrawBackgroundColor(TextDraw[33], 255);
	TextDrawFont(TextDraw[33], 4);
	TextDrawSetProportional(TextDraw[33], 0);
	TextDrawSetShadow(TextDraw[33], 0);

	TextDraw[34] = TextDrawCreate(414.959960, 83.491012, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[34], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[34], 152.996520, 18.747795);
	TextDrawAlignment(TextDraw[34], 1);
	TextDrawColor(TextDraw[34], 574510335);
	TextDrawSetShadow(TextDraw[34], 0);
	TextDrawSetOutline(TextDraw[34], 0);
	TextDrawBackgroundColor(TextDraw[34], 255);
	TextDrawFont(TextDraw[34], 4);
	TextDrawSetProportional(TextDraw[34], 0);
	TextDrawSetShadow(TextDraw[34], 0);

	TextDraw[35] = TextDrawCreate(473.843170, 87.372207, RusToGame("История"));
	TextDrawLetterSize(TextDraw[35], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[35], 1);
	TextDrawColor(TextDraw[35], -1);
	TextDrawSetShadow(TextDraw[35], 0);
	TextDrawSetOutline(TextDraw[35], 0);
	TextDrawBackgroundColor(TextDraw[35], 255);
	TextDrawFont(TextDraw[35], 2);
	TextDrawSetProportional(TextDraw[35], 1);
	TextDrawSetShadow(TextDraw[35], 0);

	TextDraw[36] = TextDrawCreate(472.509796, 111.763328, "STORY_I");
	TextDrawLetterSize(TextDraw[36], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[36], 1);
	TextDrawColor(TextDraw[36], -1);
	TextDrawSetShadow(TextDraw[36], 0);
	TextDrawSetOutline(TextDraw[36], 0);
	TextDrawBackgroundColor(TextDraw[36], 255);
	TextDrawFont(TextDraw[36], 2);
	TextDrawSetProportional(TextDraw[36], 1);
	TextDrawSetShadow(TextDraw[36], 0);

	TextDraw[37] = TextDrawCreate(414.287567, 129.683288, "");
	TextDrawLetterSize(TextDraw[37], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[37], 1);
	TextDrawColor(TextDraw[37], -1);
	TextDrawSetShadow(TextDraw[37], 0);
	TextDrawSetOutline(TextDraw[37], 0);
	TextDrawBackgroundColor(TextDraw[37], 255);
	TextDrawFont(TextDraw[37], 2);
	TextDrawSetProportional(TextDraw[37], 1);
	TextDrawSetShadow(TextDraw[37], 0);

	TextDraw[38] = TextDrawCreate(231.054382, 111.280967, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[38], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[38], 158.117156, 204.854537);
	TextDrawAlignment(TextDraw[38], 1);
	TextDrawColor(TextDraw[38], 574510335);
	TextDrawSetShadow(TextDraw[38], 0);
	TextDrawSetOutline(TextDraw[38], 0);
	TextDrawBackgroundColor(TextDraw[38], 255);
	TextDrawFont(TextDraw[38], 4);
	TextDrawSetProportional(TextDraw[38], 0);
	TextDrawSetShadow(TextDraw[38], 0);

	TextDraw[39] = TextDrawCreate(232.832351, 113.272117, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[39], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[39], 154.561676, 200.872482);
	TextDrawAlignment(TextDraw[39], 1);
	TextDrawColor(TextDraw[39], 1181323775);
	TextDrawSetShadow(TextDraw[39], 0);
	TextDrawSetOutline(TextDraw[39], 0);
	TextDrawBackgroundColor(TextDraw[39], 255);
	TextDrawFont(TextDraw[39], 4);
	TextDrawSetProportional(TextDraw[39], 0);
	TextDrawSetShadow(TextDraw[39], 0);

	TextDraw[40] = TextDrawCreate(243.380264, 147.261032, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[40], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[40], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[40], 1);
	TextDrawColor(TextDraw[40], 574510335);
	TextDrawSetShadow(TextDraw[40], 0);
	TextDrawSetOutline(TextDraw[40], 0);
	TextDrawBackgroundColor(TextDraw[40], 255);
	TextDrawFont(TextDraw[40], 4);
	TextDrawSetProportional(TextDraw[40], 0);
	TextDrawSetShadow(TextDraw[40], 0);

	TextDraw[41] = TextDrawCreate(243.380325, 162.497879, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[41], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[41], 132.083633, 13.668905);
	TextDrawAlignment(TextDraw[41], 1);
	TextDrawColor(TextDraw[41], 574510335);
	TextDrawSetShadow(TextDraw[41], 0);
	TextDrawSetOutline(TextDraw[41], 0);
	TextDrawBackgroundColor(TextDraw[41], 255);
	TextDrawFont(TextDraw[41], 4);
	TextDrawSetProportional(TextDraw[41], 0);
	TextDrawSetShadow(TextDraw[41], 0);
	TextDrawSetSelectable(TextDraw[41], true);

	TextDraw[42] = TextDrawCreate(243.380264, 191.065490, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[42], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[42], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[42], 1);
	TextDrawColor(TextDraw[42], 574510335);
	TextDrawSetShadow(TextDraw[42], 0);
	TextDrawSetOutline(TextDraw[42], 0);
	TextDrawBackgroundColor(TextDraw[42], 255);
	TextDrawFont(TextDraw[42], 4);
	TextDrawSetProportional(TextDraw[42], 0);
	TextDrawSetShadow(TextDraw[42], 0);

	TextDraw[43] = TextDrawCreate(243.404357, 112.859962, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[43], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[43], 132.107711, 17.752239);
	TextDrawAlignment(TextDraw[43], 1);
	TextDrawColor(TextDraw[43], 574510335);
	TextDrawSetShadow(TextDraw[43], 0);
	TextDrawSetOutline(TextDraw[43], 0);
	TextDrawBackgroundColor(TextDraw[43], 255);
	TextDrawFont(TextDraw[43], 4);
	TextDrawSetProportional(TextDraw[43], 0);
	TextDrawSetShadow(TextDraw[43], 0);

	TextDraw[44] = TextDrawCreate(243.380310, 206.302307, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[44], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[44], 132.083633, 13.668905);
	TextDrawAlignment(TextDraw[44], 1);
	TextDrawColor(TextDraw[44], 574510335);
	TextDrawSetShadow(TextDraw[44], 0);
	TextDrawSetOutline(TextDraw[44], 0);
	TextDrawBackgroundColor(TextDraw[44], 255);
	TextDrawFont(TextDraw[44], 4);
	TextDrawSetProportional(TextDraw[44], 0);
	TextDrawSetShadow(TextDraw[44], 0);
	TextDrawSetSelectable(TextDraw[44], true);

	TextDraw[45] = TextDrawCreate(243.380264, 235.865417, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[45], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[45], 61.888732, 14.166685);
	TextDrawAlignment(TextDraw[45], 1);
	TextDrawColor(TextDraw[45], 574510335);
	TextDrawSetShadow(TextDraw[45], 0);
	TextDrawSetOutline(TextDraw[45], 0);
	TextDrawBackgroundColor(TextDraw[45], 255);
	TextDrawFont(TextDraw[45], 4);
	TextDrawSetProportional(TextDraw[45], 0);
	TextDrawSetShadow(TextDraw[45], 0);

	TextDraw[46] = TextDrawCreate(243.380310, 251.102264, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[46], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[46], 132.083633, 13.668905);
	TextDrawAlignment(TextDraw[46], 1);
	TextDrawColor(TextDraw[46], 574510335);
	TextDrawSetShadow(TextDraw[46], 0);
	TextDrawSetOutline(TextDraw[46], 0);
	TextDrawBackgroundColor(TextDraw[46], 255);
	TextDrawFont(TextDraw[46], 4);
	TextDrawSetProportional(TextDraw[46], 0);
	TextDrawSetShadow(TextDraw[46], 0);
	TextDrawSetSelectable(TextDraw[46], true);

	TextDraw[47] = TextDrawCreate(292.065338, 116.741088, "STORY");
	TextDrawLetterSize(TextDraw[47], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[47], 1);
	TextDrawColor(TextDraw[47], -1);
	TextDrawSetShadow(TextDraw[47], 0);
	TextDrawSetOutline(TextDraw[47], 0);
	TextDrawBackgroundColor(TextDraw[47], 255);
	TextDrawFont(TextDraw[47], 2);
	TextDrawSetProportional(TextDraw[47], 1);
	TextDrawSetShadow(TextDraw[47], 0);

	TextDraw[48] = TextDrawCreate(231.054412, 80.916473, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[48], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[48], 158.117156, 23.663560);
	TextDrawAlignment(TextDraw[48], 1);
	TextDrawColor(TextDraw[48], 574510335);
	TextDrawSetShadow(TextDraw[48], 0);
	TextDrawSetOutline(TextDraw[48], 0);
	TextDrawBackgroundColor(TextDraw[48], 255);
	TextDrawFont(TextDraw[48], 4);
	TextDrawSetProportional(TextDraw[48], 0);
	TextDrawSetShadow(TextDraw[48], 0);

	TextDraw[49] = TextDrawCreate(232.832183, 82.907592, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[49], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[49], 154.117172, 20.179115);
	TextDrawAlignment(TextDraw[49], 1);
	TextDrawColor(TextDraw[49], 1181323775);
	TextDrawSetShadow(TextDraw[49], 0);
	TextDrawSetOutline(TextDraw[49], 0);
	TextDrawBackgroundColor(TextDraw[49], 255);
	TextDrawFont(TextDraw[49], 4);
	TextDrawSetProportional(TextDraw[49], 0);
	TextDrawSetShadow(TextDraw[49], 0);

	TextDraw[50] = TextDrawCreate(231.498931, 323.334136, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[50], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[50], 158.117156, 23.165786);
	TextDrawAlignment(TextDraw[50], 1);
	TextDrawColor(TextDraw[50], 574510335);
	TextDrawSetShadow(TextDraw[50], 0);
	TextDrawSetOutline(TextDraw[50], 0);
	TextDrawBackgroundColor(TextDraw[50], 255);
	TextDrawFont(TextDraw[50], 4);
	TextDrawSetProportional(TextDraw[50], 0);
	TextDrawSetShadow(TextDraw[50], 0);

	TextDraw[51] = TextDrawCreate(233.276626, 325.325286, "LD_SPAC:white");
	TextDrawLetterSize(TextDraw[51], 0.000000, 0.000000);
	TextDrawTextSize(TextDraw[51], 154.117172, 19.183559);
	TextDrawAlignment(TextDraw[51], 1);
	TextDrawColor(TextDraw[51], 1181323775);
	TextDrawSetShadow(TextDraw[51], 0);
	TextDrawSetOutline(TextDraw[51], 0);
	TextDrawBackgroundColor(TextDraw[51], 255);
	TextDrawFont(TextDraw[51], 4);
	TextDrawSetProportional(TextDraw[51], 0);
	TextDrawSetShadow(TextDraw[51], 0);
	TextDrawSetSelectable(TextDraw[51], true);

	TextDraw[52] = TextDrawCreate(277.398590, 88.367500, "registration");
	TextDrawLetterSize(TextDraw[52], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[52], 1);
	TextDrawColor(TextDraw[52], -1);
	TextDrawSetShadow(TextDraw[52], 0);
	TextDrawSetOutline(TextDraw[52], 0);
	TextDrawBackgroundColor(TextDraw[52], 255);
	TextDrawFont(TextDraw[52], 2);
	TextDrawSetProportional(TextDraw[52], 1);
	TextDrawSetShadow(TextDraw[52], 0);


	TextDraw[54] = TextDrawCreate(247.176513, 149.594375, RusToGame("STORY_i"));
	TextDrawLetterSize(TextDraw[54], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[54], 1);
	TextDrawColor(TextDraw[54], -1);
	TextDrawSetShadow(TextDraw[54], 0);
	TextDrawSetOutline(TextDraw[54], 0);
	TextDrawBackgroundColor(TextDraw[54], 255);
	TextDrawFont(TextDraw[54], 2);
	TextDrawSetProportional(TextDraw[54], 1);
	TextDrawSetShadow(TextDraw[54], 0);

	TextDraw[55] = TextDrawCreate(247.176513, 193.398803, "STORY_ii");
	TextDrawLetterSize(TextDraw[55], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[55], 1);
	TextDrawColor(TextDraw[55], -1);
	TextDrawSetShadow(TextDraw[55], 0);
	TextDrawSetOutline(TextDraw[55], 0);
	TextDrawBackgroundColor(TextDraw[55], 255);
	TextDrawFont(TextDraw[55], 2);
	TextDrawSetProportional(TextDraw[55], 1);
	TextDrawSetShadow(TextDraw[55], 0);

	TextDraw[56] = TextDrawCreate(246.732070, 238.198562, "STORY_iii");
	TextDrawLetterSize(TextDraw[56], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[56], 1);
	TextDrawColor(TextDraw[56], -1);
	TextDrawSetShadow(TextDraw[56], 0);
	TextDrawSetOutline(TextDraw[56], 0);
	TextDrawBackgroundColor(TextDraw[56], 255);
	TextDrawFont(TextDraw[56], 2);
	TextDrawSetProportional(TextDraw[56], 1);
	TextDrawSetShadow(TextDraw[56], 0);

	TextDraw[57] = TextDrawCreate(247.176620, 253.131896, RusToGame("Выбрать"));
	TextDrawLetterSize(TextDraw[57], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[57], 1);
	TextDrawColor(TextDraw[57], -1);
	TextDrawSetShadow(TextDraw[57], 0);
	TextDrawSetOutline(TextDraw[57], 0);
	TextDrawBackgroundColor(TextDraw[57], 255);
	TextDrawFont(TextDraw[57], 2);
	TextDrawSetProportional(TextDraw[57], 1);
	TextDrawSetShadow(TextDraw[57], 0);

	TextDraw[58] = TextDrawCreate(246.732177, 208.829681, RusToGame("Выбрать"));
	TextDrawLetterSize(TextDraw[58], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[58], 1);
	TextDrawColor(TextDraw[58], -1);
	TextDrawSetShadow(TextDraw[58], 0);
	TextDrawSetOutline(TextDraw[58], 0);
	TextDrawBackgroundColor(TextDraw[58], 255);
	TextDrawFont(TextDraw[58], 2);
	TextDrawSetProportional(TextDraw[58], 1);
	TextDrawSetShadow(TextDraw[58], 0);

	TextDraw[59] = TextDrawCreate(247.176620, 165.522964, RusToGame("Выбрать"));
	TextDrawLetterSize(TextDraw[59], 0.285679, 1.179998);
	TextDrawAlignment(TextDraw[59], 1);
	TextDrawColor(TextDraw[59], -1);
	TextDrawSetShadow(TextDraw[59], 0);
	TextDrawSetOutline(TextDraw[59], 0);
	TextDrawBackgroundColor(TextDraw[59], 255);
	TextDrawFont(TextDraw[59], 2);
	TextDrawSetProportional(TextDraw[59], 1);
	TextDrawSetShadow(TextDraw[59], 0);

}