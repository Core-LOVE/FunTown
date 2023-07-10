local id = "bookworm"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Bookworm"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 36

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local offset = self.height * .5
    self.hitbox = {0, offset, self.width, self.height - offset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
end

function actor:createSprite()
    return BookwormActor(self)
end

return actor