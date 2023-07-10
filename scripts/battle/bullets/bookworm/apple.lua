local id = "bookworm/apple"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

	self.name = "Apple"
    self:setSprite("bullets/" .. id)
	
    self:setHitbox(0, 0, 16, 16)
	
	self.tp = 0
	self.damage = 0
end

function MyBullet:remove(bool)
	if bool == "collision" then return super:remove(self) end

	for _, obj in ipairs(self.wave.bullets) do
		if obj.name == "Apple" and obj ~= self then
			return super:remove(self)
		end
	end
		
	self.wave:spawnApple()
	super:remove(self)
end

function MyBullet:onCollide(soul)
	local member = Game.battle.party[math.random(1, #Game.battle.party)]
	member:heal(16)
	
	self:remove()
end

return MyBullet