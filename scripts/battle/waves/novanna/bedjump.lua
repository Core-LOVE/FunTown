local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = -1
    self.enemy = self:getAttackers()[1]
	
	self:setArenaSize(160, 96)
end

function MyWave:onStart()

end

return MyWave