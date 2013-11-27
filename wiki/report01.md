Report - páteční setkání (1)
============================

* 22. 11. 2013 (12:30 - 15:15)
* přítomni Machys, Michal, Pepa, Jakub
* s Pavlem jsme témata probrali od 10:50 - 11:40

Úvodní anketa
=============

Před samotnou schůzkou dostal každý za úkol zamyslet se, kolik času hodlá věnovat projektu. Všichni napsali počet hodin, které budou moci investovat do vývoje. Základní setup byl odvozen z anotace předmětu, že se očekává od každého člena týmu týden práce. Počítali jsme tedy 40 hodin jako průměrný očekávaný vklad a Machys nastavil mantinely na přibližně 20-100 hodin. Motivace byly následující:

* každý člen by měl mít představu, jak se jeho kolegové hodlají zapojit do společného díla, aby se práce mohla lépe plánovat a aby se předešlo případnému rozčarování z mylných očekávání

* měl navést každého člena týmu, aby se vážně zamyslel nad svým časem v následujících necelých dvou měsících

* od slíbeného množství čase se bude (částečně) odvíjet možnost člena zasahovat do návrhu hry (samozřejmě to je spíše takové pocitové kritérium, ne nic vymahatelného)

**Výsledky:**

	Pavel - 80
	Machys - 100+
	Michal - max 40
	Jakub - 60+
	Pepa - 40+

Přičemž plus jsem připsal kolegům, kteří okomentovali svůj příspěvek tím, že toto přibližně mohou slíbit a je možné, že pokud je to bude bavit a bude čas, že přispějí větší časovou dotací.

Machysův komentář: Navrhuji zaujmout mírný optimismus, pracovat asi všichni chceme. Co se týče času, měli bychom být schopni vyrobit dobrou hru.

Hlasování budeme opakovat ještě po odevzdání design documentu, aby jste všichni měli možnost zareagovat na nějaké aspekty projektu, které se vám budou líbit nebo naopak nelíbit.

Specifikace hry
===============

Hlavní body
-----------

* zůstávají základní kameny: RTS, RPG, akce, roboti, brouci
* hra se bude blížit žánru DOTA (s tím souhlasí všichni)

mimo DOTU zazněly ještě alternativní nápady, které budou častečně užity v některých herních mechanikách

* Pavel: navrhoval soupeření ve stylu Warcraft 3 mapy "CustomHeroLineWars" (ve zkratce, lajny nestvůr jsou úplně oddělené, každý jen brání a na základě efektivy bránění se posiluje armáda v útočném koridoru, pro podrobnosti googlete)
* Machys: zmínil možnost coop mise, bránění ve stylu Tower Defense proti broukům

(oba variantní návrhy nevyužity vzhledem k tomu, že jsme se shodli na DOTA-like hře)

* zůstává záměr, že hráč by měl mít přímo pod kontrolou pouze hrdinu, vlastní armádu by měl ovlivňovat nepřímo pomocí upgradů a nákupů, o pohyb vlastních jednotek se stará AI

Modifkace a návrhy odlišných mechanik vzhledem k DOTĚ 
-----------------------------------------------------
(pokud není řečeno jinak, je odsouhlaseno)

* Machys: návrh, aby místo věží byly strongpointy, které se zabírají přítomností hrdiny a pak časem levelují (věž => silnější věž/více věží => malý spawn dalších jednotek armády), Pavel je pro zachování věží v nějaké podobě, alespoň jako upgradů

* Jakub, Pepa: pokud to bude brouci proti robotům, pak by rozhodně měly být jednotky armád obou stran ekvivalentní, jinak to půjde těžko vybalancovat

* Machys: možnost udělat z brouků neutral creepy v džungli - bude tam bug hole a různě silní brouci okolo
* Machys, Pavel: hrdinové buď investují do svých bojových schopností, nebo do army upgradů, nebo mohou kupovat bonusové jednotky do armád (= spawn navíc)
	* druhá a třetí možnost "útraty" zdrojů by měl podporovat styl hraní zaměřený na silnou automatickou armádu, hrdina by i tak při levlení měl získat HP, speed, etc., aby byl v boji platný, ale místo silnější schopnosti nastálo bude mít armáda silnější jednotky
* Machys: sekundární ekonomický model chodců/obchodníků mezi obsazenými strongpointy
	* max. počet "chodců" závisí na počtu obsazených strongpointů (a jejich levelů), pomalu se spawnují noví chodci do dozažení max. počtu
	* chodci jsou ovládáni AI a náhodně si volí cíl další trasy
	* za každou úspěšně absolovovanou cestu obdrží daná strana nějaké suroviny (což podpoří výrobu armády)
	* tyto cesty samozřejmě budou cílem nepřátel - alternativa k junglení
* hrdina bude mít energii, kterou bude používat na užívání/"sesílání" schopností
	* alternativní návrh užívat tuto energii i na střelbu (zatím nerozhodnuto)
	* alternativní možnost použít energii i fuel, bude potřeba podle druhu schopnosti (energie se dobíjí sama, fuel pouze na strongpointech) (zatím nerozhodnuto)
* druhý zdroj (METAL), ekvivalent zlata DOTY, na upgrady, nákup jednotek
* bavili jsme se o zkušenostech - varianty (zatím nerozhodnuto):
	* k získání levelu stačí jen dostatek metalu (zkušenosti nebudou)
	* k získání levelu bude třeba jak metal, tak zkušenosti
	* k získání levelu stačí pouze zkušenosti
* mapa by měla být spíše podobná původní, ale možná se bude zdát větší (měřítko velké RTS)

Sporná část
-----------

* Jakub a Pepa říkají, že Machysův návrh s počátečním setupem před hrou (a pak hra bez předmětů) je moc determinující a bere hráčům možnost reagovat na vývoj hry
* Machys odpovídá, že nepřítomnost předmětů bude kompenzována větším množstvím upgradů, které si hrdina na základě setupu ponese (navrhuje buď více slotů, nebo povinné a volitelné schopnosti) a dále výše zmíněnými novinkami ("obchodní stezky", globální technologie/upgrady, strongpointy, nákup posil)
* ještě se toto bude řešit, podstatné jsou tyto argumenty:
	* hráč by měl mít možnost reagovat na vývoj hry a mít možnost "napravit" špatnou volbu počátečního setupu
	* klasické předměty a inventář je náročnější na implementaci (inklinujeme tedy spíše k "technologickým upgradům")

Pozn. Machys: na poradě jsem zapomněl zmínit princip TSP (Temporary strategic power), který plánujem do NOTY a odpovídal by jednomu řešení, které nás během diskuze napadlo (hráč by si pak místo předmětů a vybavení v lobby zvolil pouze "deck" kartiček s různými schopnostmi).

Obecně

* Machys mluvil o možnostech schopností hrdinů (zbraní a techů) a jejich implementace - různé zbraně, různé druhy senzorů (radar, sonar, seismic, visual), pasivní area effekty, spawny jednotek a eventů (pád meteoru), terraforming

Schopnosti členů týmu a rozdělení práce
=======================================

**Pepa**

* schopný postarat se zvuky a hudbu
* také schopný a pokud nutné ochotný nějaké základní grafické práce (textury jednotek či GUI)
* mohl by se podílet na tvorbě efektů zbraní
	
**Michal**

* bude mít na starost web
* udělá v HTML5 interface předherního setupu hrdiny a vygeneruje Script, který předá lobby a Jakubovi
	
**Pavel**

* byl by ochotný udělat grafickou část GUI
* možná participace na zbraních
* vyjádřil přání pokud možno účastnit se implementace herních mechanik (lze mu například přenechat balancování zbraní)
* řekl, že pokud by to bylo nezbytně nutné, odvedl by nějakou práci na modelech a animacích
	
**Jakub**

* bude mít na starosti technické pozadí GUI (otestovat GUI framework chili, zda vyhovuje našim potřebám a případně prohlédnout i jiné)
* bude implementovat hlavní herní mechaniky
* bude zodpovědný za přenos předherního setupu hrdiny do hry z lobby
	
**Machys**

* bude organizovat a otravovat s e-maily, komunikovat s garanty
* s Jakubem a Pavlem vyřeší generování systému definičních souborů pro jednotky hrdinů (pro různé kombinace schopností a levelů)
* bude radit a dělat nutnou práci s ostatním členy týmu
* uspořádá nějaké intro-schůzky pro členy týmu (ukázka nástrojů, úvod do skriptování,...)

**Všichni**

* participovali a budou participovat při stanovování hlavních herních mechanik
   
Kontakty
========

* každý Machysovi sdělil nějaký rychlý kontakt na sebe a čas, kdy se mu může volat

Repository
==========

* Jakub slíbil, že zřídí repository na GitHubu (splněno)
* a až mu ostatní pošlou své registrační nicky, tak je do projektu přidá (splněno)

Práce na specifikaci, design dokumentu
======================================

* Machys slíbil, že napíše draft design documentu a nasdílí ho na repository (zatím nesplněno, úvodní nástřel v mailu zde, plné znění pondělí či úterý)

Grant
=====

* Proběhla diskuze o tom, že bychom mohli a měli zažádat o grant. Všichni byli pro, abychom zkusili zažádat o peníze na tyto věci.
	* zvuky
	* modely/textury/animace - nebo zaplatit člověka, který je vyrobí
* Machys dostal za úkol napsat žádost o grant (nesplněno, vysvětleno v předchozích mailech, Machys sehnal peníze, více peněz, z jiných zdrojů)
* Jakub říkal, že zná nějaké levné pracovní síly a sežene na ně kontakty (zatím nesplněno)
* Pepa říkal, že by mohl zjistit ceny zvuků a stanovit, kolik by bylo potřeba pěnez (zatím nesplněno)

První pracovní víkend
=====================

* bylo dohodnuto, že Machys pošle další doodlí hlasování o prvním víkendu, kdy bychom v kuse déle pracovali na hře (splněno)
* zde hlasování http://doodle.com/bhr66rx6aagnpgsz

Užitečné odkazy
===============

* Machys slíbil, že pošle užitečné odkazy pro pochopení principů tvorby hry a užitečné wiki stránky pro usnadnění práce (splněno)

Demonstrace hry
===============

* Machys pouštěl ukázky lobby a nějakých herních jednotek v akci (odehrálo se v závěru, jen krátce)


Sepsal Machys
	
V tomto dokumentu používáme [MD sytax](https://help.github.com/articles/github-flavored-markdown) / [alternativní link](https://confluence.atlassian.com/display/STASH/Markdown+syntax+guide)
