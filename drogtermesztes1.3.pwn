//=====================|| VÁLTOZÓK|| =====================
//=====================|| ÉS || =====================
//=====================|| TIMEREK || =====================
new ultetett[MAX_PLAYERS]; // ÜLTETTÉL-E VAGY SEM
new Float:vetemenyX[MAX_PLAYERS]; //--------------
new Float:vetemenyY[MAX_PLAYERS]; // FLOATOK
new Float:vetemenyZ[MAX_PLAYERS]; //--------------
new Float:vetemenyX2[MAX_PLAYERS]; //--------------
new Float:vetemenyY2[MAX_PLAYERS]; // FLOATOK
new Float:vetemenyZ2[MAX_PLAYERS]; //--------------
new Float:vetemenyX3[MAX_PLAYERS]; //--------------
new Float:vetemenyY3[MAX_PLAYERS]; // FLOATOK
new Float:vetemenyZ3[MAX_PLAYERS]; //--------------
new vetemenyobject[MAX_PLAYERS]; // VETEMÉNY OBJECT
new vetemenyobject2[MAX_PLAYERS]; // VETEMÉNY OBJECT
new vetemenyobject3[MAX_PLAYERS]; // VETEMÉNY OBJECT
new Text3D:vetemenytext[MAX_PLAYERS]; // VETEMÉNY 3DTEXTLABEL
new Text3D:vetemenytext2[MAX_PLAYERS]; // VETEMÉNY 3DTEXTLABEL
new Text3D:vetemenytext3[MAX_PLAYERS]; // VETEMÉNY 3DTEXTLABEL
//======== COMBÓK, hogy ne egyhangú legyen a munka!! VÁLTOZATOSSÁG
new locsolascombo[MAX_PLAYERS] = 0; // HÁNYSZOR LOCSOLTAD MEG
new gazolascombo[MAX_PLAYERS] = 0; // HÁNYSZOR GAZOLTAD KI
new vetemenyallapota[MAX_PLAYERS] = 3; // MILYEN ÁLLAPOTÚ A VETEMÉNY
new romlasplusz[MAX_PLAYERS] = 0; // HÁNYSZOR FUTOTT LE A ROHADÁS TIMER
new megerett[MAX_PLAYERS] = 1;
new romlastimer[MAX_PLAYERS];
new locsolhato[MAX_PLAYERS];
new gazolhato[MAX_PLAYERS];
new lentvanazegyik[MAX_PLAYERS] = 0;
new planteles[MAX_PLAYERS] = 0;

enum Drogtermesztes
{
	pOsszes,
	pKoka,
	pHero,
	pMari,
	pLocsolas,
	pGazolas,
	pBetakaritott
}
new pDrogtermesztes[MAX_PLAYERS][Drogtermesztes];

//DROG RENDSZER RAYGRIMES
forward UltetesBetakaritas(playerid);
public UltetesBetakaritas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermesztés]: Sikeresen betakaritottad a veteményeket!");
	// OBJEKT / TEXTLABEL TÖRLÉSE
	Delete3DTextLabel(vetemenytext[playerid]);
	Delete3DTextLabel(vetemenytext2[playerid]);
	Delete3DTextLabel(vetemenytext3[playerid]);
	DestroyDynamicObject(vetemenyobject[playerid]);
	DestroyDynamicObject(vetemenyobject2[playerid]);
	DestroyDynamicObject(vetemenyobject3[playerid]);
	
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
	pDrogtermesztes[playerid][pBetakaritott]++;
	pDrogtermesztes[playerid][pKoka] += combokoka;
	pDrogtermesztes[playerid][pHero] += combohero;
	pDrogtermesztes[playerid][pMari] += combomari;
	
	//DOLGOK RESETELÉSE!
	megerett[playerid] = 0; // nem érett még meg a vetemény
	ultetett[playerid] = 0; // nem ültetett még
	
	return 1;
}

forward LocsolasTimer(playerid);
public LocsolasTimer(playerid)
{
	locsolhato[playerid] = 1;
	SendClientMessage(playerid, COLOR_GREY, "Újra meglocsolhatod a veteményeket!");
	return 1;
}
forward GazolasTimer(playerid);
public GazolasTimer(playerid)
{
	/*if(ultetett[playerid] == 1)
	{
		if(megerett[playerid] == 0)
		{*/
			gazolhato[playerid] = 1;
			SendClientMessage(playerid, COLOR_GREY, "Újra kigazolhatod a veteményeket!");
	/*	}
	}*/
	return 1;
}

forward UltetesLocsolas(playerid);
public UltetesLocsolas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	locsolascombo[playerid]++;
	TogglePlayerControllable(playerid, true);
	pDrogtermesztes[playerid][pLocsolas]++;
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Meglocsolva!");
	
	if(vetemenyallapota[playerid] != 5)
	{
		vetemenyallapota[playerid]++;
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
	//vetemenytext[playerid] = Create3DTextLabel(asd3, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
	Update3DTextLabelText(vetemenytext[playerid], COLOR_LIGHTGREEN, asd3);
	Update3DTextLabelText(vetemenytext2[playerid], COLOR_LIGHTGREEN, asd3);
	Update3DTextLabelText(vetemenytext3[playerid], COLOR_LIGHTGREEN, asd3);
	locsolhato[playerid] = 0;
	SetTimerEx("LocsolasTimer", 120000, false, "i", playerid);
}
forward UltetesGazolas(playerid);
public UltetesGazolas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	gazolascombo[playerid]++;
	pDrogtermesztes[playerid][pGazolas]++;
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetemény]: Kigazolva!");
	
	if(vetemenyallapota[playerid] != 5)
	{
			vetemenyallapota[playerid]++;
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
	//vetemenytext[playerid] = Create3DTextLabel(asd2, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
	Update3DTextLabelText(vetemenytext[playerid], COLOR_LIGHTGREEN, asd2);
	Update3DTextLabelText(vetemenytext2[playerid], COLOR_LIGHTGREEN, asd2);
	Update3DTextLabelText(vetemenytext3[playerid], COLOR_LIGHTGREEN, asd2);
	gazolhato[playerid] = 0;
	SetTimerEx("GazolasTimer", 120000, false, "i", playerid);
}
forward UltetesKesz(playerid);
public UltetesKesz(playerid)
{
	DestroyDynamicObject(vetemenyobject[playerid]); // OBJEKT KITÖRLÉSE
	DestroyDynamicObject(vetemenyobject2[playerid]); // OBJEKT KITÖRLÉSE
	DestroyDynamicObject(vetemenyobject3[playerid]); // OBJEKT KITÖRLÉSE
	
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
	vetemenyobject[playerid] = CreateDynamicObject(19473, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]-1, 0.0, 0.0, 0.0); // ÚJ OBJEKT HELYÉRE!
	vetemenyobject2[playerid] = CreateDynamicObject(19473, vetemenyX2[playerid], vetemenyY2[playerid], vetemenyZ2[playerid]-1, 0.0, 0.0, 0.0); // ÚJ OBJEKT HELYÉRE!
	vetemenyobject3[playerid] = CreateDynamicObject(19473, vetemenyX3[playerid], vetemenyY3[playerid], vetemenyZ3[playerid]-1, 0.0, 0.0, 0.0); // ÚJ OBJEKT HELYÉRE!
	//vetemenytext[playerid] = Create3DTextLabel(asd, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
	Update3DTextLabelText(vetemenytext[playerid], COLOR_LIGHTGREEN, asd);
	Update3DTextLabelText(vetemenytext2[playerid], COLOR_LIGHTGREEN, asd);
	Update3DTextLabelText(vetemenytext3[playerid], COLOR_LIGHTGREEN, asd);
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
	locsolhato[playerid] = 1;
	gazolhato[playerid] = 1;
	locsolascombo[playerid] = 0;
	gazolascombo[playerid] = 0;
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
	Update3DTextLabelText(vetemenytext[playerid], COLOR_LIGHTGREEN, string);
	planteles[playerid] = 1;
	lentvanazegyik[playerid] = 1;
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermesztés]: Sikeresen elültetted a magokat!");
	SendClientMessage(playerid, COLOR_GREY, "OOC infó: Guggolás gombbal tedd le a magokat!");
	TogglePlayerControllable(playerid, true);
	pDrogtermesztes[playerid][pOsszes]++;
	
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
	//if(megerett[playerid] == 1) KillTimer(romlastimer[playerid]);
	
	if(megerett[playerid] == 0)
	{
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
			new asd4[128];
			format(asd4, sizeof(asd4), "Vetemény mag\nMeglocsolva: %dx | Kigazolva: %dx\nÁllapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
			//vetemenytext[playerid] = Create3DTextLabel(asd4, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
			Update3DTextLabelText(vetemenytext[playerid], COLOR_LIGHTGREEN, asd4);
			Update3DTextLabelText(vetemenytext2[playerid], COLOR_LIGHTGREEN, asd4);
			Update3DTextLabelText(vetemenytext3[playerid], COLOR_LIGHTGREEN, asd4);
		}
		if(romlasplusz[playerid] < 4) // 3 benne van 4 már nincs .. -_-
		{
			romlastimer[playerid] = SetTimerEx("UltetesRomlas", veglegesrandom, false, "i", playerid);
		}
	}
}
forward LoadDrogtermesztes(playerid);
public LoadDrogtermesztes(playerid)
{
		new drognev[MAX_PLAYER_NAME];
		new drogszam[256]; 
		GetPlayerName(playerid, drognev, sizeof(drognev));
		format(drogszam, sizeof(drogszam), "Drogtermesztes/%s.ini",drognev); 
		new logolas[64];
		if(!dini_Exists(drogszam))
		{
			dini_Create(drogszam);
			
			dini_IntSet(drogszam, "Osszes",0);
			dini_IntSet(drogszam,"Locsolas",0);
			dini_IntSet(drogszam,"Gazolas",0);
			dini_IntSet(drogszam, "Kokain",0);
			dini_IntSet(drogszam, "Heroin",0);
			dini_IntSet(drogszam, "Marihuana",0);
			dini_IntSet(drogszam, "Betakaritott",0);
			
			pDrogtermesztes[playerid][pOsszes] = dini_Int(drogszam, "Osszes");
			pDrogtermesztes[playerid][pLocsolas] = dini_Int(drogszam, "Locsolas");
			pDrogtermesztes[playerid][pGazolas] = dini_Int(drogszam, "Gazolas");
			pDrogtermesztes[playerid][pKoka] = dini_Int(drogszam, "Kokain");
			pDrogtermesztes[playerid][pHero] = dini_Int(drogszam, "Heroin");
			pDrogtermesztes[playerid][pMari] = dini_Int(drogszam, "Marihuana");
			pDrogtermesztes[playerid][pBetakaritott] = dini_Int(drogszam, "Betakaritott");
			format(logolas, sizeof(logolas), "%s drogtermesztes ini letrehozva.", drognev);
			printf(logolas);
		}
		else
		{
			pDrogtermesztes[playerid][pOsszes] = dini_Int(drogszam, "Osszes");
			pDrogtermesztes[playerid][pLocsolas] = dini_Int(drogszam, "Locsolas");
			pDrogtermesztes[playerid][pGazolas] = dini_Int(drogszam, "Gazolas");
			pDrogtermesztes[playerid][pKoka] = dini_Int(drogszam, "Kokain");
			pDrogtermesztes[playerid][pHero] = dini_Int(drogszam, "Heroin");
			pDrogtermesztes[playerid][pMari] = dini_Int(drogszam, "Marihuana");
			pDrogtermesztes[playerid][pBetakaritott] = dini_Int(drogszam, "Betakaritott");
			format(logolas, sizeof(logolas), "%s drogtermesztes ini betoltve.", drognev);
			printf(logolas);
		}
}
forward SaveDrogtermesztes(playerid);
public SaveDrogtermesztes(playerid)
{
	new nev[MAX_PLAYER_NAME];
	new szam[100];
	GetPlayerName(playerid, nev, sizeof(nev));
    format(szam, sizeof(szam), "Drogtermesztes/%s.ini",nev);
	if(fexist(szam))
	{
		dini_IntSet(szam, "Osszes", pDrogtermesztes[playerid][pOsszes]);
		dini_IntSet(szam, "Locsolas", pDrogtermesztes[playerid][pLocsolas]);
		dini_IntSet(szam, "Gazolas", pDrogtermesztes[playerid][pGazolas]);
		dini_IntSet(szam, "Kokain", pDrogtermesztes[playerid][pKoka]);
		dini_IntSet(szam, "Heroin", pDrogtermesztes[playerid][pHero]);
		dini_IntSet(szam, "Marihuana", pDrogtermesztes[playerid][pMari]);
		dini_IntSet(szam, "Betakaritott", pDrogtermesztes[playerid][pBetakaritott]);
		new logolas2[64];
		format(logolas2, sizeof(logolas2), "%s drogtermesztes inije mentve.", nev);
		printf(logolas2);
	}
	return 1;
}