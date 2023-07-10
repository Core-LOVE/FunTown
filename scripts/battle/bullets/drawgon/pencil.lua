local id = "drawgon/pencil"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(0, 0, 16, 16)
	
	self.physics.gravity = 0.8
end

function MyBullet:update()
	super:update(self)
	
	local arena = Game.battle.arena
	
	if self.y > arena:getBottom() then
		self:remove(true)
	end
end

function MyBullet:remove(spawn)
	if spawn == nil then return super:remove(self) end
	
	local arena = Game.battle.arena
	local x, y = self.x, arena:getBottom() - 16
	
	local timer = Timer()
	self.wave:addChild(timer)
	
	timer:script(function(wait)
		self.wave:spawnBullet("drawgon/person", x, y)
		wait(0.1)
		self.wave:spawnBullet("drawgon/person", x - 32, y)
		self.wave:spawnBullet("drawgon/person", x + 32, y)
		wait(0.1)
		self.wave:spawnBullet("drawgon/person", x - 64, y)
		self.wave:spawnBullet("drawgon/person", x + 64, y)	
	end)

	super:remove(self)
end

return MyBullet