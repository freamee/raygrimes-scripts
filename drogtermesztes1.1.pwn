if(egyezik(cmd, "/drogtermesztés"))
	{
		if(params < 1) return Msg(playerid, "/drogtermesztés [ültet, betakarit, ápol, infó]");
		
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
			Útólag átgondolva mi a fasznak kérdezed le?! :D
			*/
			
			if(ultetett[playerid] == 0) return Msg(playerid, "Nem is ültettél még veteményt.. #asd");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Ennyire ne siess..");
			if(!PlayerToPoint(3.0, playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "Infó: Nem vagy a veteményed közelében! (Jelöltem a térképeden. :))");
				SetPlayerCheckpoint(playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 5);
				return 1;
			}
		
			if(params < 2) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "Használata: /drogtermesztés ápol [meglocsol, kigazolás]");
			
			if(egyezik(param[2], "meglocsol") || egyezik(param[1], "locsol"))
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Locsolás folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesLocsolas", 15000, false, "i", playerid);
				
			}
			if(egyezik(param[2], "kigazolás") || egyezik(param[1], "kigazolas"))
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Kigazolás folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesGazolas", 15000, false, "i", playerid);
			}
		}
		return 1;
	}
	
	
	
	
	//======================================
		//======================================
			//======================================
			
			//=====================|| VÁLTOZÓK|| =====================
//=====================|| ÉS || =====================
//=====================|| TIMEREK || =====================
new ultetett[MAX_PLAYERS]; // ÜLTETTÉL-E VAGY SEM
new Float:vetemenyX[MAX_PLAYERS]; //--------------
new Float:vetemenyY[MAX_PLAYERS]; // FLOATOK
new Float:vetemenyZ[MAX_PLAYERS]; //--------------
new vetemenyobject[MAX_PLAYERS]; // VETEMÉNY OBJECT
new Text3D:vetemenytext[MAX_PLAYERS]; // VETEMÉNY 3DTEXTLABEL
//======== COMBÓK, hogy ne egyhangú legyen a munka!! VÁLTOZATOSSÁG
new locsolascombo[MAX_PLAYERS] = 0; // HÁNYSZOR LOCSOLTAD MEG
new gazolascombo[MAX_PLAYERS] = 0; // HÁNYSZOR GAZOLTAD KI
new vetemenyallapota[MAX_PLAYERS] = 3; // MILYEN ÁLLAPOTÚ A VETEMÉNY
new romlasplusz[MAX_PLAYERS] = 0; // HÁNYSZOR FUTOTT LE A ROHADÁS TIMER
new megerett[MAX_PLAYERS] = 1;
new romlastimer[MAX_PLAYERS];

//DROG RENDSZER RAYGRIMES
forward UltetesBetakaritas(playerid);
public UltetesBetakaritas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermesztés]: Sikeresen betakaritottad a veteményeket!");
	// OBJEKT / TEXTLABEL TÖRLÉSE
	Delete3DTextLabel(vetemenytext[playerid]);
	DestroyDynamicObject(vetemenyobject[playerid]);
	
	new combokoka, combohero, combomari;
	new randomszorzokoka = Rand(15, 25), randomszorzohero = Rand(10, 20), randomszorzomari = Rand(5, 15); // random grammok 15-25, 10-20, 5-15
	// combóklat is vegyük vele, ne legyünk monotonok.. :D
	new nelsongenyo = locsolascombo[playerid]+gazolascombo[playerid];
	combokoka = nelsongenyo * randomszorzokoka;
	combohero = nelsongenyo * randomszorzohero;
	combomari = nelsongenyo * randomszorzomari;
	
	if(vetemenyallapota[playerid] == 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, "[Betakaritás]: Túl rossz minõségû volt a veteményed, ezért kidobtad az egészet..");
		return 1;
	}
	
	SendFormatMessage(playerid, COLOR_WHITE, "[Betakaritás]: Kokain: +%dg, Heroin: +%dg, Marihuana: +%dg", combokoka, combohero, combomari);
	PlayerInfo[playerid][pKokain] += combokoka;
	PlayerInfo[playerid][pHeroin] += combohero;
	PlayerInfo[playerid][pMarihuana] += combomari;
	
	//DOLGOK RESETELÉSE!
	megerett[playerid] = 0; // nem érett még meg a vetemény
	ultetett[playerid] = 0; // nem ültetett még
	
	return 1;
}

forward UltetesLocsolas(playerid);
public UltetesLocsolas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	locsolascombo[playerid]++;
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Meglocsolva!");
	
	Delete3DTextLabel(vetemenytext[playerid]);
	
	if(locsolascombo[playerid] == 2)
	{
		if(vetemenyallapota[playerid] != 5)
		{
			vetemenyallapota[playerid]++;
		}
	}
	new veglegesallapot[64];
	switch(vetemenyallapota[playerid])
	{
		case 1: veglegesallapot = "Szörnyû";
		case 2: veglegesallapot = "Nincs ápolva";
		case 3: veglegesallapot = "Jó";
		case 4: veglegesallapot = "Ápolt";
		case 5: veglegesallapot = "Kiváló";
	}
	new asd3[128];
	format(asd3, sizeof(asd3), "Vetemény mag\nMeglocsolva: %dx | Kigazolva: %dx\nÁllapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenytext[playerid] = Create3DTextLabel(asd3, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
}
forward UltetesGazolas(playerid);
public UltetesGazolas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	gazolascombo[playerid]++;
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Kigazolva!");
	
	Delete3DTextLabel(vetemenytext[playerid]); // TEXTLABEL TÖRLÉSE! U.A.
	
	if(gazolascombo[playerid] == 2)
	{
		if(vetemenyallapota[playerid] != 5)
		{
			vetemenyallapota[playerid]++;
		}
	}
	new veglegesallapot[64];
	switch(vetemenyallapota[playerid])
	{
		case 1: veglegesallapot = "Szörnyû";
		case 2: veglegesallapot = "Nincs ápolva";
		case 3: veglegesallapot = "Jó";
		case 4: veglegesallapot = "Ápolt";
		case 5: veglegesallapot = "Kiváló";
	}
	new asd2[128];
	format(asd2, sizeof(asd2), "Vetemény mag\nMeglocsolva: %dx | Kigazolva: %dx\nÁllapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenytext[playerid] = Create3DTextLabel(asd2, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
}
forward UltetesKesz(playerid);
public UltetesKesz(playerid)
{
	DestroyDynamicObject(vetemenyobject[playerid]); // OBJEKT KITÖRLÉSE
	Delete3DTextLabel(vetemenytext[playerid]); // TEXTLABEL TÖRLÉSE! U.A.
	
	megerett[playerid] = 1;
	new veglegesallapot[64];
	switch(vetemenyallapota[playerid])
	{
		case 1: veglegesallapot = "Szörnyû";
		case 2: veglegesallapot = "Nincs ápolva";
		case 3: veglegesallapot = "Jó";
		case 4: veglegesallapot = "Ápolt";
		case 5: veglegesallapot = "Kiváló";
	}
	new asd[128];
	format(asd, sizeof(asd), "Vetemény\nMeglocsolva: %dx | Kigazolva: %dx\nÁllapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenyobject[playerid] = CreateDynamicObject(19473, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]-0.5, 0.0, 0.0, 0.0); // ÚJ OBJEKT HELYÉRE!
	vetemenytext[playerid] = Create3DTextLabel(asd, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
}
forward UltetesVarakoztatas(playerid);
public UltetesVarakoztatas(playerid)
{
	ultetett[playerid] = 1;
	PlayerInfo[playerid][pCserje] -= 5;
	PlayerInfo[playerid][pMak] -= 5;
	PlayerInfo[playerid][pCannabis] -= 5;
	MunkaFolyamatban[playerid] = 0;
	
	new veglegesallapot[64];
	vetemenyallapota[playerid] = 3;
	romlasplusz[playerid] = 0;
	megerett[playerid] = 0;
	switch(vetemenyallapota[playerid])
	{
		case 1: veglegesallapot = "Szörnyû";
		case 2: veglegesallapot = "Nincs ápolva";
		case 3: veglegesallapot = "Jó";
		case 4: veglegesallapot = "Ápolt";
		case 5: veglegesallapot = "Kiváló";
	}
	
	vetemenyobject[playerid] = CreateDynamicObject(857, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]-0.5, 0.0, 0.0, 0.0);
	new string[128];
	format(string, sizeof(string), "Vetemény mag\nMeglocsolva: %dx | Kigazolva: %dx\nÁllapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenytext[playerid] = Create3DTextLabel(string, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermesztés]: Sikeresen elültetted a magokat!");
	TogglePlayerControllable(playerid, true);
	
	new mikorkesz = Rand(1, 2);
	new ekkor;
	switch(mikorkesz)
	{
		case 1: ekkor = 10;
		case 2: ekkor = 15;
	}
	SetTimerEx("UltetesKesz", ekkor*60000, false, "i", playerid);
	
	// AUTOMATIKUS ROHADÁS!! jól hangzik mi? :d
	new randomidoszerint = Rand(1, 3);
	new veglegesrandom;
	switch(randomidoszerint)
	{
		case 1: veglegesrandom = 2; //  2PERC
		case 2: veglegesrandom = 3; // 3PERC
		case 3: veglegesrandom = 5; // 5PERC
	}
	romlastimer[playerid] = SetTimerEx("UltetesRomlas", veglegesrandom*60000, false, "i", playerid);
}
forward UltetesRomlas(playerid);
public UltetesRomlas(playerid)
{
	if(megerett[playerid] == 1) KillTimer(romlastimer[playerid]);
	
		new randomidoszerint = Rand(1, 3);
		new veglegesrandom;
		switch(randomidoszerint)
		{
			case 1: veglegesrandom = 120000; //  2PERC
			case 2: veglegesrandom = 180000; // 3PERC
			case 3: veglegesrandom = 300000; // 5PERC
		}
		romlasplusz[playerid]++;
		if(vetemenyallapota[playerid] != 1)
		{
			vetemenyallapota[playerid]--;
			new veglegesallapot[64];
			switch(vetemenyallapota[playerid])
			{
				case 1: veglegesallapot = "Szörnyû";
				case 2: veglegesallapot = "Nincs ápolva";
				case 3: veglegesallapot = "Jó";
				case 4: veglegesallapot = "Ápolt";
				case 5: veglegesallapot = "Kiváló";
			}
			Delete3DTextLabel(vetemenytext[playerid]);
			new asd4[128];
			format(asd4, sizeof(asd4), "Vetemény mag\nMeglocsolva: %dx | Kigazolva: %dx\nÁllapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
			vetemenytext[playerid] = Create3DTextLabel(asd4, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
		}
		if(romlasplusz[playerid] < 4) // 3 benne van 4 már nincs .. -_-
		{
			romlastimer[playerid] = SetTimerEx("UltetesRomlas", veglegesrandom, false, "i", playerid);
		}
}
	
	
