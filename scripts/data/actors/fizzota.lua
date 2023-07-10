local id = "fizzota"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Fizzota"

    -- Width and height for this actor, used to determine its center
    self.width = 32
    self.height = 78

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local yoffset = self.height * .8
	local xoffset = self.width * .5
    self.hitbox = {(self.width - xoffset) * 0.5, yoffset, xoffset, self.height - yoffset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.animations = {
        ["idle"] = {"idle", 0.0665, true},
		
        ["battle/idle"] = {"battle/idle", 0.0665, true},
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15,,true},
		-- ["spared"] = {"spared", 0.15, true},
	}	
end

return actor