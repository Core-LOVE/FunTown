local id = "luna/cloud"
local MyBullet, super = Class(Bullet, id)

local function bouncing(self)
	self.timer:tween(0.5, self, {radius = 18, y = self.y - 12}, 'out-sine', function()
		self.timer:tween(0.5, self, {radius = 24, y = self.y + 12}, 'in-sine', function()
			bouncing(self)
		end)
	end)
	
	self.timer:tween(0.5, self, {add_rad = 6}, 'out-sine', function()
		self.timer:tween(0.5, self, {add_rad = 0}, 'in-sine', function()
			-- bouncing(self)
		end)
	end)
end

function MyBullet:init(x, y)
    super:init(self, x, y)

    -- self:setSprite("bullets/" .. id)
	
    self:setHitbox(0, 0, 6, 6)
	
	self.radius = 4
	self.add_rad = 0
	
	-- self.tp = 0
	self.damage = 0
	self.destroy_on_hit = false
	
	self.timer = Timer()
	-- self.timer:tween(0.4, self, {radius = 24}, 'out-circ')
	-- self.timer:tween(0.7, self, {x = 96, }, 'out-sine')
	self.timer:tween(0.5, self, {x = 96, y = self.y - math.random(80, 96)}, 'out-circ', function()
		self.damage = nil
		
		local enemy = self.enemy
		if enemy then enemy:setAnimation('idle') end
		
		self.timer:tween(0.4, self, {radius = 24}, 'out-circ', function()
			self.physics.speed_x = math.random(5, 6)
			local t = 9 - (self.physics.speed_x * 1.25)
			
			bouncing(self)
			
			self.timer:script(function(wait)
				wait(t)
				
				self.timer:tween(0.5, self, {alpha = 0, color = {0, 0, 0}}, nil, function()
					self.wave:shoot()
					
					self:remove()
				end)
			end)
			
			self.timer:script(function(wait)
				while true do
					self.timer:tween(0.5 * .5, self, {color = {0.5, 0.5, 0.5}})
					
					wait(0.5)
					
					self.timer:tween(0.5, self, {color = {1, 1, 1}}, 'out-sine')
					
					for _ = 1, 8 do
						for i = 1, math.random(1, 3) do
							local rain = self.wave:spawnBullet('luna/rain', self.x + math.random(-24, 64), self.y)
							
							rain.scale_x = math.random()
							if rain.scale_x < 0.5 then
								rain.scale_x = 0.5
							end
							
							rain.physics.speed_y = math.random(2, 6)
							rain.physics.speed_x = math.random(-2, 1)
						end
						
						local w = math.random(1, 2) * 0.05
						
						wait(w)
					end
				end
			end)
		end)
	end)
	
	self:addChild(self.timer)
end

function MyBullet:draw()
	super.draw(self)
	
	local add_rad = (self.radius * .5) + self.add_rad
	
	love.graphics.circle("fill", 8, 0, self.radius)
	
	if add_rad > 2 then
		love.graphics.circle("fill", -16, 3, add_rad * 0.9)
		love.graphics.circle("fill", 24, 0, add_rad)
	end
end

return MyBullet