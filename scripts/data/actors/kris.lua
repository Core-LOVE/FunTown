local actor, super = Class("kris", true)

function actor:init()
    super.init(self)
	
	self.animations["ballon"] = {"ballon", 4 / 30, true}
end

return actor