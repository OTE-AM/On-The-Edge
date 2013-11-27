On The Edge (OTE) 
=================
(verze pro potřeby předmětu SWI115)

* Počet hráčů: 2-10 (sudý počet)
* Singleplayer: ne
* Platformy: Windows, Linux, MacOS
* Engine: Spring ([web](http://springrts.com/))

Žánrové vymezení
----------------

Hra kombinuje prvky několika žánrů a subžánrů. Níže uvedené a pro účely vymezení/uchopení hry zdůrazněné charakteristiky (rozřazené pro přehlednost do kategorií) jsou hlavním východiskem nebo také důsledkem zamýšlených herních mechanik.

* Real-time strategy (RTS)
	* ve hře se pohybují desítky až stovky jednotek, multiagentní interakce na velké mapě s různými zdroji
	* hráč ovládá hru (hrdinu) z pohledu třetí osoby
	* hráč má možnost ovlivnit chování velkého množství jednotek
* Akce
	* ačkoliv jsou ve hře spousty jednotek, hráč přímo ovládá pouze svého hrdinu
	* hlavním prvkem, který určuje úspěch soupeření ve hře, je destrukce (ničení aktérů/agentů/jednotek/objektů, nepřátelských nebo neutrálních)
	* nepřátelské jednotky (s výjimkou nepřátelských hrdinů) jsou slabší než hrdina hráče - očekává se, že nepřátel zemře mnoho
* Role-play game (RPG)
	* hráč přímo ovládá pouze svého hrdinu
	* hrdina může mít specifickou roli ve hře 
		* závisející na schopnostech hrdiny, které si zvolí
		* nebo na stylu, jakým hru hraje
	* různí hráči mohou mít různé role (umožňující kooperaci či soupeření v různých rovinách)
	* hrdina získává nové schopnosti a vylepšuje stávající
* DOTA
	* hráči hrají za abnormálně silné bojové jednotky dvou válčících frakcí
	* obyčejné bojové jednotky nejsou pod kontrolou hráčů a bojují předem očekávaným automatický způsobem
	* na mapě jsou strategicky významná místa a vzácné zdroje
	* hráči jsou motivováni ke kombinování vhodných taktických vlastností hrdinů a ke kooperaci
	* hra končí zničením hlavní nepřátelské budovy, ničení dalších budov lze považovat za dílčí úspěchy a zabíjení nepřátelských hrdinů je jedním z hlavních prostředků jak těchto úspěchů dosáhnout

Stylové vymezení
----------------

* budoucnost
* sci-fi
* pokročilé technologie, roboti
* mimozemské entity
* brouci!

Jak bude vypadat hraní hry
--------------------------

Krátký popis: "Hráč si navolí hrdinu a vrhne se s ním do boje proti 'těm druhým', třeba broukům nenažraným mimozemským. Konám svou povinnost! ... tedy většinou několikrát zemřu v boji za světový mír, který se rovná totálnímu vyhlazení protivníka"
Dlouhá anotace:

* Setup hry
	* Hráč se připojí do multiplayerové herní místnosti a zde čeká na další hráče
	* Během čekání může nastavit vybavení a schopnosti svého hrdiny přes lobby interface
	* Ve chvíli, kdy je v místnosti připraveno 2-4-6-8-10 hráčů, může se hra spustit. 

* Začátek hry
	* Hráč se objeví v základně svého týmu v rohu mapy. V opačném rohu mapy je nepřítel.
	* V každé základně se začnou vyrábět první bojové jednotky a ty se pak automaticky ve skupinkách vydají do boje
	* Na mapě jsou umístěné strategicky významná místa, tzv. Strongpointy, některá jsou již zabraná týmy, jiná jsou ještě neobsazená
	* Mezi zabranými Strongpointy náhodně putují nebojové "obchodní" jednotky, tzv. "chodci", z jejichž činnost přináší ekonomickou výhodu svému týmu
	* Na mapě jsou také umístěna stanoviště neutrálních/všem nepřátelských jednotek, které, pokud jsou vyprovokovány, se brání/útočí

* Preferované herní chování
	* Od hráče se očekává, že pomáhá svým bojovým jednotkám v boji proti nepřátelských NEBO
	* vyrazí lovit nepřátelské chodce, aby omezil přísun zdrojů nepřátelské armádě (čímž se oslabí její schopnost produkovat nové jednotky) NEBO
	* bude primárně lovit nepřátelské hrdiny, což je nepřímější způsob oslabení nepřátel a zároveň posílení vlastních sil
	* hráč si může vybrat, zda bude investovat do individuálních upgradů svého hrdiny nebo do globálních upgradů armády

* Herní události pozdní hry
	* Strongpointy, které jsou dlouho v držení se samy upgradují (získávají obranu a později také schopnost produkovat malé množství jednotek). Jednotky hrdinů ale v čase posilují rychleji, takže vždy budou silnější než tyto obranné featury.
	* Hrdinové jsou schopni zabíjet nepřátelské bojovníky po desítkách, armády obou stran jsou produkovány větším tempem
	* Systém je v důsledku upgradů stále nestabilnější a nakonec dojde k poražení jedné strany (kumulace zdrojů a upgradů v pozdních fázích hry činí údery devastující)

* Schopnosti a zbraně hrdinů
	* Hrdinové mohou použit tyto zbraně - rakety, lasery, miny, kanony, plamenomety, emp, gravitační zbraně, ... může dojít i na titanové klacky či zuby :)
	* Schopnosti - skákání, teleportace, různé druhy senzorů a rušiček senzorů, protiopatření a štíty pro různé zbraně, povolání cizích sil (pád meteoritu, spawn menší armády,...), samoopravování, rychlost, ekonomické bonusy,... a mnoho dalších
	
* *Variabilita schopností a zbraní je sice široká, implementovány budou vzhledem k omezenému času jen některé vybrané možnosti*
	
Detailní herní mechanismy
-------------------------

Jsou popsány v [podrobné verzi design dokumentu](design_detail.md), která **není součástí** povinně odevzdávané specifikace.

Technická specifikace
---------------------

Tým vývojařů zde určí, které části díla bude vyrábět a které jsou z jiných zdrojů.

* Simulace 3D prostředí s mnoha aktéry
	* engine Spring - jeden z posledních stabilních releasů (pravděpodobně verzi 94.1, 95.0, případně novější, pokud bude vydán, spíše ne 91.0 a starší)
	* engine je kompletně zajišťován třetí stranou
	
* Herní mechaniky 
	* tým sám kompletně zajistí fungování všech herních mechanismů (pravidel hry) skrze Lua Gadgety
	* mezi herní mechaniky se počítá tvorba jednoduché AI zajišťující chování nehráčských herních jednotek nad rámec jednoduchých příkazů (move, attack, patrol,...) zajišťovaných enginem
	* tým také zajistí enginové definice všech herních objektů - jednotek, zbraní&projektilů, features, tříd armorů a pohybových tříd (užitých při pathfindingu)
	
* Modely, textury modelů, animace modelů
	* tým buď sám kompletní jednotky vyrobí nebo
	* použije volně šiřitelné modely/textury/animace nebo
	* si zaplatí tvorbu těchto prvků u třetí strany/koupí práva na jejich užití
	
* Efekty
	* tým vytvoří několik velmi jednoduchých efektů k herním schopnostem nebo
	* si zaplatí tvorbu těchto prvků u třetí strany/koupí práva na jejich užití
	
* Loadscreens
	* tým vyrobí alespoň vlastní loadovací statické obrázky (pokud nedodá animovanou loadovací sekvenci, která je podmíněna tím, že je podporována až posledním verzemi enginu)
	
* GUI in-game (HUD hrdiny, herní statistiky, ovládací prvky) 
	* využívající základní framework enginu +
	* využívající jeden z volně šiřitelných nadstavbových Lua frameworků (Chili, LolUI, NOTAUI, RedUI,...), které jsou vyrobeny třetí stranou +
	* tým využije, případně modifikuje a rozšíří jeden z těchto frameworků pro potřeby své hry +
	* tým vyrobí (či použije další volně šiřitelné) Lua widgety pro rozsahem menší prvky UI
	* do práce týmu se počítá zajištění vlastních textur, definování funkcionality nových prvků interface, optimalizace pro dané úlohy
	
* GUI game-setup 
	* tým navrhne a vyrobí jednoduché grafické rozhraní (HTML5) pro multiplayerového klienta, přes které si hráč nastavuje výchozí setup hrdiny
	* očekává se kompatibilita HTML5 s klientem, pokud by se nedařila, pak tým zvolí v rámci možností jiné řešení
	* součástí setupu je generování určité části startovacího skriptu enginu (jedná se o stanovení parametrů, s jakými je engine spuštěn)
		* tým má za úkol, aby vygenerovaná část byla validní, aby parametry po spuštění hry správně ve hře dekódoval a inicializace proběhla v pořádku)
	* zbytek setupu hry mají na starost funkční prvky multiplayerového klienta, které jsou jeho standardní výbavou
	
* multiplayerový klient
	* pro potřeby multiplayerové hry bude užit klient NOTA lobby, zajišťován třetí stranou
	* klient má připravené komunikační rozhraní pro přidání modulu s game-setupem

* server, hostování hry
	* probíhá v režii třetích stran a skrze multiplayerového klienta
	
* instalátor
	* buď bude užit downloader/instalátor portované verze hry NOTA insta v nezměněné podobě tak, jako poskytuje třetí strana (jen se změní URL stahovaných součástí hry) nebo
	* tým jednoduše vyrobí portovatelnou verzi hry včetně enginu a lobby klienta pro Windows
	
* kompatibilita a nestabilita enginu
	* vývojaři zajistí funkčnost herní demonstračního portovaného balíčku s hrou na Windows XP až Windows 7 a Linuxové distribuci založené na Ubuntu
	* podmínkou úspěšného spuštění hry je cílový stroj (PC/notebook) vybavený vlastní neintegrovanou (low-endovou) grafickou kartou a posledními ovladači
	* od verze 91.0 je engine nestabilní na MacOS, tým tedy nezaručuje demonstrační způsobilost na Macu
	
* web hry
	* jednoduchá stránka s informacemi o hře (pokud bude rozšířena, tak až po skončení projektu)

Rozdělení rolí v týmu
---------------------

**Josef Pelant**
* (A) výroba a zajištění hudby a zvuků
* (G) grafická část výroby GUI
* (G, OPENGL, OK) grafická část zajištění efektů schopností a zbraní&projektilů
* (G) loadscreeny
	
**Michal Wirth**

* (G, HTML5) návrh a výroba interface předherního setupu hrdiny
* (?) generování startovní části skriptu hry a kooperace s Jakubem Markem při testování přenosu setupu do hry
* (G) grafický návrh a výroba webu
	
**Pavel Pilař**

* (Lua) implementace "malých" herních mechanik - definice a balancování schopností hrdinů a herních zbraní - TSP modul (funkční část schopností hrdiny)
* (Lua) implementace upgradování hrdiny
* (M, G, Ani) nezbytně nutná práce na modelech/texturách/animacích

**Jakub Marek**

* (Lua) technické pozadí GUI (framework a dodatečné nástroje, optimalizace)
* (Lua) implementace globálních herních mechanik (ekonomický model, spawntimy, globální upgrady)
* (Lua) zodpovědný za správnou incializaci hry (na herní straně) ze startovního skriptu
	
**Petr Mácha**

* (OK) organizace práce (komunikace uvnitř týmu)
* (OK) komunikace s vedením předmětu, komunikace s výrobci obsahu zajišťovaného třetími stranami, zajištění testerů, komunitní PR
* (?) poradní činnost - intro do nástrojů a fungování hry, kontrola, debug
* (D, Lua) návrh a základní implementace AI a TSP modulu

**Všichni**

* (D) participovali a budou participovat při stanovování hlavních herních mechanik

*Legenda k značkám*

(popisujícím typ práce)
**(A)** - výroba akustickýh efektů
**(G)** - obecně grafická práce (Photoshop, ...)
**(OPENGL)** - užití OPENGL particle efektů
**(OK)** - organizační a komunikační práce
**(HTML5)** - užití HTML5
**(Lua)** - programování v Lua
**(M)** - modelování
**(Ani)** - animování
**(D)** - práce na design návrhu
**(?)** - jiný druh či kombinace předešlých

Demonstrace hry
---------------

Na demonstraci hry předvedeme jednu zrovna probíhající hru a další funkcionalitu budeme ukazovat na záznamech odehraných her.

Podmínky hladkého průběhu (vize podkapitolu výše "kompatibilita a nestabilita enginu") (!doplnit odkaz)