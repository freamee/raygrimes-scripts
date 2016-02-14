

new benzinkutlogolas[MAX_PLAYERS] = 0;
new benzinkutjovedelem[MAX_PLAYERS] = 0;
forward Benzinkut(playerid);
new benzinkuttick = 0;

public Benzinkut(playerid)
{
	for(new b = 0; b < MAX_BENZINKUT; b++)
	{
		if(benzinkutjovedelem[playerid] == 1)
		{
			if(BenzinKutak[b][bSzint] >= 1)
			{
				new bid = IsAtGasStation(playerid);
				
				if(bid != NINCS) // Ha benzinkúton van
				{
					if(benzinkutlogolas[playerid] == 1) // logolás bekapcsolva
					{
						new szorzoja2 = Rand(500, 1000);
						new osszeg2 = BenzinKutak[bid][bSzint]*szorzoja2;
						BenzinKutak[bid][bSzef] += osszeg2;
						//BenzinKutak[b][bBenzin] -= 1;
						
						SendFormatMessage(playerid, COLOR_GREY, "[Benzinkútlog] Benzinkút bevétel: +%dFt", osszeg2);
					}
					else if(benzinkutlogolas[playerid] == 0)
					{
						new szorzoja2 = Rand(500, 1000);
						new osszeg2 = BenzinKutak[bid][bSzint]*szorzoja2;
						BenzinKutak[bid][bSzef] += osszeg2;
						//BenzinKutak[b][bBenzin] -= 1;
					}
				}
				else
				{
					new szorzoja = Rand(500, 1000);
					new osszeg = BenzinKutak[b][bSzint]*szorzoja;
					BenzinKutak[b][bSzef] += osszeg;
					//BenzinKutak[b][bBenzin] -= 1;
				}
				
				if(benzinkuttick != 10)
				{
					benzinkuttick++; 
				}
				else
				{
					BenzinKutak[b][bBenzin] -= 1;
					benzinkuttick = 0;
				}
			}
		}
	}
	return 1;
}

//======================================================================
//====================FIX BEVÉTEL BENZINKUTAKNAK====================
// PARANCSOK PARANCSOK PARANCSOK
//======================================================================
if(egyezik(param[1], "jövedelem"))
		{
			new bid = IsAtGasStation(playerid);
			if(bid == NINCS) return Msg(playerid, "Nem vagy benzinkútnál.");
			if(!egyezik(PlayerName(playerid), BenzinKutak[bid][bBerlo]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bOwner]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bExtortion])) return Msg(playerid, "Ez a benzinkút nem a tiéd, vagy nincs benzinkutad..");
			
			if(benzinkutjovedelem[playerid] == 0)
			{
				benzinkutjovedelem[playerid] = 1;
				SendClientMessage(playerid, COLOR_GREY, "[Benzinkút] Bekapcsoltad a benzinkút jövedelem rendszerét..!");
				SendClientMessage(playerid, COLOR_GREY, "[Benzinkút] /benzinkút infó2 - bõvebb leirás");
			}
			else
			{
				benzinkutjovedelem[playerid] = 0;
				SendClientMessage(playerid, COLOR_GREY, "[Benzinkút] Kikapcsoltad a benzinkút jövedelmét!");
			}
		}
		if(egyezik(param[1], "bevétel"))
		{
			new bid = IsAtGasStation(playerid);
			if(bid == NINCS) return Msg(playerid, "Nem vagy benzinkútnál.");
			if(!egyezik(PlayerName(playerid), BenzinKutak[bid][bBerlo]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bOwner]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bExtortion])) return Msg(playerid, "Ez a benzinkút nem a tiéd, vagy nincs benzinkutad..");
				
			if(benzinkutjovedelem[playerid] == 1)
			{
				if(benzinkutlogolas[playerid] == 0)
				{
					benzinkutlogolas[playerid] = 1;
					SendClientMessage(playerid, COLOR_GREY, "[Benzinkútlog] Bekapcsoltad a bevétel logolását, 30 másodpercenként kapod az értesitést!");
					SendClientMessage(playerid, COLOR_GREY, "[Benzinkútlog] Értesitést csak akkor kapsz ha közel vagy a benzinkutadhoz!");
				}
				else
				{
					benzinkutlogolas[playerid] = 0;
					SendClientMessage(playerid, COLOR_GREY, "[Benzinkútlog] Kikapcsoltad a bevétel logolást!");
				}
			}
			else
			{
				Msg(playerid, "Elõször a jövedelem rendszert kapcsold be! (/benzinkút jövedelem)");
			}
		}
		if(egyezik(param[1],"szint"))
		{
			if(params < 2) return Msg(playerid, "/benzinkút szint [fejleszt / ara / leirás]");
			if(egyezik(param[2], "fejleszt"))
			{
				new bid = IsAtGasStation(playerid);
				if(bid == NINCS) return Msg(playerid, "Nem vagy benzinkútnál.");
				if(!egyezik(PlayerName(playerid), BenzinKutak[bid][bBerlo]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bOwner]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bExtortion]) && !IsScripter(playerid)) return Msg(playerid, "Ez a benzinkút nem a tiéd.");
				
				if(BenzinKutak[bid][bSzint] == 10) return SendClientMessage(playerid, COLOR_YELLOW, "Elérted a maximális benzinkút szintet! (Max lvl10)");
				
				new mennyibe;
				new szintje;
				switch(BenzinKutak[bid][bSzint])
				{
					case 0: { mennyibe = 5000000; szintje = 1; }
					case 1: { mennyibe = 15000000; szintje = 2; }
					case 2: { mennyibe = 30000000; szintje = 3; }
					case 3: { mennyibe = 60000000; szintje = 4; }
					case 4: { mennyibe = 100000000; szintje = 5; }
					case 5: { mennyibe = 130000000; szintje = 6; }
					case 6: { mennyibe = 160000000; szintje = 7; }
					case 7: { mennyibe = 200000000; szintje = 8; }
					case 8: { mennyibe = 240000000; szintje = 9; }
					case 9: { mennyibe = 300000000; szintje = 10; }
				}
				if(PlayerInfo[playerid][pAccount] < mennyibe) return Msg(playerid, "Nincs elég pénzed!");
			
				PlayerInfo[playerid][pAccount] -= mennyibe;
				BenzinKutak[bid][bSzint] = szintje;
				SendClientMessage(playerid, COLOR_WHITE, "Fejlesztés: Sikeresen fejlesztetted a benzinkutadat!");
				SendFormatMessage(playerid, COLOR_WHITE, "Fejlesztés: Új szint: %dlvl | Ennyibe került: %dFt", szintje, mennyibe);
				SaveBenzinKutak();
			}
			if(egyezik(param[2], "ara") || egyezik(param[2], "ára"))
			{
				new bid = IsAtGasStation(playerid);
				if(bid == NINCS) return Msg(playerid, "Nem vagy benzinkútnál.");
				if(!egyezik(PlayerName(playerid), BenzinKutak[bid][bBerlo]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bOwner]) && !egyezik(PlayerName(playerid), BizzInfo[BIZ_OLAJ][bExtortion]) && !IsScripter(playerid)) return Msg(playerid, "Ez a benzinkút nem a tiéd.");
				
				new mennyiazara;
				switch(BenzinKutak[bid][bSzint])
				{
					case 0: mennyiazara = 5000000;
					case 1: mennyiazara = 15000000;
					case 2: mennyiazara = 30000000;
					case 3: mennyiazara = 60000000;
					case 4: mennyiazara = 100000000;
					case 5: mennyiazara = 130000000;
					case 6: mennyiazara = 160000000;
					case 7: mennyiazara = 200000000;
					case 8: mennyiazara = 240000000;
					case 9: mennyiazara = 300000000;
					case 10: SendClientMessage(playerid, COLOR_YELLOW, "Fejlesztés: Elérted a maximális benzinkút szintet! (max 10lvl)");
				}
				SendFormatMessage(playerid, COLOR_WHITE, "Fejlesztés: Következõ szint ára: %dFt", mennyiazara);
			}
			if(egyezik(param[2], "leirás") || egyezik(param[2], "leiras"))
			{
			
			}
		}