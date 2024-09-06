local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = -1
end

return MyWave