* zde bude design document pro účely týmu

zatím jen kopie části z posledního reportu (přepíšu a rozepíšu ve Středu večer - pozn. Machys)

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
------

* Machys mluvil o možnostech schopností hrdinů (zbraní a techů) a jejich implementace - různé zbraně, různé druhy senzorů (radar, sonar, seismic, visual), pasivní area effekty, spawny jednotek a eventů (pád meteoru), terraforming
