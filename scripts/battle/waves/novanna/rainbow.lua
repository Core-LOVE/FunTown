local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)

    self.enemies = self:getAttackers()
	self.layer = BATTLE_LAYERS["above_arena"]
	
	self.time = 7
	self.rainbows = {}
end

function MyWave:spawnRainbow()
	local arena = Game.battle.arena
	local soul = Game.battle.soul
	
	local x = soul.x - 256
	
	if soul.x < arena.x then
		x = soul.x + 256
	end
		
	local bullet = self:spawnBullet("novanna/cloud", x, arena.y + math.random(64, 96))
	bullet.wave = self
	bullet.soulX = x
end

function MyWave:onStart()
	local arena = Game.battle.arena
	local soul = Game.battle.soul
	local x, y = arena:getBottomLeft()
		
	self:spawnRainbow()
		
	self.timer:every(1.32, function()
		self:spawnRainbow()
	end)
	
	-- self.timer:script(function(wait)
		-- local t = 0.9
		
		-- wait(0.25)
		
		-- while true do
			-- for i = -1, 1 do
				-- local dx = (32 * i)
				
				-- local bullet = self:spawnBullet("novanna/mini", soul.x + dx, -4)
				-- bullet.physics.speed_x = math.random(0, 1)
			-- end
			
			-- wait(t)
			
			-- for i = -1, 1 do
				-- local dx = (16 * i)
				
				-- local bullet = self:spawnBullet("novanna/mini", soul.x + dx, -4)
				-- bullet.physics.speed_x = -math.random(0, 1)
			-- end
			
			-- wait(t)
		-- end
	-- end)
end

local colors = {
	{1, .5, .5, 1},
	{1, .75, .5, 1},
	{1, 1, .5, 1},
	{.5, 1, .5, 1},
	{.5, 1, 1, 1},
	{.5, .5, 1, 1},
	{1, .5, .5, 1},
}

function MyWave:draw()
	super.draw(self)
	
	love.graphics.push()
	
	for k,v in ipairs(self.rainbows) do
		local line = v.curve:renderSegment(0, v.seg)
		
		for _, color in ipairs(colors) do
			local r, g, b, a = color[1], color[2], color[3], v.alpha
			
			for _ = 1, 6 do
				love.graphics.setColor(r, g, b, a)
				love.graphics.line(line)
				love.graphics.translate(0, 1 + v.distance)
			end
		end
	end
	
	love.graphics.pop()
	
	love.graphics.setColor(1, 1, 1, 1)
end

return MyWave