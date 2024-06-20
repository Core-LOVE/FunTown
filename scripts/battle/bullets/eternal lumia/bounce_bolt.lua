local id = "eternal lumia/bounce_bolt"
local MyBullet, super = Class(Bullet, id)

local function appear(self)
	self.sfx = Assets.playSound("l_thunder", .5, 2)
	
	local circle = Ellipse(self.x, self.y, 15)
	circle:setOrigin(.5)
	
	local t = Timer()

	t:tween(0.5, circle, {alpha = 0, width = circle.width * 2, height = circle.height * 2}, nil, function()
		circle:remove()
	end)
	
	circle:addChild(t)
	circle:setLayer(self.layer + 1)
	
	Game.battle:addChild(circle)
end

function MyBullet:init(x, y, rot, no_effect)
    super:init(self, x, y)

	local soul = Game.battle.soul

	self:setScale(1)
    self:setHitbox(6, 3, 12, 6)
	
	self.physics.match_rotation = true
	self.rotation = (rot ~= nil and rot) or math.atan2(soul.y - self.y, soul.x - self.x)
	
	self.physics.speed = 7.5
	self.tp = 0
	
	self.canHit = 0

	if not no_effect then
   		self:setSprite("bullets/" .. id, 4 / 60, true)
		appear(self)
	end
end

function MyBullet:onShieldHit(soul)
	if self.canHit > 8 then
		return true
	end

	self:setSprite("bullets/eternal lumia/bolt", 4 / 60, true)

	local speed = self.physics.speed
	self.physics.speed = -speed

	local t = Timer()

	t:tween(0.5, self.physics, {speed = speed}, 'in-sine', function()
		t:remove()
	end)

	self:addChild(t)
end

function MyBullet:update(dt)
	if self.canHit > 0 then
		self.canHit = self.canHit + 1
	end

	super.update(self, dt)
end

return MyBullet