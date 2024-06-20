local MyWave, super = Class(Wave)

local shape = {}

do
	local radius = 142 / 3
	
	for angle = 0, 360, 25 do
		local angle = math.rad(angle)
		
		local x = math.cos(angle) * radius
		local y = math.sin(angle) * radius
		
		table.insert(shape, {x, y})
	end
end

function MyWave:init()
	super:init(self)
	
	self.time = -1
	
	self:setArenaShape(unpack(shape))
	self:setArenaOffset(0, 90)
end

function MyWave:onStart()
	local arena = Game.battle.arena
	local x, y = arena:getTopLeft()

	self.hand = self:spawnBullet("eternal lumia/hand", x, y - 142)
	self._t = 0
end

function MyWave:draw()
	super.draw(self)
	
	local hand = self.hand
	
	if not hand then return end
	
	local arena = Game.battle.arena
	local x, y = arena:getTopLeft()
	x = arena:getCenter()
	
	love.graphics.setColor(arena.color)
	love.graphics.setLineWidth(2)
	love.graphics.line(hand.x + 26, hand.y + 20, x, y)
end

function MyWave:update()
	super.update(self)
	
	local hand = self.hand
	
	if not hand then return end
	
	self._t = self._t + 0.05 * DTMULT
	
	local arena = Game.battle.arena
	local soul = Game.battle.soul
	
	local t = self._t
	
	local radius = 4

	local dx = math.cos(t) * radius
	local dy = math.sin(-t * 2) * (radius * .5)
	
	arena.x = arena.x + dx
	arena.y = arena.y + dy
	soul.x = soul.x + dx
	soul.y = soul.y + dy
	
	hand.scale_y = 2 + math.abs(dy) * .05
end

return MyWave