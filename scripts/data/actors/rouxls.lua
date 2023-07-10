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
        ["idle"] = {"walk/down", frames={1}},
		
        ["sit"] = {"sit/sit", 0.075, next = "play/start"},
		["play/start"] = {"play/start", 0.15, next = "play/pull"},
		["play/pull"] = {"play/pull", 0.2, next = "play/out", frames = {1, 2, 1, 2}},
		["play/out"] = {"play/out", 0.075, next = "play", frames = {1, 2, 3, 4, 4, 4, 4}},
		
		["play"] = {"play/play", function(sprite, wait)
            while true do
				Kristal.console:log(Game.world.music.source:getRolloff())
                wait()
            end
        end},
		
		["playing"] = {"play/play", 0.075, true},
			
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15,,true},
		-- ["spared"] = {"spared", 0.15, true},
	}	
	
    self.offsets = {
        ["sit/sit"] = {-15, 0},
		["play/start"] = {-15, 0},
		["play/pull"] = {-15, 0},	
		["play/out"] = {-15, 0},
		["play/play"] = {-15, 0},
	}
end

function actor:preSetAnimation(sprite, anim, ...) 
	 if anim == "sit" then
		Assets.playSound("wing")
	 elseif anim == "play/pull" then
		sprite:shake(2)
		Assets.playSound("noise")
	 elseif anim == "play/out" then
		Assets.playSound("wing")
		sprite:shake(4)
	 elseif anim == "play" then
		Game.world.music:play("findher")
	 end
end


return actor