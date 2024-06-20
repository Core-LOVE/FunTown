local id = "knight"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Knight"

    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 33

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local yoffset = self.height * .8
	local xoffset = self.width * .5
    self.hitbox = {(self.width - xoffset) * 0.5, yoffset, xoffset, self.height - yoffset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "walk"
	
    self.animations = {
        ["battle"] = {"battle", .2, true},
        -- ["laugh"] = {"laugh", 0.15, true},
        -- ["run"] = {"run", 0.1, true},
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15,,true},
		-- ["spared"] = {"spared", 0.15, true},
	}	
	
    -- Sound to play when this actor speaks (optional)
    self.voice = "ralsei"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/knight"
	
    self.portrait_offset = {-15, 0}
end

return actor