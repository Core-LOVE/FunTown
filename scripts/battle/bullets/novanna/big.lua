local id = "novanna/big"
local MyBullet, super = Class(Bullet, id)

function MyBullet:speak()
	local arena = Game.battle.arena
	
	local w, h = math.random(64, 96), math.random(48, 80)
	local x, y = (self.x - w) - 64, (self.y + 72) - h
	
	if math.random() > 0.5 then
		y = self.y - 72
	end
	
	self.wave:spawnBullet("novanna/tweet", x, y, w, h)
end

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
	self.tp = 0
	self.destroy_on_hit = false
	self.damage = 0
	
    self:setHitbox(0, 0, 64, 64)
	
	local t = Timer()
	
	t:after(.42, function()
		self:setSprite("bullets/" .. id .. "_speak", 0.15, true)
		
		self:speak()
		
		t:every(.64, function()
			self:speak()
		end)
	end)
	
	self:addChild(t)
end

-- function MyBullet:update()
	-- super.update(self)
-- end

return MyBullet