-- $Id: factions.lua 2491 2008-07-17 13:36:51Z det $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    factions.lua
--  brief:   determines the faction of an unit
--  author:  jK
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

ARM_FACTION  = 0
CORE_FACTION = 1
CHICKEN_FACTION = 2
MIXED_FACTION = 3
NO_FACTION = 4
NUM_FACTIONS = 3

local function AddFaction(ud,faction,scaned)
  for i=1,#scaned do
    if (scaned[i]==ud.id) then return end
  end
  scaned[#scaned+1] = ud.id

  if (ud.faction) then
    if (ud.faction~=faction) then
      ud.faction = MIXED_FACTION
      for i=1,#ud.buildOptions do
        AddFaction(UnitDefs[ud.buildOptions[i]],faction,scaned)
      end
    end
  else
    ud.faction = faction
    for i=1,#ud.buildOptions do
      AddFaction(UnitDefs[ud.buildOptions[i]],faction,scaned)
    end
  end
end

for uid,ud in pairs(UnitDefs) do
  if (ud.isCommander) then
    if (ud.name=="armcom") then
      AddFaction(ud,ARM_FACTION,{})
    elseif (ud.name=="corcom") then
      AddFaction(ud,CORE_FACTION,{})
    end
  else
    if (ud.name=="roostfac_big")or(ud.name=="roostfac") then
      AddFaction(ud,CHICKEN_FACTION,{})
    end
  end
end