local id = "eternal lumia/dbolt"
local texture = "eternal lumia/bolt"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, rot, top, bottom)
    super:init(self, x, y)

	local soul = Game.battle.soul

	self:setScale(0.5)
	self.color = {0.5, 0.5, 0.5}
    self:setHitbox(6, 3, 12, 6)
	
	self.physics.match_rotation = true
	self.rotation = (rot ~= nil and rot) or math.atan2(soul.y - self.y, soul.x - self.x)
	
	self.physics.speed = 6.5
	self.physics.friction = -0.05
	self.tp = 0
	
	self.top = top + 16
	self.bottom = bottom - 16
	self.left = 0

   	self:setSprite("bullets/" .. texture, 4 / 60, true)

   	local t = Timer()

   	t:tween(0.5, self, {scale_x = 1, scale_y = 1, color = {1, 1, 1}}, 'in-sine')

   	self:addChild(t)
   	self.remove_offscreen = false

   	self.collideLeft = false
   	self.canCollide = 0
end

local rotate = 90

local function effect(self)
	self.sfx = Assets.playSound("l_thunder", .5, 4)
	
	local circle = Ellipse(self.x, self.y, 8)
	circle:setOrigin(.5)
	
	local t = Timer()

	t:tween(0.25, circle, {alpha = 0, width = circle.width * 2, height = circle.height * 2}, nil, function()
		circle:remove()
	end)
	
	circle:addChild(t)
	circle:setLayer(self.layer + 1)
	
	Game.battle:addChild(circle)
end

local function properRotate(self, rotate)
	local rotate = rotate

	if self.collideLeft then
		rotate = -rotate
	end

	self.rotation = self.rotation + math.rad(rotate)
end

function MyBullet:update(...)
	if (self.x - 24  <= self.left) then
		effect(self)
   		self.collideLeft = true

		self.rotation = math.rad(180) - self.rotation
		self.x = self.left + 24
	end 

	if (self.x + 24 > SCREEN_WIDTH) then
		return self:remove()
	end

	if self.canCollide > 0 then
		self.canCollide = self.canCollide - 1
		return super.update(self, ...)
	end 

	if ((self.y > self.bottom) or (self.y < self.top)) then
		effect(self)

		if (self.y > self.bottom) then
			properRotate(self, rotate)
			self.y = self.bottom - 7
		else
			properRotate(self, -rotate)
			self.y = self.top + 7
		end

		self.canCollide = 8
	end

	super.update(self, ...)
end

return MyBullet