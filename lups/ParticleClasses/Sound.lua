-- $Id: Sound.lua 3171 2008-11-06 09:06:29Z det $
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local Sound = {}
Sound.__index = Sound

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Sound.GetInfo()
  return {
    name      = "Sound",
    backup    = "",
    desc      = "Plays '.wav'-files",
    layer     = 0,
  }
end

Sound.Default = {
  layer = 0,
  worldspace = true,

  file   = '',
  volume = 100.0,
  pos    = {0,0,0},
  blockfor = 60, --//in gameframes. used to block the sound for a specific amount of time (-> don't oversample the sound)

  unit   = -1,

  repeatEffect = false,
  dieGameFrame = math.huge
}

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local GetUnitLosState = Spring.GetUnitLosState
local PlaySoundFile   = Spring.PlaySoundFile

local lastPlayed = {}

function Sound.Create(Options)
  --// play sound and exit
  local file   = Options.file
  local volume = Options.volume or 100.0
  local pos    = Options.pos

  if (Options.unit) then
    local losState = GetUnitLosState(Options.unit,LocalAllyTeamID) or {}
    if (not losState.los) then return false end
  end

  if (file) then
    if (thisGameFrame>(lastPlayed[file] or 0)) then  --// is the sound blocked?
      lastPlayed[file] = thisGameFrame + (Options.length or 60)
      if (pos) then
        Spring.PlaySoundFile(file,volume,pos[1],pos[2],pos[3])
      else
        Spring.PlaySoundFile(file,volume)
      end
    end
  end

  --// destroy object
  return false
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

return Sound