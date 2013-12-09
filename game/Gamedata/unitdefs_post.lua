--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modOptions
if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- example of some fix
-- for name, ud in pairs(UnitDefs) do
	-- ud.collisionvolumetest = 1
-- end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- local function for playing with parameters
local function tobool(val)
  local t = type(val)
  if (t == 'nil') then
    return false
  elseif (t == 'boolean') then
    return val
  elseif (t == 'number') then
    return (val ~= 0)
  elseif (t == 'string') then
    return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end

-- noe stuff
if (modOptions.mission_name ~= "none" and modOptions.mission_name ~= nil) then
    local missionPostDefPath = "missions/" .. modOptions.mission_name .. "/mission_unitdefs_post.lua"
	Spring.Echo("Using mission unit defs post edit from file: " .. missionPostDefPath)
    VFS.Include(missionPostDefPath)
	RunMissionPostDefs()
end

	