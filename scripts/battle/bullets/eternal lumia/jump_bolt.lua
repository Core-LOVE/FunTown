local id = "eternal lumia/jump_bolt"
local MyBullet, super = Class(Bullet, id)

function MyBullet:setSpeed(val)
	self.physics.speed_x = val
end

local function calcDistance(x1, y1, x2, y2)
	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt(dx * dx + dy * dy)
end

local faster = false

function MyBullet:init(x, y, angle, speed)
	local angle = angle or 0
    super:init(self, x, y)

	self.damage = 80
	
	self:setSprite("bullets/eternal lumia/bolt")

    self:setHitbox(0, 4, 13, 24)
    self:setScale(1)

    self.physics.speed_x = -4

    if faster then
    	self.physics.speed_x = -6
    end

    faster = not faster
	self.maxHeight = -8.25
	
	if math.random() > 0.5 then
		self.high = true
	end
	
	-- self.despawnTimer = 100
	
	self.tp = 0

	self.timer = Timer()

	self:addChild(self.timer)

	self.alpha = 0
	self.timer:tween(0.5, self, {alpha = 1})
end

local y = 308 - 48

local function onCollide(self)
	Assets.playSound("l_film_1", 0.5, 1.5)

	self:setScale(2)
	self.timer:tween(0.32, self, {scale_x = 1, scale_y = 1}, 'in-bounce')

	Assets.playSound("l_thunder", .25, 5)
	
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

function MyBullet:update()
    super:update(self)
	
	self.rotation = math.atan2(self.physics.speed_y, self.physics.speed_x)
	self.physics.speed_y = self.physics.speed_y + 0.5
	
	local height = self.maxHeight
	if self.high then
		height = height * 1.32
	end
	
	local dy = 308 - 12

	if self.y > y then
		onCollide(self)

		self.y = y
		self.physics.speed_y = height
	end
	
	-- if self.x < -100 or self.y < -100 or self.x > SCREEN_WIDTH + 100 or self.y > SCREEN_HEIGHT + 100 then
	-- 	self.despawnTimer = self.despawnTimer - 1
	-- end
	
	-- if self.despawnTimer <= 0 then
	-- 	self:remove()
	-- end
end

return MyBullet