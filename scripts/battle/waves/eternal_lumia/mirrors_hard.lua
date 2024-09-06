local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)
	
	self.arena_width = 80
	self.arena_height = self.arena_width

	self.time = 7.5
end

function MyWave:onStart()

end

return MyWave