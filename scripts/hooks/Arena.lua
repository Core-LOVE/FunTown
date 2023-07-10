local Arena, super = Class('Arena')

function Arena:init(x, y, shape)
	super.init(self, x, y, shape)
	
	self.canHurt = false
	self.damage = 15
	self.inv_timer = (4/3)
	self.damage_while_inv = false
end

function Arena:getTarget()
    -- return self.attacker and self.attacker.current_target or "ANY"
	return "ANY"
end

function Arena:getDamage()
    -- return self.damage or (self.attacker and self.attacker.attack * 5) or 0
	return self.damage
end

function Arena:onDamage(soul)
    local damage = self:getDamage()
	
    if damage and damage > 0 then
        local battlers = Game.battle:hurt(damage, false, self:getTarget())
        soul.inv_timer = self.inv_timer
        soul:onDamage(self, damage)
        return battlers
    end
	
    return {}
end

function Arena:onCollide(soul)
	if not self.canHurt then return end
	
	if soul == Game.battle.soul then 
		if (not self.damage_while_inv and soul.inv_timer == 0) or (self.damage_while_inv) then
			self:onDamage(soul) 
		end
	end
end

return Arena