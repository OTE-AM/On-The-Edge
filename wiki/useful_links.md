Ahoj kolegové,

zde je ten slíbený seznam užitečných odkazů. Existují různé takové seznamy a stránka enginu má také vlastní wiki. Spoustu informací tam obsažených ale nevyužijeme. Proto, abych vám ušetřil čas, vybral jsem jen ty nejpodstatnější, které buď budete velmi častou používat, nebo usnadní nahlédnutí do toho, jak naše hra bude fungovat.

Spring
======

* stránka enginu - http://springrts.com/
* různé verze enginu včetně dev-releasů - http://springrts.com/dl/buildbot/default/develop/
* jednotky a míry v enginu Spring - http://springrts.com/wiki/Units-UnitsOfMeasurement

Databáze hotových obsahů
========================

* databáze většiny obsahu, co kdy byl pro Spring vyroben (mapy, hry, tooly, instalátory,... ) - http://springfiles.com
* jiná databáze widgetů pro Spring - http://widgets.springrts.de/
* hry, které nerady ukazují svůj zdroják, nebo prostě jen nejsou na springfiles - http://packages.springrts.com/builds/

Práce na hře - často používané stránky
======================================

* Soubory hry (definice, odkazy na podmanuály pro jednotlivé části hry, templaty, atd) - http://springrts.com/wiki/Gamedev:Main
	* všichni budeme používat část Definition files a občas také GameData (armory, pohybové třídy), ostatní položky stránky použijí pouze tvůrci nových objektů do hry
		
		* definice jednotek - [v herních souborech](http://springrts.com/wiki/Units-UnitDefs) (a jejich [volání v enginu](http://springrts.com/wiki/Lua_UnitDefs))
		* definice zbraní - [v herních souborech](http://springrts.com/wiki/Gamedev:WeaponDefs) (a jejich [volání v enginu](http://springrts.com/wiki/Lua_WeaponDefs))
		* definice features - [v herních souborech](http://springrts.com/wiki/Gamedev:FeatureDefs) (a jejich [volání v enginu](http://springrts.com/wiki/Lua_FeatureDefs))
		* definice armorů (tříd) - [v herních souborech](http://springrts.com/wiki/Armordefs.lua)
		* definice pohybových tříd - [v herních souborech](http://springrts.com/wiki/Movedefs.lua)
		* a další, ale ty už budem používat o hodně méně

* Lua scripty (hlavní stránka o programování gadgetů/widgetů, volání enginových funkcí skrze api) - http://springrts.com/wiki/Lua_Scripting
    * obecně Lua tutorials - http://lua-users.org/wiki/TutorialDirectory
    * celkový manuál se slovníčkem a vysvětlením pojmů souvisejících s Lua ve Springu - http://warriorhut.org/spring/documentation/SpringLuaScripting.pdf
    * performance tips pro programování v Lua - http://springrts.com/wiki/Lua_Performance
    * jak už bylo řečeno, hra se dělí na synchronizovanou (LuaRules) a nesynchronizovanou (hlavně LuaUI) část - která je která - http://springrts.com/wiki/Category:Lua
    * teď si ukážem těch pět wiki manuálů, které popisují funkce enginu, které může hra využívat. Stačí si číst názvy funkcí a parametry a jistě vás napadnou stovky aplikací (tyto stránky budete používat často)
        
		* seznam příkazů synchronizované části - http://springrts.com/wiki/Lua_SyncedCtrl
        * seznam dotazů synchronizované části - http://springrts.com/wiki/Lua_SyncedRead
        * seznam příkazů nesynchronizované části - http://springrts.com/wiki/Lua_UnsyncedCtrl
        * seznam dotazů nesynchronizované části - http://springrts.com/wiki/Lua_UnsyncedRead
        * seznam eventů, na které může reagovat nějaký váš herní kód - http://springrts.com/wiki/LuaCallinReturn
		
    * existuje ještě mnoho dalších odkazů, které najdete na hlavní stránce Lua (http://springrts.com/wiki/Lua_Scripting), ale ty budete používat spíše výjimečně
* seznam "commandů" jedné herní jednotce (tyto bývají parametrem synced/unsynced příkazů Spring.GiveOrderToUnit) - http://springrts.com/wiki/Lua_CMDs (tyto jsou defaultní, lze si tvořit další, my například budeme muset nadefinovat command pro každou schopnost hrdiny)
* herní konstanty (http://springrts.com/wiki/Lua_ConstGame) a nastavení hlavních parametrů chování enginu (http://springrts.com/wiki/Modrules.lua)
* dále hra obsahuje animační Lua/COB scripty, textury, modely, kurzory, jiné bitmapy, loadscreeny či loadanimace, zvuky a další případné soubory, ale ty se zpravidla jen umístí do správného adresáře a pak už fungují. Odkazy na jejich výrobu sem dávat nebudu, jelikož by to vydalo na další plný seznam užitečných linků.

FAQ a další užitečné stránky
============================

* nejnovější template hry (základní soubory nové hry, release Oct 28 2013 - http://springrts.com/phpbb/viewtopic.php?f=14&t=31070
* seznam odkazů na všechny tematické evergreeny okolo springu - http://springrts.com/wiki/CollectionOfStuff

Debug
=====

* bughunt enginu - http://springrts.com/mantis/

NOTA
====
(a její ukázkové komponenty, některé z nich použijeme)

* stránka hry NOTA - http://nota.machys.net/downloads
* download instalátoru pro tři OS - http://nota.machys.net/downloads
* google project site hry NOTA (repository, downloady, wiki) - http://code.google.com/p/nota/
* rozpracovaná wiki toolů NOE (AI + mission making) - http://code.google.com/p/nota/wiki/NOE_introduction
* forum NOTY na springrts.com - http://springrts.com/phpbb/viewforum.php?f=55
* NOTA TV - vytváření záznamů her pro pozdější shlédnutí (forum, tech. info) - http://springrts.com/phpbb/viewtopic.php?f=55&t=28808

Rychlé zkoušení
===============

Pokud chcete místo čtení rovnou vyzkoušet nějakou hru, instalujte odsud (http://nota.machys.net/downloads) - dostanete hru NOTA + lobby, po dvousekundové registraci v multiplayerové části si lze zobrazim kompletní seznam všech hostovaných her na různých mapách. Po připojení do libovolné místnosti se vám přes rapid stáhnou další hry a mapy automaticky.

V tomto dokumentu používáme [MD sytax](https://help.github.com/articles/github-flavored-markdown) / [alternativní link](https://confluence.atlassian.com/display/STASH/Markdown+syntax+guide)