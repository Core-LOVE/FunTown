local MyMap, super = Class(Map)

local circleShader = love.graphics.newShader[[
	extern float factor;
	extern float displacement;
	vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
	{
		float s = sin((tc.x) * 3.1415926535897932384626433832795);
		
		//float dx = mod((tc.x + displacement), 1.0);
		//float dy = tc.y - s * s * factor;
		
		float dx = mod((tc.x + displacement), 1.0);
		//texture_coords.y * (0.8 + s * 0.2) - s * 0.1 + 0.1;
		float dy = tc.y * (0.8 + s * factor) - s * 0.1 + 0.1;
		
		vec2 newpos = vec2(dx, dy);
		
		return Texel(tex, newpos) * color;
	}
]]

local shader = love.graphics.newShader[[
	extern float factor;
	extern float displacement;
	vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
	{
		float s = -sin((tc.x) * 3.1415926535897932384626433832795);
		
		//float dx = mod((tc.x + displacement), 1.0);
		//float dy = tc.y - s * s * factor;
		
		float dx = mod((tc.x + displacement), 1);
		float dy = tc.y * (1 + s * factor) - s * 0.025 + 0.4;
		
		vec2 newpos = vec2(dx, dy);
		
		return Texel(tex, newpos) * color;
	}
]]

local shader2 = love.graphics.newShader[[
	extern float factor;
	extern float displacement;
	vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
	{
		float s = -sin((tc.x) * 3.1415926535897932384626433832795);
		
		//float dx = mod((tc.x + displacement), 1.0);
		//float dy = tc.y - s * s * factor;
		
		float dx = mod((tc.x + displacement), 1);
		float dy = tc.y * (1 + s * factor) - s * 0.025 + 0.4;
		
		vec2 newpos = vec2(dx, dy);
		
		return Texel(tex, newpos) * color;
	}
]]

local move = false
local speed = 3

circleShader:send("factor", 0.2)
shader2:send("factor", 0.2)
shader:send("factor", 0.2)

-- foreground
local seats
local seats2

do
	seats = Sprite("tilesets/parallax/seats", 0, 480 + 192)
	seats.wrap_texture_x = true
	seats:setScale(2)
	seats.shader = shader

	local draw = seats.draw
	local displacement = 0

	seats.draw = function(self)
		if move then
			displacement = (displacement - DT / speed) % 1
			circleShader:send("displacement", displacement)
		end
		
		love.graphics.setShader(self.shader)
		draw(self)
		love.graphics.setShader()
	end
end
	
do
	seats2 = Sprite("tilesets/parallax/seats", 0, 480 + 256)
	seats2.wrap_texture_x = true
	seats2:setScale(2)
	seats2.shader = shader2
	
	local col = 0.25
	seats2.color = {col, col, col}
	
	local draw = seats2.draw
	local displacement = 0

	seats2.draw = function(self)
		if move then
			displacement = (displacement + DT / speed + .1) % 1
			shader2:send("displacement", displacement)
		end
		
		love.graphics.setShader(self.shader)
		draw(self)
		love.graphics.setShader()
	end
end

-- bg
local BGseats

do
	BGseats = Sprite("tilesets/parallax/bgseats", 0, 240 - (155 * .5))
	BGseats:setScale(2)
	BGseats.wrap_texture_x = true
	-- BGseats:setScale(2)
	BGseats.shader = circleShader

	local draw = BGseats.draw
	local displacement = 0

	BGseats.draw = function(self)
		if move then
			displacement = (displacement + DT / speed) % 1
			shader:send("displacement", displacement)
		end
		
		love.graphics.setShader(self.shader)
		draw(self)
		love.graphics.setShader()
	end
end

local curtains = Sprite("tilesets/parallax/curtains", 0, 480 - 72)
curtains.wrap_texture_x = true
curtains:setScale(2)

local draw = BGseats.draw
curtains.draw = function(self)
	if move then
		self.x = self.x + 2
	end
	
	draw(self)
end
-- map

function MyMap:initBG()
	local bg = Object()

	local fg = Object(0, 0)
	fg:addChild(seats)
	fg:addChild(seats2)
	bg:addChild(BGseats)
	
	self.bg = bg
	self.fg = fg
	Game.world:spawnObject(bg, -1)
	Game.world:spawnObject(fg, 99)
	Game.world:spawnObject(curtains, 1)
end

function MyMap:initDark()
	local dark = Rectangle(0, 0, 640, 480 * 2)
	dark.color = {0, 0, 0.075}
	dark.alpha = 0.3
	
	local draw = dark.draw
	local t = 0
	
	local drawChara = function(chara)
		local w = chara.width + 16
		local x = chara.x + (math.cos(t / 10) * 4)
		
		love.graphics.push('all')
		love.graphics.ellipse('fill', x, chara.y - 4, w, 16)
		love.graphics.setLineWidth(48)
		love.graphics.line(x - 8, chara.y, chara.x + 48, 0)
		love.graphics.pop()
	end
	
	local drawEnemy = function(chara)
		local w = chara.width + 16
		local x = chara.x - (math.cos(t / 10) * 4)
		
		love.graphics.push('all')
		love.graphics.ellipse('fill', x, chara.y - 4, w, 16)
		love.graphics.setLineWidth(100)
		love.graphics.line(x, chara.y - 4, chara.x - 48, 0)
		love.graphics.pop()
	end
	
	local drawParty = function()
		if not Game.battle then 
			for _,chara in ipairs(Game.stage:getObjects(Follower)) do
				drawChara(chara)
			end	
	
			for _,chara in ipairs(Game.stage:getObjects(NPC)) do
				drawEnemy(chara)
			end
			
			drawChara(Game.world.player)
			
			return 
		end
		
		for _,chara in ipairs(Game.battle.party) do
			drawChara(chara)
		end
		
		for _,chara in ipairs(Game.battle.enemies) do
			drawEnemy(chara)
		end
	end
	
	dark.draw = function(self)
		if move then 
			t = t + 1
		end
		
		love.graphics.stencil(drawParty, "replace", 1, false)
		love.graphics.setStencilTest("lequal", 0)
		draw(self)
		love.graphics.setStencilTest()
	end
	
	Game.world:spawnObject(dark, .5)
	return dark
end

function MyMap:startBG()
	move = true
end

function MyMap:setSpeed(v)
	speed = v
end

function MyMap:load()
	super:load(self)
	self:initBG()
	self:initDark()
	local dark = self:initDark()
	dark.x = dark.x - 4
	dark.width = dark.width + 8
	dark.color = {0, 0, 0}

	local t = Timer()
	local distance = 42

	t:every(0.175, function()
		local part = Sprite("effects/homewoods_lamp_particle", math.random(640), math.random(480 * 2))
		part:setScale(math.random(1, 2))
		part.alpha = 0.25
		local live = math.random(2, 3) + .5

		t:tween(live, part, {
			x = part.x + math.random(-distance, distance),
			y = part.y + math.random(-distance, distance),
			alpha = 0,
			rotation = math.rad(math.random(0, 360))
		}, 'out-sine', function()
			part:remove()
		end)

		dark:addChild(part)
	end)
	
	dark:addChild(t)

	local gradient = Sprite("other/gradient_screen")
	gradient:setScaleOrigin(.5)
	gradient:setScale(-1)
	gradient.parallax_x = 0
	gradient.parallax_y = 0
	gradient.alpha = 0.1

	Game.world:spawnObject(gradient, 99)

	local gradient = Sprite("other/gradient_screen")
	gradient:setScaleOrigin(.5)
	gradient.parallax_x = 0
	gradient.parallax_y = 0
	gradient.color = {0, 0, 0.01}
	gradient.alpha = .5

	Game.world:spawnObject(gradient, 99)
	Game:setBorder("simple")
    Game.fader:fadeIn(nil, {alpha = 1, speed = 0.5})
end

return MyMap