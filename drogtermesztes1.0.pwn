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
	vetemenyobject[playerid] = CreateDynamicObject(19473, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 0.0, 0.0, 0.0); // �J OBJEKT HELY�RE!
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
	
	vetemenyobject[playerid] = CreateDynamicObject(857, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 0.0, 0.0, 0.0);
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
			format(asd4, sizeof(asd4), "Vetem�ny\nMeglocsolva: %dx | Kigazolva: %dx\n�llapot: %s", locsolascombo[playerid], gazolascombo[playerid], veglegesallapot);
			vetemenytext[playerid] = Create3DTextLabel(asd4, COLOR_LIGHTGREEN, vetemenyX[playerid], vetemenyY[playerid], vetemenyZ[playerid], 6.0, 0, 0);
		}
		if(romlasplusz[playerid] < 4) // 3 benne van 4 m�r nincs .. -_-
		{
			romlastimer[playerid] = SetTimerEx("UltetesRomlas", veglegesrandom, false, "i", playerid);
		}
}
