local id = "eternal lumia/bigbird"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, rot)
    super:init(self, x, y)
    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    if math.random() > 0.9 then
        self:setSprite("bullets/" .. id .. "_lumia", 4 / 60, true)
    end
	-- self:setScale(1)
    local w, h = 9, 8

    self:setHitbox(w / 4, h / 4, w / 2, h / 2)

    self.timer = Timer()

    self:addChild(self.timer)
end

function MyBullet:onWaveSpawn(wave)
    self.wave = wave
end

return MyBullet