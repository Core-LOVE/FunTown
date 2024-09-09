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
	
	self.time = 10
	
	self:setArenaShape(unpack(shape))
	self:setArenaOffset(0, 90)
end


local function randomWithStep(first, last, step)
    local maxSteps = math.floor((last-first)/step)
    return first + step * math.random(0, maxSteps)
end

local start_x = 16
local end_x = 96

local function spawnDiamond(self)
	local x = randomWithStep(start_x, end_x, 32) + 16
	local y = SCREEN_HEIGHT - randomWithStep(start_x, 360, 32) - 32

	if math.random() > 0.5 then
		x = SCREEN_WIDTH - randomWithStep(start_x, end_x, 32) - 16
	end

	local bullet = self:spawnBullet("eternal lumia/big_diamond", x, y)
	bullet.slower = true
end

function MyWave:onStart()
	local arena = Game.battle.arena
	local x, y = arena:getTopLeft()

	self.hand = self:spawnBullet("eternal lumia/hand", x, y - 142)
	self.hand:setScale(0.1)

	self.timer:tween(0.75, self.hand, {scale_x = 2, scale_y = 2}, 'out-sine', function()
		spawnDiamond(self)

		self.timer:every(0.72, function()
			spawnDiamond(self)
		end)
	end)

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
	love.graphics.setLineWidth(self.hand.scale_x)
	love.graphics.line(hand.x + 7, hand.y + 36, x, y)
end

function MyWave:update()
	super.update(self)
	
	local hand = self.hand
	
	if not hand then return end
	
	self._t = self._t + 0.075 * DTMULT
	
	local arena = Game.battle.arena
	local soul = Game.battle.soul
	
	local t = self._t
	
	local radius = 3

	local dx = math.cos(t) * radius
	local dy = math.sin(-t * 2) * (radius * .5)
	
	arena.x = arena.x + dx
	arena.y = arena.y + dy
	soul.x = soul.x + dx
	soul.y = soul.y + dy
	
	hand.scale_y = 2 + math.abs(dy) * .05
	hand.rotation = math.atan2(math.abs(dx), math.abs(dy)) + math.rad(90)
	hand.rotation = hand.rotation * .1
end

return MyWave