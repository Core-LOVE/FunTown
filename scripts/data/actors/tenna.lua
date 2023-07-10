local id = "tenna"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Tenna C."

    -- Width and height for this actor, used to determine its center
    self.width = 53
    self.height = 84

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local yoffset = self.height * .75
	local xoffset = self.width * .5
    self.hitbox = {(self.width - xoffset) * 0.5, yoffset, xoffset, self.height - yoffset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.animations = {
        ["idle"] = {"tenna", 0.15, true},
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15, true},
		-- ["spared"] = {"spared", 0.15, true},
		["laugh"] = {"laugh", 0.2, true, frames = {1, 0}},
		["tpose"] = {"tpose", 0.15, true, frames = {2, 1, 0, 4, 3}},
		
        ["battle/idle"] = {"battle/idle", 0.15, true},
	}	
	
	self.timer = 0
end

return actor