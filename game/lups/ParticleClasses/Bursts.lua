-- $Id: Bursts.lua 3171 2008-11-06 09:06:29Z det $
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

-- todo: burst .rotArc length (in DisplayList creation)

local Bursts = {}
Bursts.__index = Bursts

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
function Bursts.GetInfo()
  return {
    name      = "Bursts",
    backup    = "", --// backup class, if this class doesn't work (old cards,ati's,etc.)
    desc      = "",

    layer     = -16, --// extreme simply z-ordering :x

    --// gfx requirement
    fbo       = false,
    shader    = false,
    rtt       = false,
    ctt       = false,
  }
end

Bursts.Default = {
  lists = {},

  pos        = {0,0,0}, -- start pos
  layer      = -16,

  life       = 0,
  lifeSpread = 0,

  rotSpeed   = 0,
  rotSpread  = 0,
  rotairdrag = 1,

  arc        = 60,
  arcSpread  = 0,

  size       = 0,
  sizeSpread = 0,
  sizeGrowth = 0,
  colormap   = { {0, 0, 0, 0} },

  directional= false, -- This option only looks good in combination with a sphere. So you can do sunburst effects with it.

  srcBlend   = GL.SRC_ALPHA,
  dstBlend   = GL.ONE_MINUS_SRC_ALPHA,
  texture    = 'bitmaps/GPL/Lups/sunburst.png',
  count      = 0,
  repeatEffect = false,
  genmipmap    = true,  -- todo
}

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Bursts:InitializePartList(partList)
  partList.rotspeed = self.rotSpeed
  partList.size     = self.size
  partList.life     = 0
  local r,g,b,a     = GetColor(self.colormap,partList.life)
  partList.color    = {r,g,b,a}
  partList.arc      = self.arc
  partList.rotArc   = 0
  partList.start_pos= self.pos

  -- spread values
  if (self.sizeSpread>0)  then partList.size    = partList.size     + math.random(self.sizeSpread*100)/100 end
  if (self.rotSpread>0)   then partList.rotspeed= partList.rotspeed + math.random(self.rotSpread*100)/100 end
  if (self.arcSpread>0)   then partList.arc     = partList.arc + math.random(self.arc) end
  local rand = 0
  if (self.lifeSpread>0) then rand = math.random(self.lifeSpread) end
  partList.life_incr = 1/(self.life+rand)

  -- create rotation up vector
  partList.rotv = {((-1)^math.random(2,3))*math.random(),((-1)^math.random(2,3))*math.random(),((-1)^math.random(2,3))*math.random()}
  local  length = math.sqrt(partList.rotv[1]^2+partList.rotv[2]^2+partList.rotv[3]^2)
  partList.rotv = {partList.rotv[1]/length,partList.rotv[2]/length,partList.rotv[3]/length}
end

function Bursts:UpdatePartList(partList,n)
  local rotBoost = 0
  for i=1,n do rotBoost = rotBoost + partList.rotspeed*(self.rotairdrag^i) end

  partList.rotArc   = partList.rotArc*(self.rotairdrag^n) + rotBoost
  partList.size     = partList.size  + n*self.sizeGrowth
  partList.life     = partList.life  + n*partList.life_incr
  local r,g,b,a     = GetColor(self.colormap,partList.life)
  partList.color    = {r,g,b,a}
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Bursts:BeginDraw()
end

function Bursts:EndDraw()
  gl.Texture(false)
  gl.Color(1,1,1,1)
  gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
end

function Bursts:Draw()
  --if self.genmipmap then
  --  gl.GenerateMipmap(self.texture)
  --  self.genmipmap = false
  --end

  gl.Texture(self.texture)  
  gl.Blending(self.srcBlend,self.dstBlend)
  gl.PushMatrix()
  gl.Translate(self.pos[1],self.pos[2],self.pos[3])

  local partList
  for i=1,#self.lists do
      partList = self.lists[i]
      local rotv = partList.rotv
      local size = partList.size

      gl.Color(partList.color)

      gl.PushMatrix()
        gl.Rotate(partList.rotArc,rotv[1],rotv[2],rotv[3])
        gl.Scale(size,size,size)
        gl.CallList(partList.dlist)
      gl.PopMatrix()
  end

  gl.PopMatrix()
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

local function rotateVector(vector,axis,phi)
  local rcos = math.cos(math.pi*phi/180);
  local rsin = math.sin(math.pi*phi/180);
  local u,v,w = axis[1],axis[2],axis[3];
  local matrix = {};
  matrix[0],matrix[1],matrix[2] = {},{},{};

  matrix[0][0] =      rcos + u*u*(1-rcos);
  matrix[1][0] =  w * rsin + v*u*(1-rcos);
  matrix[2][0] = -v * rsin + w*u*(1-rcos);
  matrix[0][1] = -w * rsin + u*v*(1-rcos);
  matrix[1][1] =      rcos + v*v*(1-rcos);
  matrix[2][1] =  u * rsin + w*v*(1-rcos);
  matrix[0][2] =  v * rsin + u*w*(1-rcos);
  matrix[1][2] = -u * rsin + v*w*(1-rcos);
  matrix[2][2] =      rcos + w*w*(1-rcos);

  local x,y,z = vector[1],vector[2],vector[3];

  return x * matrix[0][0] + y * matrix[0][1] + z * matrix[0][2],
         x * matrix[1][0] + y * matrix[1][1] + z * matrix[1][2],
         x * matrix[2][0] + y * matrix[2][1] + z * matrix[2][2];
end

local function DrawBurst(rotv,directional,arc)
  -- we need a orthognalized vector to the rotation vector "rotv"
    -- random vector
    local alpha,beta,gamma = ((-1)^math.random(2,3))*math.random(),((-1)^math.random(2,3))*math.random(),((-1)^math.random(2,3))*math.random()

    -- gram-schmidt
    local proj = (rotv[1]*alpha + rotv[2]*beta + rotv[3]*gamma) / (rotv[1]^2 + rotv[2]^2 + rotv[3]^2)
    alpha,beta,gamma = alpha-rotv[1]*proj, beta-rotv[2]*proj, gamma-rotv[3]*proj

    -- normalization
    local length = math.sqrt(alpha^2+beta^2+gamma^2)
    alpha,beta,gamma = alpha/length,beta/length,gamma/length

  -- now we need a third vector, to get the 3th vertex
    local v,u,w;

  gl.BeginEnd(GL.TRIANGLE_FAN,function()
      gl.TexCoord(1,1)
    gl.Vertex(0,0,0)
      gl.TexCoord(0,1)
    gl.Vertex(alpha,beta,gamma)

    if (directional) then
      local n = arc
      local t, t_inc = 0, 1/n
      v,u,w = alpha,beta,gamma
      while (n>=45) do
        v,u,w = rotateVector({v,u,w},rotv,45)
          gl.TexCoord(0,1-t)
        gl.Vertex(v,u,w)
        n = n-45
        t = t + t_inc*45
      end
      if (n>0) then
        v,u,w = rotateVector({v,u,w},rotv,n)
          gl.TexCoord(0,0)
        gl.Vertex(v,u,w)
      end
    else
      v,u,w = alpha,gamma,beta  -- 'random' movement of the burst
        gl.TexCoord(0,0)
      gl.Vertex(v,u,w)
    end

  end)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Bursts:Update(n)
  for _,partList in ipairs(self.lists) do
    if (partList.life<1) then
      self:UpdatePartList(partList,n)
    end
  end
end

-- used if repeatEffect=true;
function Bursts:ReInitialize()
  for _,partList in ipairs(self.lists) do
    partList.life = 0
    -- self:InitializePartList(partList)
  end
  self.dieGameFrame = self.dieGameFrame + self.life + self.lifeSpread
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Bursts:Initialize()
end

function Bursts:Finalize()
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Bursts:CreateParticle()
  for i=1,self.count do
    local newPartList = {}
    self:InitializePartList(newPartList)
    newPartList.dlist = gl.CreateList( DrawBurst ,newPartList.rotv,self.directional,newPartList.arc)
    table.insert(self.lists,newPartList)
  end

  self.firstGameFrame = thisGameFrame
  self.dieGameFrame   = self.firstGameFrame + self.life + self.lifeSpread
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

function Bursts.Create(Options)
  local newObject = MergeTable(Options, Bursts.Default)
  setmetatable(newObject,Bursts)  -- make handle lookup
  newObject:CreateParticle()
  return newObject
end

function Bursts:Destroy()
  for _,partList in ipairs(self.lists) do
    gl.DeleteList(partList.dlist)
  end
  gl.DeleteTexture(self.texture)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

return Bursts