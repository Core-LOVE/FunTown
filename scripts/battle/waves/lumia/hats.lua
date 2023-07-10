local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	-- self.arena_height = 128
	-- self.arena_width = self.arena_height + self.arena_height
	
	self.time = 1
    self.enemies = self:getAttackers()
end

function MyWave:onStart()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy:setAnimation('on')
	end
end

function MyWave:onEnd(death)
	for k,enemy in ipairs(self:getAttackers()) do
		enemy:setAnimation('off')
	end
end

return MyWave