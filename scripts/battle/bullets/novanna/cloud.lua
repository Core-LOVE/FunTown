local id = "novanna/cloud"
local MyBullet, super = Class(Bullet, id)

local function sparkle(wave, x, y)
	for y = y, y + 32, 16 do
		for i = 1, 4 do
			local spr = Sprite("effects/sparkle", x + math.random(-24, 24), y + math.random(-4, 4))
			spr:setOrigin(.5, .5)
			spr:setScale(math.random(1, 3))
			spr.layer = BATTLE_LAYERS["above_arena"] + 100
			spr.physics.speed_x = math.random(-3, 3)
			spr.physics.speed_y = math.random(-3, 3)
			
			spr.graphics.spin = math.random() * .1
			spr:fadeOutAndRemove(math.random() * .42)
			wave:addChild(spr)
		end
	end
end

function MyBullet:init(x, y, size)
    super:init(self, x, y + 16)

	Assets.playSound("wing")
	
    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(0, 0, 64, 32)
	
	self.destroy_on_hit = false
	self.damage = 0
	self.tp = 0
	self.alpha = 0
	
	local t = Timer()
	
	t:tween(0.25, self, {alpha = 1, y = y}, 'out-sine', function()
		t:after(.1, function()
			Assets.playSound("rainbow")
			
			local arena = Game.battle.arena
			local arenaX, arenaY = arena:getTopLeft()
			local soul = Game.battle.soul
			
			local fx = -256
			
			if (self.soulX or soul.x) < arena.x then
				arenaX, arenaY = arena:getTopRight()
				fx = SCREEN_WIDTH
			end
			
			if soul.y > arena.y then
				arenaY = 240
			end
			
			local curve = love.math.newBezierCurve{
				x, y - 16,
				soul.x, soul.y,
				arenaX, arenaY - 152,
				fx + 96, SCREEN_HEIGHT,
			}
			
			local rainbow = {
				curve = curve,
				seg = 0.1,
				alpha = 1,
				bullets = {},
				distance = 0,
			}
			
			table.insert(self.wave.rainbows, rainbow)
			
			local time = 0.9
			
			t:tween(time, rainbow, {seg = 1}, 'in-out-sine', function()
				for k, bullet in ipairs(rainbow.bullets) do
					bullet:remove()
				end
					
				t:tween(.5, rainbow, {alpha = 0, distance = -1}, 'in-out-circ', function()
					t:tween(.36, self, {alpha = 0, y = self.y + 4, scale_x = 2.25}, 'in-out-sine', function()
						self:remove()
					end)
				end)
			end)
			
			t:during(time, function()
				for dy = 0, 20, 10 do
					for seg = rainbow.seg - 0.05, rainbow.seg + 0.05, 0.05 do
						if seg > 1 then
							seg = 1
						elseif seg < 0 then
							seg = 0
						end
						
						local x, y = rainbow.curve:evaluate(seg)
						
						local bullet = self.wave:spawnBullet('invisible', x, y + 12 + dy)
						table.insert(rainbow.bullets, bullet)
					end
				end
				
				local seg = rainbow.seg
				
				if seg > 1 then
					seg = 1
				end
				
				local x, y = rainbow.curve:evaluate(seg)
				sparkle(self.wave, x, y)
			end)
		end)
	end)
	
	self:addChild(t)
end

return MyBullet