local id = "novanna/bed"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y, size)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	
    self:setHitbox(8, 0, 72, 32)
	
	self.tp = 0
end

function MyBullet:update()
	super.update(self)
	
	local collided_bullets = {}
    Object.startCache()
	
    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
        if bullet ~= self and bullet:collidesWith(self.collider) then
            table.insert(collided_bullets, bullet)
        end
	end
	
	Object.endCache()
	for k,v in ipairs(collided_bullets) do
		Assets.playSound('boing', 2, 0.96)
		v.physics.speed_y = -math.random(12, 16)
		
		local sign = -1
		if v.physics.speed_x > 0 then
			sign = 1
		end
		
		v.physics.speed_x = 4 * sign
	end
end

return MyBullet