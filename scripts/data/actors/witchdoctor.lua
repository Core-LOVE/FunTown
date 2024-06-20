local id = "witchdoctor"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Witchdoctor"

    -- Width and height for this actor, used to determine its center
    self.width = 29
    self.height = 60

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
        ["idle"] = {"idle", 0.15, true},
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15, true},
		-- ["spared"] = {"spared", 0.15, true},
	}	
	
    self.portrait_path = "face/witchdoctor"
    self.portrait_offset = {-6, -4}
    self.voice = "witchdoctor"
	
	self.timer = 0
end

return actor