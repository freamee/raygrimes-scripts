if(egyezik(cmd, "/drogtermeszt�s"))
	{
		if(params < 1) return Msg(playerid, "/drogtermeszt�s [�ltet, betakarit, �pol, inf�]");
		
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
			�t�lag �tgondolva mi a fasznak k�rdezed le?! :D
			*/
			
			if(ultetett[playerid] == 0) return Msg(playerid, "Nem is �ltett�l m�g vetem�nyt.. #asd");
			if(MunkaFolyamatban[playerid] == 1) return Msg(playerid, "Ennyire ne siess..");
			if(!PlayerToPoint(3.0, playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "Inf�: Nem vagy a vetem�nyed k�zel�ben! (Jel�ltem a t�rk�peden. :))");
				SetPlayerCheckpoint(playerid, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 5);
				return 1;
			}
		
			if(params < 2) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "Haszn�lata: /drogtermeszt�s �pol [meglocsol, kigazol�s]");
			
			if(egyezik(param[2], "meglocsol") || egyezik(param[1], "locsol"))
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetem�ny]: Locsol�s folyamatban..");
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
				MunkaFolyamatban[playerid] = 1;
				SetTimerEx("UltetesLocsolas", 15000, false, "i", playerid);
				
			}
			if(egyezik(param[2], "kigazol�s") || egyezik(param[1], "kigazolas"))
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetem�ny]: Kigazol�s folyamatban..");
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
			
			//=====================|| V�LTOZ�K|| =====================
//=====================|| �S || =====================
//=====================|| TIMEREK || =====================
new ultetett[MAX_PLAYERS]; // �LTETT�L-E VAGY SEM
new Float:vetemenyX[MAX_PLAYERS]; //--------------
new Float:vetemenyY[MAX_PLAYERS]; // FLOATOK
new Float:vetemenyZ[MAX_PLAYERS]; //--------------
new vetemenyobject[MAX_PLAYERS]; // VETEM�NY OBJECT
new Text3D:vetemenytext[MAX_PLAYERS]; // VETEM�NY 3DTEXTLABEL
//======== COMB�K, hogy ne egyhang� legyen a munka!! V�LTOZATOSS�G
new locsolascombo[MAX_PLAYERS] = 0; // H�NYSZOR LOCSOLTAD MEG
new gazolascombo[MAX_PLAYERS] = 0; // H�NYSZOR GAZOLTAD KI
new vetemenyallapota[MAX_PLAYERS] = 3; // MILYEN �LLAPOT� A VETEM�NY
new romlasplusz[MAX_PLAYERS] = 0; // H�NYSZOR FUTOTT LE A ROHAD�S TIMER
new megerett[MAX_PLAYERS] = 1;
new romlastimer[MAX_PLAYERS];

//DROG RENDSZER RAYGRIMES
forward UltetesBetakaritas(playerid);
public UltetesBetakaritas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermeszt�s]: Sikeresen betakaritottad a vetem�nyeket!");
	// OBJEKT / TEXTLABEL T�RL�SE
	Delete3DTextLabel(vetemenytext[playerid]);
	DestroyDynamicObject(vetemenyobject[playerid]);
	
	new combokoka, combohero, combomari;
	new randomszorzokoka = Rand(15, 25), randomszorzohero = Rand(10, 20), randomszorzomari = Rand(5, 15); // random grammok 15-25, 10-20, 5-15
	// comb�klat is vegy�k vele, ne legy�nk monotonok.. :D
	new nelsongenyo = locsolascombo[playerid]+gazolascombo[playerid];
	combokoka = nelsongenyo * randomszorzokoka;
	combohero = nelsongenyo * randomszorzohero;
	combomari = nelsongenyo * randomszorzomari;
	
	if(vetemenyallapota[playerid] == 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, "[Betakarit�s]: T�l rossz min�s�g� volt a vetem�nyed, ez�rt kidobtad az eg�szet..");
		return 1;
	}
	
	SendFormatMessage(playerid, COLOR_WHITE, "[Betakarit�s]: Kokain: +%dg, Heroin: +%dg, Marihuana: +%dg", combokoka, combohero, combomari);
	PlayerInfo[playerid][pKokain] += combokoka;
	PlayerInfo[playerid][pHeroin] += combohero;
	PlayerInfo[playerid][pMarihuana] += combomari;
	
	//DOLGOK RESETEL�SE!
	megerett[playerid] = 0; // nem �rett m�g meg a vetem�ny
	ultetett[playerid] = 0; // nem �ltetett m�g
	
	return 1;
}

forward UltetesLocsolas(playerid);
public UltetesLocsolas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	locsolascombo[playerid]++;
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetem�ny]: Meglocsolva!");
	
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
		case 1: veglegesallapot = "Sz�rny�";
		case 2: veglegesallapot = "Nincs �polva";
		case 3: veglegesallapot = "J�";
		case 4: veglegesallapot = "�polt";
		case 5: veglegesallapot = "Kiv�l�";
	}
	new asd3[128];
	format(asd3, sizeof(asd3), "Vetem�ny mag\nMeglocsolva: %dx | Kigazolva: %dx\n�llapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenytext[playerid] = Create3DTextLabel(asd3, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
}
forward UltetesGazolas(playerid);
public UltetesGazolas(playerid)
{
	MunkaFolyamatban[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	gazolascombo[playerid]++;
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Vetem�ny]: Kigazolva!");
	
	Delete3DTextLabel(vetemenytext[playerid]); // TEXTLABEL T�RL�SE! U.A.
	
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
		case 1: veglegesallapot = "Sz�rny�";
		case 2: veglegesallapot = "Nincs �polva";
		case 3: veglegesallapot = "J�";
		case 4: veglegesallapot = "�polt";
		case 5: veglegesallapot = "Kiv�l�";
	}
	new asd2[128];
	format(asd2, sizeof(asd2), "Vetem�ny mag\nMeglocsolva: %dx | Kigazolva: %dx\n�llapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenytext[playerid] = Create3DTextLabel(asd2, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
}
forward UltetesKesz(playerid);
public UltetesKesz(playerid)
{
	DestroyDynamicObject(vetemenyobject[playerid]); // OBJEKT KIT�RL�SE
	Delete3DTextLabel(vetemenytext[playerid]); // TEXTLABEL T�RL�SE! U.A.
	
	megerett[playerid] = 1;
	new veglegesallapot[64];
	switch(vetemenyallapota[playerid])
	{
		case 1: veglegesallapot = "Sz�rny�";
		case 2: veglegesallapot = "Nincs �polva";
		case 3: veglegesallapot = "J�";
		case 4: veglegesallapot = "�polt";
		case 5: veglegesallapot = "Kiv�l�";
	}
	new asd[128];
	format(asd, sizeof(asd), "Vetem�ny\nMeglocsolva: %dx | Kigazolva: %dx\n�llapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenyobject[playerid] = CreateDynamicObject(19473, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]-0.5, 0.0, 0.0, 0.0); // �J OBJEKT HELY�RE!
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
		case 1: veglegesallapot = "Sz�rny�";
		case 2: veglegesallapot = "Nincs �polva";
		case 3: veglegesallapot = "J�";
		case 4: veglegesallapot = "�polt";
		case 5: veglegesallapot = "Kiv�l�";
	}
	
	vetemenyobject[playerid] = CreateDynamicObject(857, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid]-0.5, 0.0, 0.0, 0.0);
	new string[128];
	format(string, sizeof(string), "Vetem�ny mag\nMeglocsolva: %dx | Kigazolva: %dx\n�llapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
	vetemenytext[playerid] = Create3DTextLabel(string, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "[Drogtermeszt�s]: Sikeresen el�ltetted a magokat!");
	TogglePlayerControllable(playerid, true);
	
	new mikorkesz = Rand(1, 2);
	new ekkor;
	switch(mikorkesz)
	{
		case 1: ekkor = 10;
		case 2: ekkor = 15;
	}
	SetTimerEx("UltetesKesz", ekkor*60000, false, "i", playerid);
	
	// AUTOMATIKUS ROHAD�S!! j�l hangzik mi? :d
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
				case 1: veglegesallapot = "Sz�rny�";
				case 2: veglegesallapot = "Nincs �polva";
				case 3: veglegesallapot = "J�";
				case 4: veglegesallapot = "�polt";
				case 5: veglegesallapot = "Kiv�l�";
			}
			Delete3DTextLabel(vetemenytext[playerid]);
			new asd4[128];
			format(asd4, sizeof(asd4), "Vetem�ny mag\nMeglocsolva: %dx | Kigazolva: %dx\n�llapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
			vetemenytext[playerid] = Create3DTextLabel(asd4, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
		}
		if(romlasplusz[playerid] < 4) // 3 benne van 4 m�r nincs .. -_-
		{
			romlastimer[playerid] = SetTimerEx("UltetesRomlas", veglegesrandom, false, "i", playerid);
		}
}
	
	
