Detailed design document for OTE
================================
(design document pro účely týmu)

* *nový obsah bude v angličtině - jednak kvůli tomu, že některé herní pojmy a jejich popisy musí být srozumitelné anglicky mluvícím hráčům, jednak kvůli případnému následnému vývoji po prezentaci, aby se nemusel obsah design docu přepisovat*

Content
-------
- [Dictionary](#dictionary)
- [Hero powers](#hero-powers)
- [Hero classes](#hero-classes)
- [Army (examples)](#army-example)

Dictionary
----------
* Hero = players unit
* Soldier class = basic battle unit controled by AI (lines runners)
* Ranger class = 2nd basic battle unit
* Giant class = 3rd battle unit, advanced one
* Metal = money, main source
* Energy = fuel, secondary source

Hero classes
------------

| Name		| Speed	| Gun 	| Reload | Range | HP 	| Heal 	| Armor | SpawnTime 	| E-storage 	|
| ------------- | -----	| ----- | ------ | ----- | ---- | ----- | ----- | ------------- | ------------- |
| Milie      	| 4	| 4 	| 3 	 | 1 	 | 4	| 3 	| 3 	| 3 		| 3 		|
| Renge      	| 2	| 3 	| 1	 | 4 	 | 1	| 1 	| 1 	| 3 		| 2 		|
| Trapper      	| 3	| 2 	| 4	 | 2 	 | 2	| 2 	| 2 	| 3 		| 2 		|
| Guv      	| 3	| 3 	| 3	 | 3 	 | 3	| 2 	| 3 	| 2 		| 2 		|
| Bulk      	| 2	| 4 	| 3 	 | 1 	 | 5	| 3 	| 4 	| 4		| 3 		|

Legend: for specification of values of units we will use "classes" instead of exact numbers, which helps us to keep relative knowledge of powers still, but enable us to parametrize whole game fast and swift ;)

-----
* 1 - very low
* 2 - lower then average
* 3 - average
* 4 - higher then average
* 5 - very high
* 6+ - more then high when unit level up (for later us)

Army (example)
--------------
(spacebugs column is just names alternative for units with similar role)

| Class         | Robots		| (Spacebugs) 	| HP	| Range	| DMG	| Rld 	| Speed |
| ------------- |-----------------------| -------------	| -----	| -----	| -----	| -----	| -----	|
| Soldier      	| Shotgun marine	| Alpha montro 	| 200	| 80	| 12	| 1	| 1	|
| Ranger      	| Rifleman 		| Gamma montro	| 150	| 400	| 25	| 2	| 1	|
| Giant 	| Grievous		| Dust bug	| 1000	| 200	| 50	| 2.5	| 0.7	|
| Tower 1	| Camp			| Hole		| 1000	| 500	| 110	| 2.8	| 0	|
| Tower 2	| Fort			| Big hole	| 2000	| 500	| 120	| 2.8	| 0	|
| Tower 3	| Base			| Hive		| 4000	| 600	| 140	| 2.8	| 0	|
| Spawner	| Factory		| Colony	| 6000	| 0	| 0	| 0	| 0	|
| Walker	| Trader		| Worker	| 200	| 0	| 0	| 0	| 1	|


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
------

* Machys mluvil o možnostech schopností hrdinů (zbraní a techů) a jejich implementace - různé zbraně, různé druhy senzorů (radar, sonar, seismic, visual), pasivní area effekty, spawny jednotek a eventů (pád meteoru), terraforming
 

Levels and experience (rules)
-----------------------------

* if there is more heroes in range of "expereince source action", then experience is divided between heroes
* "expereince source action" =
	* damaging enemy creep/army member
	* killing enemy hero
	* killing tower
	* capturing strategic spot
