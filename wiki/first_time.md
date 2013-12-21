Poprvé
======

Zde si lze přečíst hinty pro první minuty práce na projektu

Setup enginu a vývojového adresáře
----------------------------------

	1) stáhněte si notainsta z http://nota.machys.net/downloads
	2) rozbalte, spusťte, "nainstalujte" (je to jen downloader), spustí se vám notalobby
	3) v instalačním adresáři NOTA/SpringData/Games/ vytvořte adresář ote.sdd (tedy cesta ./SpringData/Games/ote.sdd) a do toho si exportujte obsah celé repository
	4) klikněte v lobby vlevo dole na tlačítko online -> Resync
	5) klikněte na "multiplayer" a přihlašte se (nebo zde se zaregistrujte, pokud nemáte account)
	6) dejte "host game" - tam vyberte libovolnou mapu, hru OTE r0001 a engine 94.1
	7) můžete dát proti sobě AI CppTestAI (nic nedělá)
	8) Start Game

Poprvé s gitem (pro Windows nooby)
----------------------------------

	1) stáhnut portable git na windows - http://portableapps.com/node/36346
	2) nainstalovat a spustit git s GUI
	3) kliknout na "clone existing repostiory..."
	4) jako zdroj vybrat link, který se dá okoporírovat v pravém sloupic na github při prohlížení dané repository
	5) jako target vybrat adresář uvnitř instalace NOTY ./SpringData/Games/ote.sdd (smazat ho, pokud je již vytvořen)
	6) clone
	7) teď už může člověk hrát (viz kuchařku výše), pokud jste měli zapnutou lobby, je třeba opakovat krok 4) předchozího návodu

Tipy&Tricky
-----------

* V adresáři ote.sdd měníte hru a při každém novém spuštění jsou změny aktualizovány.
* Pro většinu synchronizovaného obsahu hry (v podstatě vše, co není GUI a není drobnost v LuaRules) je nutno hru zapnout znova, aby se změny projevily.
* Pokud editujete pouze widgety (obsah adresáře hry LuaUI), lze ve hře reloadovat obsah a není nutný restart pomocí příkazu "/luaui reload" do konzole. Do konzole se píše zmáčknutím enteru a odesílá dalším enterem. Konzole zná historii (šipka nahoru).
* Pokud chcete mít uplnou kontrolu nad hrou při testovaní, napište do konzole "/cheat".
* Potom můžete například přidávat do hry jednotky pomocí příkazu "/give <počet jednotek> <jméno jednotky> <číslo týmu, začíná se od nuly>" - tedy například "/give 1 tank 1" dá jednu jednotku "tank" teamu 1. Lze vynechat počet jednotek, pokud chcete do hry dát jednu jednotku. Lze vynechat číslo týmu, pokud chcete přidat jednotku týmu, za který hrajete - tedy "/give tank" je ekvivalentní předchozímu příkladu, pokud hrajete za team 1
* Potom se můžete přepínat mezi týmy (což je ekvivalent jednoho hráče - tedy přepínat se mezi hráči) pomocí příkazu "/team <číslo týmu>".
* Aby bylo názvosloví jasné - každý hráč má vlastní "team", unikátní číslo, a hráči se sdružují do "alliance", což je skupina hráčů, které jsme zvyklí říkat tým ;). Upozorňují, že notalobby tuto pošáhlou logiku nerespektuje a jednotlivých stranám konfliktu bude říkat teamy ;).
* Jedinou věcí, dost nespolehlivou, ale občas užitečnou, je "/luarules reload", funguje podobně jako "/luaui reload", jen nahrává znovu jiný adresář. Použitelné na reload animačních scriptů a jednoduchých gadgetů, pro definice jednotek a další obsah nepoužitelné. Před použití je třeba aktivovat cheaty (/cheat), jelikož tímto měníce "pravidla hry" ;).

Ovládání
--------

![Klávesnice](http://springrts.com/mediawiki/images/a/a5/KeyboardLayout.jpg)
