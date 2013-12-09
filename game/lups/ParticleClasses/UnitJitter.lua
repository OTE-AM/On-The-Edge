-- $Id: UnitJitter.lua 3171 2008-11-06 09:06:29Z det $
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local UnitJitter = {}
UnitJitter.__index = UnitJitter

local warpShader, warpShader2
local tex
local timerUniform, lifeUniform, lifeUniform2

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function UnitJitter.GetInfo()
  return {
    name      = "UnitJitter",
    backup    = "", --// backup class, if this class doesn't work (old cards,ati's,etc.)
    desc      = "",

    layer     = 15, --// extreme simply z-ordering :x

    --// gfx requirement
    fbo       = true,
    shader    = true,
    distortion= true,
    atiseries = 2,
    intel     = 0,
  }
end

UnitJitter.Default = {
  layer      = 15,
  worldspace = true,

  inverse    = false,
  life       = math.huge,
  unit       = -1,
  unitDefID  = 0,
  team       = -1,

  repeatEffect = false,
  dieGameFrame = math.huge
}


local noiseTexture = 'bitmaps/GPL/Lups/perlin_noise.jpg'

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function UnitJitter:BeginDrawDistortion()
  gl.UseShader(warpShader)
  gl.Uniform(timerUniform,  Spring.GetGameSeconds()*0.1 - 0.5 )
  gl.PolygonOffset(0,-1)
  gl.Culling(GL.FRONT)
  gl.PushAttrib(GL.DEPTH_BUFFER_BIT)
  gl.DepthTest(true)
  gl.DepthMask(true)
  gl.Texture(0,noiseTexture)
end

function UnitJitter:EndDrawDistortion()
  gl.UseShader(0)
  gl.Texture(0,false)
  gl.PolygonOffset(false)
  gl.Culling(GL.BACK)
  gl.Culling(false)
  gl.PopAttrib()
end

function UnitJitter:DrawDistortion()
  if (self.inverse) then
    gl.Uniform(lifeUniform,   ((thisGameFrame-self.firstGameFrame)/self.life) )
  else
    gl.Uniform(lifeUniform, 1-((thisGameFrame-self.firstGameFrame)/self.life) )
  end

  if (self.isS3o) then
    gl.Culling(GL.BACK)
    gl.Unit(self.unit,true,-1)
    gl.Culling(GL.FRONT)
  else
    gl.Unit(self.unit,true,-1)
  end
end


function UnitJitter:BeginDraw()
  gl.UseShader(warpShader2)
  gl.Blending(GL.ONE,GL.ONE)
  gl.PolygonOffset(-2,-2)
  gl.Culling(GL.FRONT)
  gl.PushAttrib(GL.DEPTH_BUFFER_BIT)
  gl.DepthTest(true)
  gl.DepthMask(true)
  gl.Texture(0,noiseTexture)
end

function UnitJitter:EndDraw()
  gl.UseShader(0)
  gl.Texture(0,false)
  gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
  gl.PolygonOffset(false)
  gl.Culling(GL.BACK)
  gl.Culling(false)
  gl.PopAttrib()
  gl.Color(1,1,1,1)
end

function UnitJitter:Draw()
  if (self.inverse) then
    gl.Uniform(lifeUniform2,   ((thisGameFrame-self.firstGameFrame)/self.life) )
  else
    gl.Uniform(lifeUniform2, 1-((thisGameFrame-self.firstGameFrame)/self.life) )
  end

  gl.Color(self.teamColor)
  if (self.isS3o) then
    gl.Culling(GL.BACK)
    gl.Unit(self.unit,true,-1)
    gl.Culling(GL.FRONT)
  else
    gl.Unit(self.unit,true,-1)
  end
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function UnitJitter.Initialize()
  warpShader = gl.CreateShader({
    vertex = [[
      uniform float timer;

      const vec4 ObjectPlaneS = vec4(0.005, 0.005, 0.000,  0.0);
      const vec4 ObjectPlaneT = vec4(0.000, 0.005, 0.005,  0.0);

	void main()
	{
            gl_Position = ftransform();
            gl_TexCoord[0].s = dot( gl_Vertex, ObjectPlaneS ) + timer; 
            gl_TexCoord[0].t = dot( gl_Vertex, ObjectPlaneT ) + timer;
	}
    ]],
    fragment = [[
      uniform sampler2D noiseMap;
      uniform float     life;

      void main(void)
      {
          vec2 noiseVec;
          noiseVec = texture2D(noiseMap, gl_TexCoord[0].st).rg;
          noiseVec = (noiseVec - 0.50) * 0.02 * life;

          gl_FragColor = vec4(noiseVec,0.0,gl_FragCoord.z);
      }
    ]],
    uniformInt = {
      noiseMap = 0,
    },
    uniformFloat = {
      timer = 0,
      life  = 1,
    }
  })

  if (warpShader == nil) then
    print(PRIO_MAJOR,"LUPS->UnitJitter: criticle shader error: "..gl.GetShaderLog())
    return false
  end

  timerUniform  = gl.GetUniformLocation(warpShader, 'timer')
  lifeUniform   = gl.GetUniformLocation(warpShader, 'life')


  warpShader2 = gl.CreateShader({
    vertex = [[
      varying float opac;

      void main()
      {
          gl_Position = ftransform();
          gl_FrontColor = gl_Color;
          opac = 1.0-abs( dot(normalize(gl_NormalMatrix * gl_Normal), normalize(vec3(gl_ModelViewMatrix * gl_Vertex))) );
      }
    ]],
    fragment = [[
      uniform float life;
      varying float opac;

      void main(void)
      {
          gl_FragColor  = mix(gl_Color,vec4(1.0),opac*0.5);
          gl_FragColor *= (opac+1.0);
          gl_FragColor *= life*0.4*opac;
      }
    ]],
    uniformFloat = {
      life  = 1,
    }
  })

  if (warpShader2 == nil) then
    print(PRIO_MAJOR,"LUPS->UnitJitter: criticle shader2 error: "..gl.GetShaderLog())
    return false
  end

  lifeUniform2   = gl.GetUniformLocation(warpShader2, 'life')
end

function UnitJitter.Finalize()
  if (gl.DeleteShader) then
    gl.DeleteShader(warpShader)
  end
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local spGetTeamColor = Spring.GetTeamColor

-- used if repeatEffect=true;
function UnitJitter:ReInitialize()
  self.dieGameFrame = self.dieGameFrame + self.life
end

function UnitJitter:CreateParticle()
  self.isS3o = (UnitDefs[self.unitDefID].model.name:lower():find("s3o") and true)
  self.teamColor = {spGetTeamColor(self.team)}
  self.firstGameFrame = thisGameFrame
  self.dieGameFrame   = self.firstGameFrame + self.life
end

function UnitJitter:Visible()
  local x,y,z    = Spring.GetUnitPosition(self.unit)
  if (x==nil) then return false end
  local _,inLos  = Spring.GetPositionLosState(x,y,z, LocalAllyTeamID)
  if (self.enemyHit)and(not Spring.AreTeamsAllied(self.team,LocalAllyTeamID)) then
    local losState = Spring.GetUnitLosState(self.unit, LocalAllyTeamID) or {}
    inLos = (inLos)and(not losState.los)
  end
  return (inLos)and(Spring.IsUnitVisible(self.unit))
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function UnitJitter.Create(Options)
  SetUnitLuaDraw(Options.unit,true)

  local newObject = MergeTable(Options, UnitJitter.Default)
  setmetatable(newObject,UnitJitter)  -- make handle lookup
  newObject:CreateParticle()
  return newObject
end

function UnitJitter:Destroy()
  SetUnitLuaDraw(self.unit,false)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

return UnitJitter
