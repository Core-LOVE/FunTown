local actor, super = Class("kris", true)

function actor:init()
    super.init(self)
	
	self.animations["ballon"] = {"ballon", 4 / 30, true}
    self.animations["sword_jump_settle"]   = {"sword_jump_settle", 0.2, false}
    self.animations["sword_jump_up"]   = {"sword_jump_up", 0.2, true}
    self.animations["fall_sword"] = {"fall_sword", 1/5, true}
end

return actor