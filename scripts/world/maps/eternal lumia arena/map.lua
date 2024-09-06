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

function MyMap:initBg()
	local spr = Sprite("tilesets/parallax/eternal_lumia_frames", 0, 64)
	spr:setScale(2)
	spr:addFX(ShaderFX(circleShader, {
		["factor"] = 0.32,
		["displacement"] = function() return self.spin_timer end,
	}))
	
	local spr2 = Sprite("tilesets/parallax/eternal_lumia_frames", 0, 64 + 120)
	spr2:setScale(2)
	spr2.scale_y = -1.5
	spr2.scale_origin_y = 1
	spr2.alpha = 0.5
	spr2:addFX(ShaderFX(circleShader, {
		["factor"] = 0.32,
		["displacement"] = function() return self.spin_timer end,
	}))
	
	-- Transstaging(spr)
	
	Game.world:spawnObject(spr2, -100)
	Game.world:spawnObject(spr, -100)
end

function MyMap:initFog()
	local spr = Sprite("tilesets/parallax/fog")
	spr:setScale(2)
	spr.alpha = 0.1
	spr.wrap_texture_x = true
	spr.physics.speed_x = 4
	
	Transstaging(spr)
	
	Game.world:spawnObject(spr, 99)
end

function MyMap:initPoles()
	local dx, dy = 0, 0
	
    for i = 1, 3 do
		if i == 3 then
			dy = dy - 16
			dx = dx - 16
		end
		
		local bottom = Sprite("other/pole_bottom", 48 + dx, 96 + dy)
		bottom:setScale(2)
		
		Game.world:spawnObject(bottom, 38)
		
		local spr = Sprite("other/pole_top", 48 + dx, 96 + dy)
		spr:setScale(2)

		local speed = 0.075
		local frames = {1, 2, 3, 4, 5}

		if i == 2 then
			frames = Utils.reverse(frames)
		end 

		spr:setAnimation({nil, speed, true, frames = frames})
	
		Game.world:spawnObject(spr, 40)
		
		dx = dx + 16
		dy = dy + 94
	end
	
	local bottom = Sprite("other/lumia_pole_bottom", 480, 216)
	bottom:setScale(2)
	
	Game.world:spawnObject(bottom, 38)
	
	local spr = Sprite("other/lumia_pole_top", 480, 216)
	spr:setScale(2)
	spr:play(0.2)

	Game.world:spawnObject(spr, 40)
end

function MyMap:onEnter()
	super.onEnter(self)
	Game:removePartyMember("ralsei")
	Game:addPartyMember("ralsei")
    Game.fader:fadeIn(nil, {alpha = 1, speed = 0.5})
	Game:setBorder("eternal")

	self.timer = Timer()
	-- self.timer:every(0.25, function()
	
	-- end)
	
	Game.world:addChild(self.timer)
	
	self.spin_speed = 0.15
	self.spin_timer = 0

	self:initBg()
	self:initFog()
	self:initPoles()
end

local function spawnEffect(self)
	local x = math.random(0, 800)
	local y = math.random(0, 48)
	
	local speed = math.random() / 7
	
	local effect = Sprite("effects/eternal lumia/star", x, y)
	effect:setOrigin(.5, .5)
	effect:setScale(math.random(2))	
	effect.alpha = effect.scale_y / 2
	effect:play(speed, false, function()
		effect:remove()
	end)
	effect.graphics.spin = math.random() / 20
	effect.physics.speed_x = math.random() * 1.5
	
	Game.world:addChild(effect, -125)
	effect:setLayer(-125)
	
	local effect_r = Sprite("effects/eternal lumia/star", x, y + 240 + 48)
	effect_r:setOrigin(.5, .5)
	effect_r.scale_x = effect.scale_x
	effect_r.scale_y = -effect.scale_y * .75
	effect_r.alpha = effect.alpha * .5
	effect_r:play(speed, false, function()
		effect_r:remove()
	end)
	effect_r.graphics.spin = -effect.graphics.spin
	effect_r.physics.speed_x = effect.speed_x
	
	Game.world:addChild(effect_r, -125)
	effect_r:setLayer(-125)
	
	return effect, effect_r
end

function MyMap:update()
	super.update(self)
	
	self.spin_timer = self.spin_timer + (self.spin_speed * 0.05)

	if math.random() > 0.75 then
		spawnEffect()
	end
	
	if math.random() > 0.4 then
		local e, r = spawnEffect()
		
		e.alpha = e.alpha * .5
		e.physics.speed_x = e.physics.speed_x * .5
		e:setScale(e.scale_x * .5)
		
		r.alpha = r.alpha * .5
		r.physics.speed = e.physics.speed_x
		r:setScale(e.scale_x * .5, r.scale_y * .5)	
	end
end

return MyMap