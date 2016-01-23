//========== OnPlayerConnect alá ==========
LoadDrogtermesztes(playerid);

//========== OnPlayerDisconnect alá ==========
SaveDrogtermesztes(playerid);

//========== Ajánlom: ==========
Egy timert elinditani amikor elindul a mód, mégpedig hogy 1 percenként mentse az adatokat. (SaveDrogtermesztest)


//========== Parancsok ==========

if(egyezik(cmd, "/drogtermesztés"))
	{
		if(params < 1) return Msg(playerid, "/drogtermesztés [ültet, betakarit, ápol, statisztika, infó]");
		
		if(egyezik(param[1], "stat") || egyezik(param[1], "statisztika"))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{FFFFFF}===============[ {F3FF02}Statisztika {FFFFFF}]===============");
			SendFormatMessage(playerid, COLOR_GREY, "{00C0FF}Elültetett vetemények: {FFFFFF}%d{00C0FF}db | {00C0FF}Betakaritott vetemények: {FFFFFF}%d{00C0FF}db", pDrogtermesztes[playerid][pOsszes], pDrogtermesztes[playerid][pBetakaritott]);
			SendFormatMessage(playerid, COLOR_GREY, "{00C0FF}Meglocsolt: {FFFFFF}%d{00C0FF}x | Kigazolt: {FFFFFF}%d{00C0FF}x", pDrogtermesztes[playerid][pLocsolas], pDrogtermesztes[playerid][pGazolas]);
			SendFormatMessage(playerid, COLOR_GREY, "{00C0FF}Kokain: {FFFFFF}%d{00C0FF}g | Heroin: {FFFFFF}%d{00C0FF}g | Marihuana: {FFFFFF}%d{00C0FF}g", pDrogtermesztes[playerid][pKoka], pDrogtermesztes[playerid][pHero], pDrogtermesztes[playerid][pMari]);
		}
		
		if(egyezik(param[1], "infó") || egyezik(param[1], "info"))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{FFFFFF}===============[ {F3FF02}Drogtermesztés Információk {FFFFFF}]===============");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Hamarosan. :)");
		}
		
		
		if(egyezik(param[1], "betakarit") || egyezik(param[1], "betakaritas"))
		{
			if(ultetett[playerid] != 1) return Msg(playerid, "Nem ültettél még veteményt!");
			if(megerett[playerid] != 1) return Msg(playerid, "Ne barmold szét a magokat.");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Hova sietsz dude?!");
			if(!PlayerToPoint(3, playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "Infó: Nem vagy a veteményed közelében! (Jelöltem a térképeden. :))");
				SetPlayerCheckpoint(playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 5);
				return 1;
			}
			
			MunkaFolyamatban[playerid] = 1;
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermesztés]: Vetemény betakaritás folyamatban..");
			TogglePlayerControllable(playerid, false);
			ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
			SetTimerEx("UltetesBetakaritas", 30000, false, "i", playerid); // 30 másodperc
		}
		
		if(egyezik(param[1], "ültet") || egyezik(param[1], "ultet"))
		{
			if(ultetett[playerid] == 1) return Msg(playerid, "Már ültettél veteményt!");
			if(PlayerInfo[playerid][pCserje] < 5 || PlayerInfo[playerid][pMak] < 5 || PlayerInfo[playerid][pCannabis] < 5) return Msg(playerid, "Szükséged lesz 5db Cserje, Mák, Cannabis -ra -re!");
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
			
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermesztés]: Vetemény ültetés folyamatban..");
			TogglePlayerControllable(playerid, false);
			ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
			SetTimerEx("UltetesVarakoztatas", veglegestimer, false, "i", playerid);
		}
		
		if(egyezik(param[1], "ápol") || egyezik(param[1], "apol"))
		{
			/*new Float:ujraX, Float:ujraY, Float:ujraZ; // Lekérdezem mégegyszer az átláthatóság kedvéért. :D #kappa
			GetPlayerPos(playerid, ujraX, ujraY, ujraZ);
			Útólag átgondolva mi a fasznak kérdezem le?! :D
			*/
			if(ultetett[playerid] == 0) return Msg(playerid, "Nem is ültettél még veteményt.. #asd");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Ennyire ne siess..");
			if(megerett[playerid] == 1) return Msg(playerid, "Ezzel már elkéstél. :/");
			if(!PlayerToPoint(3.0, playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "Infó: Nem vagy a veteményed közelében! (Jelöltem a térképeden. :))");
				SetPlayerCheckpoint(playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 5);
				return 1;
			}
		
			if(params < 2) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "Használata: /drogtermesztés ápol [meglocsol, kigazolás]");
			
			if(egyezik(param[2], "meglocsol") || egyezik(param[1], "locsol"))
			{
				if(locsolhato[playerid] == 0) return Msg(playerid, "Ne locsold már egész nap azt a veteményt..");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Locsolás folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesLocsolas", 15000, false, "i", playerid);
				
			}
			if(egyezik(param[2], "kigazolás") || egyezik(param[1], "kigazolas"))
			{
				if(gazolhato[playerid] == 0) return Msg(playerid, "Ne locsold már egész nap azt a veteményt..");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Kigazolás folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesGazolas", 15000, false, "i", playerid);
			}
		}
		return 1;
	}