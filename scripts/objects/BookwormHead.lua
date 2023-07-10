local MyObject, super = Class(Sprite)

local d = -1

function MyObject:init(x, y)
    super:init(self, "npcs/bookworm/head", x, y)
    -- self.animating = true
    -- self.anim_timer = 0
    -- self.anim_speed = 0.5
	
	d = -d
	
	self.speed = d * 0.25
	self.timer = 0
end

function MyObject:update()
	super:update(self)
	
	self.timer = self.timer + 0.1
	
	self.y = self.y + math.sin(self.timer) * self.speed
end
	
return MyObject