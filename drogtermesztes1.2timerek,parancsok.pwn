//========== OnPlayerConnect al� ==========
LoadDrogtermesztes(playerid);

//========== OnPlayerDisconnect al� ==========
SaveDrogtermesztes(playerid);

//========== Aj�nlom: ==========
Egy timert elinditani amikor elindul a m�d, m�gpedig hogy 1 percenk�nt mentse az adatokat. (SaveDrogtermesztest)


//========== Parancsok ==========

if(egyezik(cmd, "/drogtermeszt�s"))
	{
		if(params < 1) return Msg(playerid, "/drogtermeszt�s [�ltet, betakarit, �pol, statisztika, inf�]");
		
		if(egyezik(param[1], "stat") || egyezik(param[1], "statisztika"))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{FFFFFF}===============[ {F3FF02}Statisztika {FFFFFF}]===============");
			SendFormatMessage(playerid, COLOR_GREY, "{00C0FF}El�ltetett vetem�nyek: {FFFFFF}%d{00C0FF}db | {00C0FF}Betakaritott vetem�nyek: {FFFFFF}%d{00C0FF}db", pDrogtermesztes[playerid][pOsszes], pDrogtermesztes[playerid][pBetakaritott]);
			SendFormatMessage(playerid, COLOR_GREY, "{00C0FF}Meglocsolt: {FFFFFF}%d{00C0FF}x | Kigazolt: {FFFFFF}%d{00C0FF}x", pDrogtermesztes[playerid][pLocsolas], pDrogtermesztes[playerid][pGazolas]);
			SendFormatMessage(playerid, COLOR_GREY, "{00C0FF}Kokain: {FFFFFF}%d{00C0FF}g | Heroin: {FFFFFF}%d{00C0FF}g | Marihuana: {FFFFFF}%d{00C0FF}g", pDrogtermesztes[playerid][pKoka], pDrogtermesztes[playerid][pHero], pDrogtermesztes[playerid][pMari]);
		}
		
		if(egyezik(param[1], "inf�") || egyezik(param[1], "info"))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{FFFFFF}===============[ {F3FF02}Drogtermeszt�s Inform�ci�k {FFFFFF}]===============");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Hamarosan. :)");
		}
		
		
		if(egyezik(param[1], "betakarit") || egyezik(param[1], "betakaritas"))
		{
			if(ultetett[playerid] != 1) return Msg(playerid, "Nem �ltett�l m�g vetem�nyt!");
			if(megerett[playerid] != 1) return Msg(playerid, "Ne barmold sz�t a magokat.");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Hova sietsz dude?!");
			if(!PlayerToPoint(3, playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "Inf�: Nem vagy a vetem�nyed k�zel�ben! (Jel�ltem a t�rk�peden. :))");
				SetPlayerCheckpoint(playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 5);
				return 1;
			}
			
			MunkaFolyamatban[playerid] = 1;
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermeszt�s]: Vetem�ny betakarit�s folyamatban..");
			TogglePlayerControllable(playerid, false);
			ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
			SetTimerEx("UltetesBetakaritas", 30000, false, "i", playerid); // 30 m�sodperc
		}
		
		if(egyezik(param[1], "�ltet") || egyezik(param[1], "ultet"))
		{
			if(ultetett[playerid] == 1) return Msg(playerid, "M�r �ltett�l vetem�nyt!");
			if(PlayerInfo[playerid][pCserje] < 5 || PlayerInfo[playerid][pMak] < 5 || PlayerInfo[playerid][pCannabis] < 5) return Msg(playerid, "Sz�ks�ged lesz 5db Cserje, M�k, Cannabis -ra -re!");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Hova sietsz dude?!");
			
			new legyenrandomido = Rand(1, 5);
			new veglegestimer;
			switch(legyenrandomido)
			{
				case 1: veglegestimer = 15000;
				case 2: veglegestimer = 25000;
				case 3: veglegestimer = 35000;
				case 4: veglegestimer = 45000;
				case 5: veglegestimer = 55000;
			}
			
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid, pX, pY, pZ);
			MunkaFolyamatban[playerid] = 1;
			vetemenyX[playerid] = pX;
			vetemenyY[playerid] = pY;
			vetemenyZ[playerid] = pZ;
			
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermeszt�s]: Vetem�ny �ltet�s folyamatban..");
			TogglePlayerControllable(playerid, false);
			ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
			SetTimerEx("UltetesVarakoztatas", veglegestimer, false, "i", playerid);
		}
		
		if(egyezik(param[1], "�pol") || egyezik(param[1], "apol"))
		{
			/*new Float:ujraX, Float:ujraY, Float:ujraZ; // Lek�rdezem m�gegyszer az �tl�that�s�g kedv��rt. :D #kappa
			GetPlayerPos(playerid, ujraX, ujraY, ujraZ);
			�t�lag �tgondolva mi a fasznak k�rdezem le?! :D
			*/
			if(ultetett[playerid] == 0) return Msg(playerid, "Nem is �ltett�l m�g vetem�nyt.. #asd");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Ennyire ne siess..");
			if(megerett[playerid] == 1) return Msg(playerid, "Ezzel m�r elk�st�l. :/");
			if(!PlayerToPoint(3.0, playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "Inf�: Nem vagy a vetem�nyed k�zel�ben! (Jel�ltem a t�rk�peden. :))");
				SetPlayerCheckpoint(playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 5);
				return 1;
			}
		
			if(params < 2) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "Haszn�lata: /drogtermeszt�s �pol [meglocsol, kigazol�s]");
			
			if(egyezik(param[2], "meglocsol") || egyezik(param[1], "locsol"))
			{
				if(locsolhato[playerid] == 0) return Msg(playerid, "Ne locsold m�r eg�sz nap azt a vetem�nyt..");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetem�ny]: Locsol�s folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesLocsolas", 15000, false, "i", playerid);
				
			}
			if(egyezik(param[2], "kigazol�s") || egyezik(param[1], "kigazolas"))
			{
				if(gazolhato[playerid] == 0) return Msg(playerid, "Ne locsold m�r eg�sz nap azt a vetem�nyt..");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetem�ny]: Kigazol�s folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesGazolas", 15000, false, "i", playerid);
			}
		}
		return 1;
	}