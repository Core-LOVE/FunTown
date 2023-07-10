local MyObject, super = Class(Bullet)

function MyObject:postInit()
	self:setColor(66 / 255, 1, 1)
    self.layer = BATTLE_LAYERS["soul"] - 1
end

function MyObject:init(x, y, texture)
	super.init(self, x, y, texture)
	self:postInit()
end

local function condition(soul)
	return (soul.moving_x ~= 0 or soul.moving_y ~= 0)
end

function MyObject:onCollide(soul)
	if condition(soul) then
		return super.onCollide(self, soul)
	end
end

function MyObject:update()
	super.update(self)
	
	local soul = Game.battle.soul
	
	if not condition(soul) then
		self.grazed = true
	end 
end

return MyObject
