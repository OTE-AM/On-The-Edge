-- $Id: UnitCloaker.lua 3171 2008-11-06 09:06:29Z det $
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local UnitCloaker = {}
UnitCloaker.__index = UnitCloaker

local warpShader
local tex
local cameraUniform,lightUniform
local isS3oUniform, lifeUniform

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function UnitCloaker.GetInfo()
  return {
    name      = "UnitCloaker",
    backup    = "", --// backup class, if this class doesn't work (old cards,ati's,etc.)
    desc      = "",

    layer     = 16, --// extreme simply z-ordering :x

    --// gfx requirement
    fbo       = true,
    shader    = true,
    rtt       = false,
    ctt       = true,
    atiseries = 2,
    intel     = 0,
  }
end

UnitCloaker.Default = {
  layer = 16,
  worldspace = true,

  inverse    = false,
  life       = math.huge,
  unit       = -1,
  unitDefID  = -1,

  repeatEffect = false,
  dieGameFrame = math.huge
}

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local loadedS3oTexture = -1

function UnitCloaker:BeginDraw()
  gl.Culling(GL.FRONT)
  gl.Culling(true)
  gl.DepthMask(true)

  gl.UseShader(warpShader)
  local x,y,z = Spring.GetCameraPosition()
  gl.Uniform(cameraUniform,x,y,z)

  x,y,z = gl.GetSun( "pos" )
  gl.Light(0,GL.POSITION,x,y,z)

  gl.Uniform(lightUniform,x,y,z)

  x,y,z = gl.GetSun( "ambient" ,"unit")
  gl.Light(0,GL.AMBIENT,x,y,z)
  x,y,z = gl.GetSun( "diffuse" ,"unit")
  gl.Light(0,GL.DIFFUSE,x,y,z)

  gl.Texture(0,"$units")
  --gl.Texture(1,'bitmaps/cdet.bmp')
  --gl.Texture(1,'bitmaps/clouddetail.bmp')
  --gl.Texture(1,'bitmaps/GPL/Lups/perlin_noise.jpg')
  gl.Texture(1,'bitmaps/GPL/Lups/mynoise2.png')
  gl.Texture(4,'$specular')
  gl.Texture(5,'$reflection')

  gl.MatrixMode(GL.PROJECTION)
  gl.PushMatrix()
  gl.MultMatrix("camera")
  gl.MatrixMode(GL.MODELVIEW)
  gl.PushMatrix()
  gl.LoadIdentity()
end

function UnitCloaker:EndDraw()
  gl.MatrixMode(GL.PROJECTION)
  gl.PopMatrix()
  gl.MatrixMode(GL.MODELVIEW)
  gl.PopMatrix()

  gl.Culling(GL.BACK)
  gl.Culling(false)
  gl.DepthMask(true)

  gl.UseShader(0)

  gl.Texture(0,false)
  gl.Texture(1,false)
  gl.Texture(2,false)
  gl.Texture(3,false)
  gl.Texture(4,false)
  gl.Texture(5,false)

  gl.Color(1,1,1,1)

  loadedS3oTexture = -1
end

function UnitCloaker:Draw()
  if (self.isS3o) then
    if (self.unitDefID~=loadedS3oTexture) then
      gl.Texture(2, "%" .. self.unitDefID .. ":0")
      gl.Texture(3, "%" .. self.unitDefID .. ":1")
      loadedS3oTexture = self.unitDefID
    end
    gl.Color(Spring.GetTeamColor(self.team))
  end
  if (self.inverse) then
    gl.Uniform( lifeUniform, 1-(thisGameFrame-self.firstGameFrame)/self.life )
  else
    gl.Uniform( lifeUniform,   (thisGameFrame-self.firstGameFrame)/self.life )
  end
  gl.UniformInt( isS3oUniform, (self.isS3o and 1) or 0 )

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

function UnitCloaker.Initialize()
  warpShader = gl.CreateShader({
    vertex = [[
      uniform vec3 cameraPos;
      uniform vec3 lightPos;
      uniform float life;

      varying float opac;

      //const vec4 ObjectPlaneS = vec4(0.002, 0.002, 0.0,   0.3);
      //const vec4 ObjectPlaneT = vec4(0.0,   0.002, 0.002, 0.3);

      const vec4 ObjectPlaneS = vec4(0.005, 0.005, 0.000,  0.0);
      const vec4 ObjectPlaneT = vec4(0.000, 0.005, 0.005,  0.0);

      void main(void)
      {
        gl_TexCoord[0].st  = gl_MultiTexCoord0.st;
        gl_TexCoord[1].xyz = gl_NormalMatrix * gl_Normal;
        gl_TexCoord[2].xyz = (gl_ModelViewMatrix * gl_Vertex).xyz - cameraPos;

        gl_TexCoord[3].s = dot( gl_Vertex, ObjectPlaneS ); 
        gl_TexCoord[3].t = dot( gl_Vertex, ObjectPlaneT );// + life*0.25;

        gl_FrontColor = gl_Color;

        float a = max( dot(gl_TexCoord[1].xyz, lightPos), 0.0);
        gl_FrontSecondaryColor.rgb = a * gl_LightSource[0].diffuse.rgb + gl_LightSource[0].ambient.rgb;

        opac = dot(normalize(gl_TexCoord[1].xyz), normalize(gl_TexCoord[2].xyz));
        opac = 1.0 - abs(opac);
        opac = pow(opac, 5.0);

        gl_Position = ftransform();
      }
    ]],
    fragment = [[
      uniform sampler2D texture3do;
      uniform sampler2D textureS3o1;
      uniform sampler2D textureS3o2;
      uniform sampler2D noiseMap;
      uniform samplerCube specularMap;
      uniform samplerCube reflectMap;
      uniform bool      isS3o;
      uniform float     life;

      varying float opac;

      void main(void)
      {
          vec4 noise = texture2D(noiseMap, gl_TexCoord[3].st);

          //if (noise.r < life) {
          //  discard;
          //}

          if (isS3o) {
            gl_FragColor     = texture2D(textureS3o1, gl_TexCoord[0].st);
            gl_FragColor.rgb = mix(gl_FragColor.rgb,gl_Color.rgb,gl_FragColor.a);

            vec4 extraColor = texture2D(textureS3o2, gl_TexCoord[0].st);

            vec3 normal  = normalize(gl_TexCoord[1].xyz);
            vec3 cam     = gl_TexCoord[2].xyz;
            vec3 reflectDir = reflect(cam, normal);

            vec3 spec = textureCube(specularMap, reflectDir).rgb * 4.0 * extraColor.g;
            vec3 refl = textureCube(reflectMap,  reflectDir).rgb;
            refl  = mix(gl_SecondaryColor.rgb, refl, extraColor.g);
            refl += extraColor.r;

            gl_FragColor.rgb = gl_FragColor.rgb * refl + spec;
            gl_FragColor.a   = extraColor.a;

            if (life*1.4>noise.r) {
              float d = life*1.4-noise.r;
              gl_FragColor.a *= smoothstep(0.4,0.0,d);
            }
            gl_FragColor.rgb += vec3(life*0.25);
          }else{
            gl_FragColor = texture2D(texture3do, gl_TexCoord[0].st);

            vec3 normal  = normalize(gl_TexCoord[1].xyz);
            vec3 cam     = gl_TexCoord[2].xyz;
            vec3 reflectDir = reflect(cam, normal);

            vec3 spec = textureCube(specularMap, reflectDir).rgb * 4.0 * gl_FragColor.a;
            vec3 refl = textureCube(reflectMap,  reflectDir).rgb;
            refl = mix(gl_SecondaryColor.rgb, refl, gl_FragColor.a);

            gl_FragColor.rgb = gl_FragColor.rgb * refl + spec;
            gl_FragColor.a   = 1.0;

            if (life*1.4>noise.r) {
              float d = life*1.4-noise.r;
              gl_FragColor.a *= smoothstep(0.4,0.0,d);
            }
            gl_FragColor.rgb += vec3(life*0.25);
          }
      }
    ]],
    uniform = {
      isS3o    = false,
    },
    uniformInt = {
      texture3do  = 0,
      noiseMap    = 1,
      textureS3o1 = 2,
      textureS3o2 = 3,
      specularMap = 4,
      reflectMap  = 5,
    },
    uniformFloat = {
      life  = 1,
    }
  })

  if (warpShader == nil) then
    print(PRIO_MAJOR,"LUPS->UnitCloaker: criticle shader error: "..gl.GetShaderLog())
    return false
  end

  cameraUniform = gl.GetUniformLocation(warpShader, 'cameraPos')
  lightUniform  = gl.GetUniformLocation(warpShader, 'lightPos')

  isS3oUniform  = gl.GetUniformLocation(warpShader, 'isS3o')
  lifeUniform   = gl.GetUniformLocation(warpShader, 'life')
end

function UnitCloaker.Finalize()
  if (gl.DeleteShader) then
    gl.DeleteShader(warpShader)
  end
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

-- used if repeatEffect=true;
function UnitCloaker:ReInitialize()
  self.dieGameFrame = self.dieGameFrame + self.life
end

function UnitCloaker:CreateParticle()
  self.isS3o = (UnitDefs[self.unitDefID].model.name:lower():find("s3o") and true)
  self.firstGameFrame = thisGameFrame
  self.dieGameFrame   = self.firstGameFrame + self.life
end

function UnitCloaker:Visible()
  local x,y,z    = Spring.GetUnitPosition(self.unit)
  if (x==nil) then return false end
  local _,inLos  = Spring.GetPositionLosState(x,y,z, LocalAllyTeamID)
  if (self.enemy) then
    local losState = Spring.GetUnitLosState(self.unit, LocalAllyTeamID) or {}
    inLos = (inLos)and(not losState.los)
  end
  return (inLos)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function UnitCloaker.Create(Options)
  SetUnitLuaDraw(Options.unit,true)
  local newObject = MergeTable(Options, UnitCloaker.Default)
  setmetatable(newObject,UnitCloaker)  -- make handle lookup
  newObject:CreateParticle()
  return newObject
end

function UnitCloaker:Destroy()
  SetUnitLuaDraw(self.unit,false)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

return UnitCloaker
