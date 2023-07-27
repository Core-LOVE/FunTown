local MyEvent, super = Class(Event)

function MyEvent:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

	local properties = data.properties or {}
	
	self.rotation = math.rad(properties.rotation or 0)
	self:setScale(2)
    self:setOrigin(0.5, 0.5)
    self:setSprite("objects/speaker", 0.25)
	
	local t = Timer()
	
	t:script(function(wait)
		while true do
			if Game.world:inBattle() then
				for _ = 1, 4 do
					local bullet = Game.world:spawnBullet('audiowave', data.center_x, data.center_y, self.rotation)
					wait(.15)
				end
				
				wait(.4)
			end
			
			wait()
		end
	end)
	
	self.timer = t
	self:addChild(t)
end

return MyEvent