local id = "lumia/jackbox"
local MyBullet, super = Class(Bullet, id)

function MyBullet:initSprites()
	self.parts = {}

	local part = Sprite("bullets/" .. id .. "/jack", 4, -2)
	part:setScaleOrigin(0.5, 1)

	self.parts.jack = part
	self:addChild(part)

	local part = Sprite("bullets/" .. id .. "/spring", 4, -2 + 12)
	part:setScaleOrigin(0.5, 0)
	part:setScale(1, 0)

	self.parts.spring = part
	self:addChild(part)
end

function MyBullet:spawnBullets()
	local soul = Game.battle.soul

	local sx, sy = self.x + 8, self.y - 48
	local dx, dy = soul.x, soul.y

	for i = 1, 3 do
		local bullet = self.wave:spawnBullet("diamond", sx, sy, Utils.angle(dx, dy, sx, sy), (i * 2) + 1)
		bullet:setScale(0)

		local scale = (i / 3) + 1

		self.timer:tween(0.25, bullet, {scale_x = i, scale_y = i}, 'out-cubic', function()
			self.timer:tween(0.25, bullet, {scale_x = scale, scale_y = scale}, 'out-back')
		end)
	end
end

function MyBullet:onWaveSpawn(wave)
	self.wave = wave
end

function MyBullet:init(x, y, rot)
    super:init(self, x, y)

    Assets.playSound("noise")

    self:initSprites()
    self:setSprite("bullets/" .. id .. "/box", 3 / 30, true)

    self:setHitbox(0, 0, 32, 32)
    self:setScale(1, 0)
    self:setScaleOrigin(0.5, 1)

    self.rotation = math.rad(22.5)

    self.timer = Timer()
    self:addChild(self.timer)

	self.timer:tween(0.25, self, {rotation = math.rad(0)}, 'in-bounce')

	self.timer:tween(0.25, self, {scale_y = 3}, 'out-cubic', function()
	    self.timer:tween(0.25, self, {scale_y = 2, scale_x = 2}, 'out-back')
    end)

    self.timer:after(0.75, function()
    	local part = self.parts.jack
    	part.scale_y = 0.5

    	self.rotation = math.rad(22.5 / 2)
    	self:shake(2)
		self.timer:tween(0.25, self, {rotation = math.rad(0)}, 'in-bounce')

		self:spawnBullets()

		Assets.playSound("noise")
		Assets.playSound("boing")

    	self.timer:tween(0.5, self.parts.spring, {scale_y = 1}, 'out-back')
    	self.timer:tween(0.5, part, {y = part.y - 32, scale_y = 1}, 'out-back')

    	self.timer:after(0.75, function()
	    	self.rotation = math.rad(-22.5 / 2)
	    	self:shake(2)

			self.timer:tween(0.25, self, {rotation = math.rad(0), scale_y = 0}, 'in-bounce', function()
				self:remove()
			end)
    	end)
    end)
end

function MyBullet:update()
	super.update(self)

	local jack = self.parts.jack

	self.parts.spring.y = jack.y + 24
end

return MyBullet