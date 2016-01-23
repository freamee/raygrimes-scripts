[font=verdana]Csácsá, kész lettem a /fish újrairásával, tudod amirõl beszéltünk.
Próbálgattuk többen is a munkát, nem találtunk bugot, ha valami probléma lenne akkor javitsátok vagy irjatok. :/
Ha bekerül akkor küldöm a pénzt. (kinek a bszére? azt majd ird le)

Esetleg ha valamit túlzásnak tartotok akkor vegyétek ki belõle, és örülnék neki hogyha szólnátok is, mert tudni szeretnék róla, hogy mi az amivel túllõttem a "célon".

# definek, változók, timerek létrehozása (mód elejére) http://pastebin.com/L4t4Etw5
# enum, (dini mentéshez) | fontos hogy ne crasheljen a mód: scriptfiles mappába hozz létre egy Halak mappát!!! (C:\Users\Krisztián\Desktop\pawno\scriptfiles\Halak)
http://pastebin.com/xdNM3xe0

# onplayerconnect (betöltés) http://pastebin.com/L4Y0rcPb
# onplayerdisconnect (mentés) http://pastebin.com/Qj7Z30cZ
# a scriptet nem zcmdben irtam, ha jól tudom class módban old_commands.pwn alatt vannak az strcmp parancsok, tedd a /fish helyére az egészet szerintem. http://pastebin.com/7UzEEGN0
# a timerek http://pastebin.com/GFyyqEGA

Szólj hogyha kihagytam valamit, vagy nem sikerülne, vagy valami lenne.
Õõ, bocs hogy lesz egy kis munkád, de valószinû hogy a régi horgászbot/csalikat kikéne venni a módból, mivel újra irtam ebben, diniben, és a santa marián lehet venni "Horgászbolt"nál.
(PlayerInfo[playerid][pCsali], PlayerInfo[playerid][pHorgaszbot] -- ezeket kéne kigyilkolnod, vagy átirni a saját scriptemre ezeket. :/) 

Ha úgy döntötök hogy mégsem kerülne be akkor kaphatnék egy értesitést?

Na köszkösz, pacsi!

[hr]
[hr]
[hr]
[size=24pt]LEIRÁS A SCRIPTÕL HA BEKERÜLNE?![/size]

[font=verdana][size=12pt][color=white]============ [[color=yellow]Horgászat[color=white]] ============
[li][font=verdana]/fish parancs helyett --> /horgászat [bedob, beránt, helyek, elad, vesz, halaim, toplista, árak, info][/li]
[li][font=verdana]Csalit / horgászbotot újra meg kell venni. (Santa marián lehet, /horgászat vesz)[/li]
[li][font=verdana]A munkát továbbra sem kell felvenni a városházán.[/li]
[li][font=verdana]Megújult horgászhelyek (tengeren, tavaknál), azok közelében lehet már csak horgászni. Jelenleg 6db horgászhely van.
[li][font=verdana]Skillekhez vannak kiosztva a horgászhelyek. Ha nincs meg az elegendõ skilled, akkor nem tudsz ott horgászni.[/li]
[li][font=verdana]Horgászhelytõl függõen más halat fogsz. (értékesebb/értéktelenebb)[/li][/li]
[li][font=verdana]Adminok tudják ingame állitani a "kapásidõt", vagyis a pecabot bedobásától számitott timert.[/li]
[li][font=verdana]Adminoknak logol minden timert, tehát hány másodperc van kapásig, stb.[/li]
[li][font=verdana]Továbbra is maximum 5db hal lehet nálunk.[/li]
[li][font=verdana]Amint bedobtuk a horgászbotot, nem tudjuk kihúzni, tehát freezelve vagyunk amig véget nem ér a timer.[/li]
[li][font=verdana]Ha kapásunk van és nem reagálunk idõben, akkor leakad a horogról a hal.[/li]
[li][font=verdana]A halakat továbbra is visszalehet dobni, /horgászat visszadob paranccsal.[/li]
[li][font=verdana]Shortolni ne próbáljátok a munkát. IG értesit a rendszer hogyha sokszor beirjuk a /horgászat beránt parancsot.[/li]
[li][font=verdana]A munka legtöbb eleme skillhez van kötve, minden összefügg a skill mennyiséggel.[/li]
[font=verdana][size=9pt][color=lightgreen]Skilltõl függ (folyamatosan csökken/nõ)
[li][font=verdana]Hány kilós halat fogsz.[/li]
[li][font=verdana]Hány másodperc alatt tekered fel az órsót. (amint berántottál) [8-1 másodperc][/li]
[li][font=verdana]Hány másodperced van reagálni a kapásra. [8-3 másodperc][/li]
[li][font=verdana]Horgászhelyek használata[/li]
[font=verdana][size=9pt][color=lightgreen]Toplista rendszer
[li][font=verdana]Top 3 embert jeleniti meg.[/li]
[li][font=verdana]Bekerült egy toplista rendszer is. Ami a kifogott halak alapján állit fel egy listát. Azért került be ez a parancs, mivel szerintem sokan szeretnek versenyezni, és ezzel meghozva egy kicsit a kedvüket a munkához. "versenyszellem" | Parancs: /horgászat toplista[/li]
[li][font=verdana]Toplista, csak az online playereket jeleniti meg. Tehát ha online player akkor irja csak top1-nél, ha lelép akkor más lesz a top1. [/li]
[font=verdana][size=10pt][color=lightgreen]Halakról bõvebb leirás
[li][font=verdana]Nem fogjuk leirni hogy melyiket, melyik horgászhelyen lehet fogni, ezeket tapasztaljátok ki ti magatok![/li]
[li][font=verdana]Minden halra külön százalék van irva, ettõl függ hogy melyiket fogod ki. Egy adott horgászhelyen általában több féle halat lehet fogni, és százalék alapján dönti el hogy melyiket kapod.[/li]
[li][font=verdana]Halak árát ingame megtekinthetitek. /horgászat árak
[hr]
[font=verdana][size=10pt][color=lightgreen]Új halak
[li][font=verdana]Sügér[/li]
[li][font=verdana]Csattogóhal[/li]
[li][font=verdana]Pisztráng[/li]
[li][font=verdana]BlueMarlin[/li]
[li][font=verdana]Vitorláshal[/li]
[li][font=verdana]Makréla[/li]
[li][font=verdana]Tonhal[/li]
[li][font=verdana]Angolna[/li]
[li][font=verdana]Amúr[/li]
[li][font=verdana]Kardhal[/li]
[li][font=verdana]Süllõ[/li]
[li][font=verdana][color=lightblue]Doboz[/li][/li]
[font=verdana][size=10pt][color=lightgreen]Doboz leirás
[li][font=verdana]Amint fogsz egy dobozt, egybõl kinyitja neked a rendszer, és megkapod a jutalmát.[/li]
[li][font=verdana]Bármelyik horgászhelynél foghatsz dobozt! (és nem skilltõl függ)[/li]
[li][font=verdana]A dobozban lévõ "tárgyakat", százalék szerint adja.[/li]
[li][font=verdana]Kevés rá az esély hogy ilyet kapj, ezért értékes dolgokat rejt.

[font=verdana][size=10pt][color=lightgreen]3 tárgy található a ládában
[li][font=verdana]Pénztárca (50% esély) - Játszott óra alapján ad X mennyiségû pénzt. (ne gondoljatok százezrekre..)[/li]
[li][font=verdana]Horgászati könyv (48% esély) - Mivel nehezebb lesz felhúzni a horgászat skillt, ezért ez skillt fog adni. (random 1,25 között)[/li]
[li][font=verdana]Kis Aranyrög (2% esély) - Ha összegyûjtesz belõle 5db-ot akkor kapsz egy aranyrudat.[/li][/li]

[hr]
[font=verdana][size=12pt][color=white]======================================================
