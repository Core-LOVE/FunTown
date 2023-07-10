local id = "sunny"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Sunny"

    -- Width and height for this actor, used to determine its center
    self.width = 42
    self.height = 61

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local offset = self.height * .75
	local xoffset = self.width * .75
	
    self.hitbox = {xoffset * 1.1, offset, self.width - (xoffset * 2), self.height - offset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.animations = {
        ["idle"] = {"idle", 0.15, true},
		["shoot"] = {"shoots", 0.1, false, {0, 0, 1, 2, 3}},
	}	
	
    -- self.offsets = {
        -- ["play"] = {-18, 0},
        -- ["prepare"] = {0, -8},
		-- ["scream"] = {9, -7},
		-- ["hurt"] = {9, -7},
	-- }
end

return actor