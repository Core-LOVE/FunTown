local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	-- self.arena_height = 128
	-- self.arena_width = self.arena_height + self.arena_height
	
	self.time = 7.5
    self.enemies = self:getAttackers()
end

function MyWave:onStart()
	self.timer:script(function(wait)
		for k,enemy in ipairs(self:getAttackers()) do
			enemy:setAnimation('on')
			
			wait(.1)
			
			local sinDir = 1

			self.timer:every(.8, function()
				enemy:cam_flash()
				
				self.timer:script(function(wait)
					for i = 3, 1, -1 do
						local mult = (i * .75)

						local bullet = self:spawnBullet("lumia/bird", enemy.x - 8, enemy.y - (enemy.height) - 22)
						bullet.sinDir = sinDir
						bullet.movement = function()
							bullet.physics.speed = 5

							bullet.sinTimer = bullet.sinTimer or 0
							bullet.sinTimer = bullet.sinTimer + 1

							local sinSpeed = math.cos(bullet.sinTimer * .5) * (bullet.sinTimer / 7.5)
							bullet.y = bullet.y + (sinSpeed * (bullet.sinDir * mult))
						end

						sinDir = -sinDir
						wait(0.15)
					end
				end)
			end)
			
			wait(.1)
		end
	end)
end

function MyWave:onEnd(death)
	for k,enemy in ipairs(self:getAttackers()) do
		enemy:setAnimation('off')
	end
end

return MyWave