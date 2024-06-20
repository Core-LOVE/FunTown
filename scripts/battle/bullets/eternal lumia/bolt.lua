local id = "eternal lumia/bolt"
local MyBullet, super = Class(Bullet, id)

local function appear(self)
	self.sfx = Assets.playSound("l_thunder", .5, 2)
	
	local x,y = self:getScreenPos()
	local circle = Ellipse(self.x, self.y, 15)
	circle:setOrigin(.5)
	circle.parallax_x = 0
	circle.parallax_y = 0

	local t = Timer()

	t:tween(0.5, circle, {alpha = 0, width = circle.width * 2, height = circle.height * 2}, nil, function()
		circle:remove()
	end)
	
	circle:addChild(t)
	circle:setLayer(self.layer + 1)
	
	Game.battle:addChild(circle)
end

function MyBullet:init(x, y, rot, no_effect, no_remove)
    super:init(self, x, y)

	local soul = Game.battle.soul

	self:setScale(1)
    self:setHitbox(6, 3, 12, 6)
	
	self.physics.match_rotation = true
	self.rotation = (rot ~= nil and rot) or math.atan2(soul.y - self.y, soul.x - self.x)
	
	self.physics.speed = 7.5
	self.tp = 0
	
	if not no_effect then
   		self:setSprite("bullets/" .. id, 4 / 60, true)
		appear(self)
	end

	if no_remove then self.remove_offscreen = false end
end

return MyBullet