local id = "rouxls"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Rouxls"

    -- Width and height for this actor, used to determine its center
    self.width = 24
    self.height = 55

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local yoffset = self.height * .8
	local xoffset = self.width * .5
    self.hitbox = {(self.width - xoffset) * 0.5, yoffset, xoffset, self.height - yoffset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.portrait_path = "face/dess"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-24, -16}
	
    self.animations = {
        ["idle"] = {"idle"},
		
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15,,true},
		-- ["spared"] = {"spared", 0.15, true},
	}	
	
    self.offsets = {
	}
end

function actor:preSetAnimation(sprite, anim, ...) 

end

return actor