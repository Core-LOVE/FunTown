local id = "drawgon"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Drawgon"

    -- Width and height for this actor, used to determine its center
    self.width = 44
    self.height = 46

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local offset = self.height * .5
    self.hitbox = {0, offset, self.width, self.height - offset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.animations = {
        ["idle"] = {"drawgon", 0.15, true},
        ["hurt"] = {"hurt", 0.5, true},
        ["angry"] = {"angry", 0.15, true},
		["spared"] = {"spared", 0.15, true},
	}	
	
	self.timer = 0
end

return actor