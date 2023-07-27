local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = -1
    self.enemies = self:getAttackers()
end

function MyWave:onStart()

end

return MyWave