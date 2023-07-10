local MyWave, super = Class(Wave)

local shader = love.graphics.newShader[[
	uniform float iTime;
	
	float noise(vec2 pos, float evolve) {
		// Loop the evolution (over a very long period of time).
		float e = fract((evolve*0.01));
		
		// Coordinates
		float cx  = pos.x*e;
		float cy  = pos.y*e;
		
		// Generate a "random" black or white value
		return fract(23.0*fract(2.0/fract(fract(cx*2.4/cy*23.0+pow(abs(cy/22.4),3.3))*fract(cx*evolve/pow(abs(cy),0.050)))));
	}

	vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
		// Increase this number to test performance
		int intensity = 1;
		
		vec3 colour;
		
		for (int i = 0; i < intensity; i++)
			{
			// Generate a black to white pixel
			colour = vec3(noise(texture_coords,iTime));
			}
		
		vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
		vec4 c = vec4(vec3(2.5, 2.5, 2.5) * (max(pixel.r, max(pixel.g, pixel.b))), 1.0);
		c.a = pixel.a;
		
		return vec4(colour, 1.0) * c;
	}
]]

function MyWave:init()
	super.init(self)
	
	self:setArenaSize(256, 96)
end

function MyWave:onArenaEnter()
	local arena = Game.battle.arena
	arena.canHurt = true
	
	arena.sprite:addFX(ShaderFX(shader, {
		["iTime"] = function() return Kristal.getTime() end
	}))
end

function MyWave:spawnLaser()
	self.timer:script(function(wait)
		local arena = Game.battle.arena
		
		local x, y = arena:getTopLeft()
		local w, h = arena:getBottomRight()
		w = w - x
		
		y = y + math.random(0, (h - y) - 32)
		h = 32
		
		local rect =  Rectangle(x, y, w, h)
		rect.layer = BATTLE_LAYERS.above_bullets
		rect.color = {1, 0, 0}
		rect.alpha = 0.75
		
		self.timer:tween(0.4, rect, {height = 0, y = rect.y + 16, alpha = 0.25}, 'in-cubic', function()
			local bullet = self:spawnBullet('tenna/static', x, y)
			bullet.physics.speed_x = 4
			bullet.physics.friction = -0.25
			self:spawnLaser()
		end)
		
		self:spawnObject(rect)
	end)
end

function MyWave:onStart()
	self:spawnLaser()
end

return MyWave