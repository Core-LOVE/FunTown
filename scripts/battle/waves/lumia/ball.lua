local MyWave, super = Class(Wave)

local shape = {}

do
	local radius = 142 / 2
	
	for angle = 0, 360, 25 do
		local angle = math.rad(angle)
		
		local x = math.cos(angle) * radius
		local y = math.sin(angle) * radius
		
		table.insert(shape, {x, y})
	end
end

function MyWave:init()
    super.init(self)
	
	self.layer = BATTLE_LAYERS["soul"] - 1
	
	-- self.arena_height = 128
	-- self.arena_width = self.arena_height + self.arena_height
	
	self:setArenaShape(unpack(shape))
	
	self.mode = Utils.pick{
		-- "water",
		-- "fire",
		"wind",
	}
	
	self.icon = Assets.getTexture("battle/lumia/" .. self.mode)
	
	self.time = -1
    self.enemies = self:getAttackers()
end

local modes = {}

modes["water"] = function(self)
	self.timer:every(.5, function()
		local arena = Game.battle.arena
		
		self:spawnBullet("lumia/waterwave", arena.x, arena.y)
	end)
end

modes['fire'] = function(self)
	
end

modes['wind'] = function(self)
	local arena = Game.battle.arena
	local soul = Game.battle.soul
	
	soul.physics.speed_x = -2
	
	self:spawnBullet("lumia/flower", arena.x + 208, arena.y).wave = self
end


function MyWave:onStart()
	modes[self.mode](self)
	
	-- for k,enemy in ipairs(self:getAttackers()) do
		-- enemy:setAnimation('on')
	-- end
end

-- function MyWave:onEnd(death)
	-- for k,enemy in ipairs(self:getAttackers()) do
		-- enemy:setAnimation('off')
	-- end
-- end

function MyWave:draw()
	super.draw(self)
	
	local arena = Game.battle.arena
	local spr = arena.sprite
	
	local scale_x, scale_y = (spr.scale_x * 2), (spr.scale_y * 2)
	local w, h = (16 * scale_x), (16 * scale_y)
	
	love.graphics.setColor(1, 1, 1, 0.5)
	
	love.graphics.draw(self.icon, arena.x - w, arena.y - h, 0, scale_x, scale_y)
	
	love.graphics.setColor(1, 1, 1, 1)
end

return MyWave