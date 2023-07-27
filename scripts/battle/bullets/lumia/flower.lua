local id = "lumia/flower"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id .. "_petals", 4 / 60, true)
	
    self:setHitbox(0, 0, 71, 16)
	
	self.graphics.spin = 0.2
	
	local base = Sprite("bullets/" .. id .. "_base", x - 71, y - 71)
	base:setScale(2)
	base.layer = self.layer + 1
	self.base = base
	
	Game.battle:addChild(base)
	
	local t = Timer()
	
	t:every(.35, function()
		local bullet = self.wave:spawnBullet('lumia/petal', self.x - 20, self.y + math.random(-71, 71))
		bullet.physics.speed_x = -math.random(5, 8)
		bullet.graphics.spin = bullet.physics.speed_x / 24
	end)
	
	t:script(function(wait)
		while true do
			local effect = Sprite("bullets/" .. id .. "_petals", self.x, self.y)
			effect:setOrigin(.5, .5)
			effect.rotation = self.rotation
			effect.graphics.spin = self.graphics.spin
			effect:setScale(2)
			effect.alpha = 0.25
			effect.layer = BATTLE_LAYERS["above_arena"]
			t:tween(.5, effect, {alpha = 0, x = effect.x - 32}, 'in-out-sine', function()
				effect:remove()
			end)
			
			Game.battle:addChild(effect)
			
			for i = 1, 2 do
				local effect = Sprite("effects/wind", self.x - 71, self.y + math.random(-71, 71))
				effect.scale_x = math.random(100, 175) / 100
				effect.physics.speed_x = -(effect.scale_x * 2) * 1.5
				effect.layer = BATTLE_LAYERS["above_arena"]
				effect.alpha = math.random(1, 4) * .5
				
				t:tween(.5, effect, {alpha = 0, x = effect.x - 320, scale_x = 0.25}, 'in-out-sine', function()
					effect:remove()
				end)
				
				Game.battle:addChild(effect)
				
				wait(.05)
			end
			
			wait(.125)
		end
	end)
	
	self:addChild(t)
end

function MyBullet:remove(...)
	self.base:remove()
	
	super.remove(self, ...)
end

return MyBullet