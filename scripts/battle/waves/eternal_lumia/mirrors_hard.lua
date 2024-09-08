local MyWave, super = Class(Wave)

local mask_shader = love.graphics.newShader[[
   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).a == 0) {
         // a discarded pixel wont be applied as the stencil.
         discard;
      }
      return vec4(1.0);
   }
]]

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width

	self.shadow_alpha = 0
	self.lights_y = -128
	self.lights_texture = Assets.getTexture("battle/eternal lumia/light")
	self.lights = true

	self:setLayer(BATTLE_LAYERS.top)
	self.stencilFunc = function()
		love.graphics.setShader(mask_shader)
		love.graphics.draw(self.lights_texture, 128, self.lights_y, 0, 1.5, 1.5)
		love.graphics.draw(self.lights_texture, SCREEN_WIDTH - 220, self.lights_y, 0, 1.5, 1.5)
		love.graphics.setShader()

		local soul = Game.battle.soul

		love.graphics.circle("fill", soul.x, soul.y, 60)

		love.graphics.circle("fill", 128 + 47, self.lights_y + 160, 32)
		love.graphics.circle("fill", (SCREEN_WIDTH - 220) + 47, self.lights_y + 160, 32)
		love.graphics.circle("fill", soul.x, self.lights_y + 272, 20)
		love.graphics.circle("fill", soul.x, 24, 20)

		love.graphics.rectangle("fill", 0, SCREEN_HEIGHT - 155, SCREEN_WIDTH, 155)
	end

	self.time = -1
end

local function spawnBolt(self, x, y)
	return self:spawnBullet("eternal lumia/bolt", x, y, nil, nil, nil, true)
end

local function randomWithStep(first, last, stepSize)
    local maxSteps = math.floor((last-first)/stepSize)
    return first + stepSize * math.random(0, maxSteps)
end

function MyWave:onStart()
	Assets.playSound("noise")

	self.timer:tween(0.5, self, {shadow_alpha = 0.98, lights_y = 0}, 'in-out-sine')
	self.timer:after(7.5, function()
		self.lights = false

		Assets.playSound("noise")

		self.timer:tween(0.75, self, {shadow_alpha = 0, lights_y = -128}, 'out-sine', function()
			self.time = 0
			Game.battle.wave_timer = 0
		end)
	end)

	self.timer:script(function(wait)
		local soul = Game.battle.soul

		local old_angle = 0
		local angle = 0
		local radius = 160

		local amount = 6
		local delay = 0.125
		
		wait(0.5)

		while self.lights do
			for _ = 1, amount do
				-- Assets.playSound("l_thunder", .5, 2)

				angle = randomWithStep(0, 360, 90)

				while (angle == old_angle) do
					angle = randomWithStep(0, 360, 90)
				end

				old_angle = angle
				
				for _ = 1, 3 do
					local angle = math.rad(angle + math.random(-8, 8))
					local x = soul.x + (math.cos(angle) * radius) + math.random(-16, 16)
					local y = soul.y + (math.sin(angle) * radius) + math.random(-16, 16)

					local bolt = spawnBolt(self, x, y)
					bolt.physics.speed = bolt.physics.speed * .75
					-- bolt.sfx:stop()

					wait(0.15)
				end

				wait(delay)
			end

			wait(0.25)
		end
	end)
end

function MyWave:draw()
	love.graphics.draw(self.lights_texture, 128, self.lights_y, 0, 1.5, 1.5)
	love.graphics.draw(self.lights_texture, SCREEN_WIDTH - 220, self.lights_y, 0, 1.5, 1.5)

	love.graphics.push('all')

	love.graphics.stencil(self.stencilFunc, "replace", 1, false)
	love.graphics.setStencilTest("lequal", 0)

	love.graphics.setColor(0, 0, 0, self.shadow_alpha)
	love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

	love.graphics.setStencilTest()
	love.graphics.pop()

	super.draw(self)
end

return MyWave