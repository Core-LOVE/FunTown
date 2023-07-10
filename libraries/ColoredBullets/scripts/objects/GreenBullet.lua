local MyObject, super = Class(Bullet)

function MyObject:postInit()
	self:setColor(71 / 255, 1, 0)
    self.layer = BATTLE_LAYERS["soul"] - 1
	self.tp = 0
	self.damage = 0
	self.heal = 15
end

function MyObject:init(x, y, texture)
	super.init(self, x, y, texture)
	self:postInit()
end

function MyObject:onCollide(soul)
	local member = Utils.pick(Game.battle.party)
	member:heal(self.heal)
	
	self:remove()
end

return MyObject
