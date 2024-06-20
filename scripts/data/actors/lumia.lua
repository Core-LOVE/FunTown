local id = "lumia"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = "Lumia"

    -- Width and height for this actor, used to determine its center
    self.width = 31
    self.height = 50

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local yoffset = self.height * .8
	local xoffset = self.width * .5
    self.hitbox = {(self.width - xoffset) * 0.5, yoffset, xoffset, self.height - yoffset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
	self.voice = id
	
    self.animations = {
        ["idle"] = {"idle"},
		
        ["battle/idle"] = {"battle/idle", 0.075, true},
		["dark/idle"] = {"dark/idle", 0.15, true},
		
		["on"] = {"on/on", 0.075, false},
		["off"] = {"off/off", 0.075, false, next = 'battle/idle'},
		
		["hurt"] = {"hurt", 0.1, true},
		["badlyhurt"] = {"badlyhurt", 0.1, true},
        -- ["hurt"] = {"hurt", 0.5, true},
        -- ["angry"] = {"angry", 0.15,,true},
		-- ["spared"] = {"spared", 0.15, true},
	}	
end

function actor:createSprite()
	local sprite = ActorSprite(self)
	
	Utils.hook(sprite, 'setAnimation', function(orig, self, anim, ...)
		local voicePitch = sprite.voicePitch or 1
		
		if anim == 'hurt' and voicePitch >= 1.5 then
			Assets.playSound("chirp", 1, 0.96)
			Assets.playSound("lumia ouch", 1, 0.9)
			
			return self:setAnimation('badlyhurt')
		end
		
		return orig(self, anim, ...)
	end)
	
	return sprite
end

function actor:preSetAnimation(sprite, anim, ...) 
	 if anim == "hurt" then
		local timer = Timer()
		
		Assets.playSound("lumia ouch", 1, sprite.voicePitch or 1)
		
		timer:script(function(wait)
			sprite.voicePitch = sprite.voicePitch or 1
			sprite.voicePitch = sprite.voicePitch + 0.25
			wait(2)
			sprite.voicePitch = nil
			timer:remove()
		end)
		
		sprite:addChild(timer)
	 end
end

return actor