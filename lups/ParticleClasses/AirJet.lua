-- $Id: AirJet.lua 3171 2008-11-06 09:06:29Z det $
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local AirJet = {}
AirJet.__index = AirJet

local jetShader,jitShader
local tex --//screencopy
local timerUniform, timer2Uniform

local lastTexture1,lastTexture2

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function AirJet.GetInfo()
  return {
    name      = "AirJet",
    backup    = "", --// backup class, if this class doesn't work (old cards,ati's,etc.)
    desc      = "",

    layer     = 4, --// extreme simply z-ordering :x

    --// gfx requirement
    fbo       = true,
    shader    = true,
    distortion= true,
    atiseries = 2,
    ms        = -1,
    intel     = -1,
  }
end


AirJet.Default = {
  layer = 4,
  life  = math.huge,
  repeatEffect  = true,

  emitVector    = {0,0,-1},
  pos           = {0,0,0}, --// not used
  width         = 4,
  length        = 50,
  color         = {0, 0, 0.5},
  distortion    = 0.02,
  jitterWidthScale  = 3,
  jitterLengthScale = 3,
  animSpeed     = 1,

  texture1      = ":n:bitmaps/GPL/Lups/perlin_noise.jpg", --// noise texture
  texture2      = ":nc:bitmaps/GPL/Lups/jet.bmp",       --// shape
  texture3      = ":nc:bitmaps/GPL/Lups/jet.bmp",       --// jitter shape
}

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local spGetGameSeconds = Spring.GetGameSeconds
local glUseShader = gl.UseShader
local glUniform   = gl.Uniform
local glBlending  = gl.Blending
local glTexture   = gl.Texture
local glCallList  = gl.CallList
local GL_ONE_MINUS_SRC_ALPHA = GL.ONE_MINUS_SRC_ALPHA
local GL_SRC_ALPHA           = GL.SRC_ALPHA
local GL_ONE                 = GL.ONE

function AirJet:BeginDraw()
  glUseShader(jetShader)
    glUniform(timerUniform, spGetGameSeconds())
  glBlending(GL_ONE,GL_ONE)
end

function AirJet:EndDraw()
  glUseShader(0)
  glTexture(1,false)
  glTexture(2,false)
  glBlending(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
  lastTexture1,lastTexture2 = "",""
end

function AirJet:Draw()
  if (lastTexture1~=self.texture1) then
    glTexture(1,self.texture1)
    lastTexture1=self.texture1
  end
  if (lastTexture2~=self.texture2) then
    glTexture(2,self.texture2)
    lastTexture2=self.texture2
  end

  glCallList(self.dList)
end



function AirJet:BeginDrawDistortion()
  glUseShader(jitShader)
    glUniform(timer2Uniform, spGetGameSeconds())
end

function AirJet:EndDrawDistortion()
  glUseShader(0)
  glTexture(1,false)
  glTexture(2,false)
  lastTexture1,lastTexture2 = "",""
end

function AirJet:DrawDistortion()
  if (lastTexture1~=self.texture1) then
    glTexture(1,self.texture1)
    lastTexture1=self.texture1
  end
  if (lastTexture2~=self.texture3) then
    glTexture(2,self.texture3)
    lastTexture2=self.texture3
  end

  glCallList(self.dList)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

-- used if repeatEffect=true;
function AirJet:ReInitialize()
  self.dieGameFrame = self.dieGameFrame + self.life
end

function AirJet.Initialize()

  jetShader = gl.CreateShader({
    vertex = [[
      uniform float timer;
      varying float distortion;
      const vec4 centerPos = vec4(0.0,0.0,0.0,1.0);

      // gl_vertex.xy := width/length
      // gl_vertex.zw := texcoord
      // gl_MultiTexCoord0.xy := jitter width/length scale (i.e jitter quad length = gl_vertex.x * gl_MultiTexCoord0.x)
      // gl_MultiTexCoord0.z  := (quad_width) / (quad_length) (used to normalize the texcoord dimensions)
      // gl_MultiTexCoord0.w  := distortion strength
      // gl_MultiTexCoord1    := emit vector
      // gl_MultiTexCoord2.rgb:= color
      // gl_MultiTexCoord2.w  := animation speed

      void main()
      {
        gl_TexCoord[0].st = gl_Vertex.pq;
        gl_TexCoord[1].st = gl_Vertex.pq;
        gl_TexCoord[1].t += timer*gl_MultiTexCoord2.w;

        gl_Position = gl_ModelViewMatrix * centerPos ;
        vec3 dir3   = vec3(gl_ModelViewMatrix * gl_MultiTexCoord1) - gl_Position.xyz;
        vec3 v = normalize( dir3 );
        vec3 w = normalize( -vec3(gl_Position) );
        vec3 u = normalize( cross(w,v) );
        gl_Position.xyz += gl_Vertex.x*v + gl_Vertex.y*u;
        gl_Position      = gl_ProjectionMatrix * gl_Position;

        gl_FrontColor.rgb = gl_MultiTexCoord2.rgb;

        distortion = gl_MultiTexCoord0.w;
      }
    ]],
    fragment = [[
      uniform sampler2D noiseMap;
      uniform sampler2D mask;

      varying float distortion;

      void main(void)
      {
          vec2 displacement = gl_TexCoord[1].st;

          vec2 txCoord = gl_TexCoord[0].st;
          txCoord.s += (texture2D(noiseMap, displacement * distortion * 20.0).y - 0.5) * 40.0 * distortion;
          txCoord.t +=  texture2D(noiseMap, displacement).x * (1.0-txCoord.t)          * 15.0 * distortion;
          float opac = texture2D(mask,txCoord).r;

          gl_FragColor.rgb  = opac * gl_Color.rgb; //color
          gl_FragColor.rgb += pow(opac, 5.0 );     //white flame
          gl_FragColor.a    = opac*1.5;
          //gl_FragColor    = vec4(1.0,1.0,0.0,1.0);
      }

    ]],
    uniformInt = {
      noiseMap = 1,
      mask = 2,
    },
    uniform = {
      timer = 0,
    }
  })

  jitShader = gl.CreateShader({
    vertex = [[
      uniform float timer;
      varying float distortion;
      const vec4 centerPos = vec4(0.0,0.0,0.0,1.0);

      // gl_vertex.xy := width/length
      // gl_vertex.zw := texcoord
      // gl_MultiTexCoord0.xy := jitter width/length scale (i.e jitter quad length = gl_vertex.x * gl_MultiTexCoord0.x)
      // gl_MultiTexCoord0.z  := (quad_width) / (quad_length) (used to normalize the texcoord dimensions)
      // gl_MultiTexCoord0.w  := distortion strength
      // gl_MultiTexCoord1    := emit vector
      // gl_MultiTexCoord2.rgb:= color
      // gl_MultiTexCoord2.w  := animation speed

      void main()
      {
        gl_TexCoord[0].st = gl_Vertex.pq;
        gl_TexCoord[1].st = gl_Vertex.pq*0.8;
        gl_TexCoord[1].s *= gl_MultiTexCoord0.z;
        gl_TexCoord[1]   += 0.2*timer*gl_MultiTexCoord2.w;

        gl_Position = gl_ModelViewMatrix * centerPos;
        vec3 dir3   = vec3(gl_ModelViewMatrix * gl_MultiTexCoord1) - gl_Position.xyz;
        vec3 v = normalize( dir3 );
        vec3 w = normalize( -vec3(gl_Position) );
        vec3 u = normalize( cross(w,v) );
        float length = gl_Vertex.x * gl_MultiTexCoord0.x;
        float width  = gl_Vertex.y * gl_MultiTexCoord0.y;
        gl_Position.xyz += length*v + width*u;
        gl_Position      = gl_ProjectionMatrix * gl_Position;

        distortion = gl_MultiTexCoord0.w;
      }
    ]],
    fragment = [[
      uniform sampler2D noiseMap;
      uniform sampler2D mask;

      varying float distortion;

      void main(void)
      {
          float opac    = texture2D(mask,gl_TexCoord[0].st).r;
          vec2 noiseVec = (texture2D(noiseMap, gl_TexCoord[1].st).st - 0.5) * distortion * opac;
          gl_FragColor  = vec4(noiseVec.xy,0.0,gl_FragCoord.z);
      }

    ]],
    uniformInt = {
      noiseMap = 1,
      mask = 2,
    },
    uniform = {
      timer = 0,
    }
  })


  if (jetShader == nil)or(jitShader == nil) then
    print(PRIO_MAJOR,"LUPS->airjet: shader error: "..gl.GetShaderLog())
    return false
  end

  timerUniform  = gl.GetUniformLocation(jetShader, 'timer')
  timer2Uniform = gl.GetUniformLocation(jitShader, 'timer')
end

function AirJet:Finalize()
  if (gl.DeleteShader) then
    gl.DeleteShader(jetShader)
    gl.DeleteShader(jitShader)
  end
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local glMultiTexCoord = gl.MultiTexCoord
local glVertex        = gl.Vertex
local glCreateList    = gl.CreateList
local glDeleteList    = gl.DeleteList
local glBeginEnd      = gl.BeginEnd
local GL_QUADS        = GL.QUADS

local function BeginEndDrawList(self)
  local color = self.color
  local ev    = self.emitVector 
  glMultiTexCoord(0,self.jitterLengthScale,self.jitterWidthScale,self.width/self.length,self.distortion)
  glMultiTexCoord(1,ev[1],ev[2],ev[3],1)
  glMultiTexCoord(2,color[1],color[2],color[3],self.animSpeed)

  --// xy = width/length ; zw = texcoord
  local w = self.width
  local l = self.length
  glVertex(-l,-w, 1,0)
  glVertex(0, -w, 1,1)
  glVertex(0,  w, 0,1)
  glVertex(-l, w, 0,0)
end


function AirJet:CreateParticle()
  self.dList = glCreateList(glBeginEnd,GL_QUADS,
                            BeginEndDrawList,self)

  --// used for visibility check
  self.radius = self.length*self.jitterLengthScale

  self.dieGameFrame  = thisGameFrame + self.life
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local MergeTable   = MergeTable
local setmetatable = setmetatable

function AirJet.Create(Options)
  local newObject = MergeTable(Options, AirJet.Default)
  setmetatable(newObject,AirJet)  -- make handle lookup
  newObject:CreateParticle()
  return newObject
end

function AirJet:Destroy()
  --gl.DeleteTexture(self.texture1)
  --gl.DeleteTexture(self.texture2)
  glDeleteList(self.dList)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

return AirJet