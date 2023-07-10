local actor, super = Class(Actor, "novanna")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "Novanna"

    -- Width and height for this actor, used to determine its center
    self.width = 28
    self.height = 42

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local offset = self.height * .5
    self.hitbox = {0, offset, self.width, self.height - offset}

    -- Color for this actor used in outline areas (optional, defaults to red)
    -- self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/novanna"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "novanna"
    -- self.indent_string = "*** "
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/novanna"
    self.portrait_offset = {-12, 4}
    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- ["laugh"] = {"lumia_laugh", 0.15, true},
        -- ["cameraOn"] = {"lumia_camera", 0.2, false},
        -- ["cameraOff"] = {"lumia_camera", 0.2, false, frames = {3, 2, 1}},
		-- ["hurt"] = {"lumia_hurt", 0.25, true},
		-- ["defeat"] = {"lumia_sad", 0.25, true},
		-- ["battle"] = {nil, 0.25, true, }
        -- ["hurt"] = {"starwalker_shoot_1", 0.5, true},
        -- ["shoot"] = {"starwalker_wings", 0.25, true, next="wings", frames={5,4,3,2}},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- ["starwalker"] = {0, 0},
        -- ["starwalker_wings"] = {-6, -4},
        -- ["starwalker_shoot_1"] = {0, 0},
        -- ["starwalker_shoot_2"] = {-5, 0},
    }
end

return actor