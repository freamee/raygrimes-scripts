[font=verdana]Cs�cs�, k�sz lettem a /fish �jrair�s�val, tudod amir�l besz�lt�nk.
Pr�b�lgattuk t�bben is a munk�t, nem tal�ltunk bugot, ha valami probl�ma lenne akkor javits�tok vagy irjatok. :/
Ha beker�l akkor k�ld�m a p�nzt. (kinek a bsz�re? azt majd ird le)

Esetleg ha valamit t�lz�snak tartotok akkor vegy�tek ki bel�le, �s �r�ln�k neki hogyha sz�ln�tok is, mert tudni szeretn�k r�la, hogy mi az amivel t�ll�ttem a "c�lon".

# definek, v�ltoz�k, timerek l�trehoz�sa (m�d elej�re) http://pastebin.com/L4t4Etw5
# enum, (dini ment�shez) | fontos hogy ne crasheljen a m�d: scriptfiles mapp�ba hozz l�tre egy Halak mapp�t!!! (C:\Users\Kriszti�n\Desktop\pawno\scriptfiles\Halak)
http://pastebin.com/xdNM3xe0

# onplayerconnect (bet�lt�s) http://pastebin.com/L4Y0rcPb
# onplayerdisconnect (ment�s) http://pastebin.com/Qj7Z30cZ
# a scriptet nem zcmdben irtam, ha j�l tudom class m�dban old_commands.pwn alatt vannak az strcmp parancsok, tedd a /fish hely�re az eg�szet szerintem. http://pastebin.com/7UzEEGN0
# a timerek http://pastebin.com/GFyyqEGA

Sz�lj hogyha kihagytam valamit, vagy nem siker�lne, vagy valami lenne.
��, bocs hogy lesz egy kis munk�d, de val�szin� hogy a r�gi horg�szbot/csalikat kik�ne venni a m�db�l, mivel �jra irtam ebben, diniben, �s a santa mari�n lehet venni "Horg�szbolt"n�l.
(PlayerInfo[playerid][pCsali], PlayerInfo[playerid][pHorgaszbot] -- ezeket k�ne kigyilkolnod, vagy �tirni a saj�t scriptemre ezeket. :/) 

Ha �gy d�nt�t�k hogy m�gsem ker�lne be akkor kaphatn�k egy �rtesit�st?

Na k�szk�sz, pacsi!

[hr]
[hr]
[hr]
[size=24pt]LEIR�S A SCRIPT�L HA BEKER�LNE?![/size]

[font=verdana][size=12pt][color=white]============ [[color=yellow]Horg�szat[color=white]] ============
[li][font=verdana]/fish parancs helyett --> /horg�szat [bedob, ber�nt, helyek, elad, vesz, halaim, toplista, �rak, info][/li]
[li][font=verdana]Csalit / horg�szbotot �jra meg kell venni. (Santa mari�n lehet, /horg�szat vesz)[/li]
[li][font=verdana]A munk�t tov�bbra sem kell felvenni a v�rosh�z�n.[/li]
[li][font=verdana]Meg�jult horg�szhelyek (tengeren, tavakn�l), azok k�zel�ben lehet m�r csak horg�szni. Jelenleg 6db horg�szhely van.
[li][font=verdana]Skillekhez vannak kiosztva a horg�szhelyek. Ha nincs meg az elegend� skilled, akkor nem tudsz ott horg�szni.[/li]
[li][font=verdana]Horg�szhelyt�l f�gg�en m�s halat fogsz. (�rt�kesebb/�rt�ktelenebb)[/li][/li]
[li][font=verdana]Adminok tudj�k ingame �llitani a "kap�sid�t", vagyis a pecabot bedob�s�t�l sz�mitott timert.[/li]
[li][font=verdana]Adminoknak logol minden timert, teh�t h�ny m�sodperc van kap�sig, stb.[/li]
[li][font=verdana]Tov�bbra is maximum 5db hal lehet n�lunk.[/li]
[li][font=verdana]Amint bedobtuk a horg�szbotot, nem tudjuk kih�zni, teh�t freezelve vagyunk amig v�get nem �r a timer.[/li]
[li][font=verdana]Ha kap�sunk van �s nem reag�lunk id�ben, akkor leakad a horogr�l a hal.[/li]
[li][font=verdana]A halakat tov�bbra is visszalehet dobni, /horg�szat visszadob paranccsal.[/li]
[li][font=verdana]Shortolni ne pr�b�lj�tok a munk�t. IG �rtesit a rendszer hogyha sokszor beirjuk a /horg�szat ber�nt parancsot.[/li]
[li][font=verdana]A munka legt�bb eleme skillhez van k�tve, minden �sszef�gg a skill mennyis�ggel.[/li]
[font=verdana][size=9pt][color=lightgreen]Skillt�l f�gg (folyamatosan cs�kken/n�)
[li][font=verdana]H�ny kil�s halat fogsz.[/li]
[li][font=verdana]H�ny m�sodperc alatt tekered fel az �rs�t. (amint ber�ntott�l) [8-1 m�sodperc][/li]
[li][font=verdana]H�ny m�sodperced van reag�lni a kap�sra. [8-3 m�sodperc][/li]
[li][font=verdana]Horg�szhelyek haszn�lata[/li]
[font=verdana][size=9pt][color=lightgreen]Toplista rendszer
[li][font=verdana]Top 3 embert jeleniti meg.[/li]
[li][font=verdana]Beker�lt egy toplista rendszer is. Ami a kifogott halak alapj�n �llit fel egy list�t. Az�rt ker�lt be ez a parancs, mivel szerintem sokan szeretnek versenyezni, �s ezzel meghozva egy kicsit a kedv�ket a munk�hoz. "versenyszellem" | Parancs: /horg�szat toplista[/li]
[li][font=verdana]Toplista, csak az online playereket jeleniti meg. Teh�t ha online player akkor irja csak top1-n�l, ha lel�p akkor m�s lesz a top1. [/li]
[font=verdana][size=10pt][color=lightgreen]Halakr�l b�vebb leir�s
[li][font=verdana]Nem fogjuk leirni hogy melyiket, melyik horg�szhelyen lehet fogni, ezeket tapasztalj�tok ki ti magatok![/li]
[li][font=verdana]Minden halra k�l�n sz�zal�k van irva, ett�l f�gg hogy melyiket fogod ki. Egy adott horg�szhelyen �ltal�ban t�bb f�le halat lehet fogni, �s sz�zal�k alapj�n d�nti el hogy melyiket kapod.[/li]
[li][font=verdana]Halak �r�t ingame megtekinthetitek. /horg�szat �rak
[hr]
[font=verdana][size=10pt][color=lightgreen]�j halak
[li][font=verdana]S�g�r[/li]
[li][font=verdana]Csattog�hal[/li]
[li][font=verdana]Pisztr�ng[/li]
[li][font=verdana]BlueMarlin[/li]
[li][font=verdana]Vitorl�shal[/li]
[li][font=verdana]Makr�la[/li]
[li][font=verdana]Tonhal[/li]
[li][font=verdana]Angolna[/li]
[li][font=verdana]Am�r[/li]
[li][font=verdana]Kardhal[/li]
[li][font=verdana]S�ll�[/li]
[li][font=verdana][color=lightblue]Doboz[/li][/li]
[font=verdana][size=10pt][color=lightgreen]Doboz leir�s
[li][font=verdana]Amint fogsz egy dobozt, egyb�l kinyitja neked a rendszer, �s megkapod a jutalm�t.[/li]
[li][font=verdana]B�rmelyik horg�szhelyn�l foghatsz dobozt! (�s nem skillt�l f�gg)[/li]
[li][font=verdana]A dobozban l�v� "t�rgyakat", sz�zal�k szerint adja.[/li]
[li][font=verdana]Kev�s r� az es�ly hogy ilyet kapj, ez�rt �rt�kes dolgokat rejt.

[font=verdana][size=10pt][color=lightgreen]3 t�rgy tal�lhat� a l�d�ban
[li][font=verdana]P�nzt�rca (50% es�ly) - J�tszott �ra alapj�n ad X mennyis�g� p�nzt. (ne gondoljatok sz�zezrekre..)[/li]
[li][font=verdana]Horg�szati k�nyv (48% es�ly) - Mivel nehezebb lesz felh�zni a horg�szat skillt, ez�rt ez skillt fog adni. (random 1,25 k�z�tt)[/li]
[li][font=verdana]Kis Aranyr�g (2% es�ly) - Ha �sszegy�jtesz bel�le 5db-ot akkor kapsz egy aranyrudat.[/li][/li]

[hr]
[font=verdana][size=12pt][color=white]======================================================
