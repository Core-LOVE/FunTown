local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)

    self.enemies = self:getAttackers()
	self.layer = BATTLE_LAYERS["above_arena"]
	
	self:setArenaSize(256, 142)	
	self:setArenaPosition(256, 172)

	self.time = 7.5
end

function MyWave:onStart()
	local arena = Game.battle.arena
	local x, y = arena:getTopRight()
	
	self:spawnBullet('novanna/big', x + 160, arena.y)
end

return MyWave