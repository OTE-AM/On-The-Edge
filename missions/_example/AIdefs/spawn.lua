----- mission spawn list ------
----- more about: http://springrts.com/phpbb/viewtopic.php?f=55&t=28259

-- !! not finished --
-- ! not own spawner
-- ! need add resources start setting

newSpawnDef = {

}

newSpawnThis = {

}

local counter 	= 0
local limit		= 30
local line		= 1
local squareDist= 250

for id,unitDef in pairs(UnitDefs) do
	counter 				= counter + 1
	local row				= counter % limit
	if (row == 0) then line = line + 1 end
	
	local uName 			= unitDef.name
	local tName				= "t_" .. uName
	newSpawnDef[tName] 		= {unit = uName, class = "single"}
	newSpawnThis[counter] 	= {name = tName, posX = row*squareDist, posZ = line*squareDist, facing = "s", teamName = "player1", checkType = "none", gameTime = 0}
end

function NewSpawner()
    --Spring.Echo("N.O.E. mission_spawner: mission spawner works, but its empty")
end