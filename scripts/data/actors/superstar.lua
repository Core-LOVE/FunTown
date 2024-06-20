local id = "superstar"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "SuperStar"

    -- Width and height for this actor, used to determine its center
    self.width = 48
    self.height = 48

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local offset = self.height * .75
    self.hitbox = {0, offset, self.width, self.height - offset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.animations = {
        ["idle"] = {"idle", 0.09, true, frames = {1, 1, 1, 2, 2, 3, 4}},
        ["hurt"] = {"hurt", 0.5, true},
		["spared"] = {"spared", 0.15, true},
	}	
end

return actor