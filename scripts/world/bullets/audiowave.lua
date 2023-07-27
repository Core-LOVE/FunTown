local id = "audiowave"
local MyWorldBullet, super = Class(WorldBullet)

function MyWorldBullet:init(x, y, rotation)
    super.init(self, x, y, "bullets/world/" .. id)

    self.damage = 20

	self:setScale(1)
	self.rotation = rotation - math.rad(90)
	self.alpha = 0.75
	
	self.physics.match_rotation = true
    self.physics.speed = 7
	
	local t = Timer()
	
	t:tween(1.5, self, {alpha = 1, scale_x = 3, scale_y = 3}, 'in-sine')
	
	self.timer = t
	self:addChild(t)
	
	self.collided = {}
end

local function onCollide(self, reflector)
	self.collided[reflector] = true
	self.rotation = -self.rotation
	
	local effect = Sprite("effects/soundwave", reflector.x, reflector.y)
	effect:setOrigin(.5, .5)
	effect:setScale(2)
	effect.layer = reflector.layer + 10
	
	local t = Timer()

	t:tween(.5, effect, {alpha = 0, scale_x = 5, scale_y = 5}, nil, function()
		effect:remove()
	end)
	
	reflector:setScale(1.75)
	t:tween(.4, reflector, {scale_x = 2, scale_y = 2})
	
	effect:addChild(t)
	
	Game.world:addChild(effect)
end

function MyWorldBullet:update()
    super.update(self)
	
    Object.startCache()
	
	for _,reflector in ipairs(Game.stage:getObjects(Event)) do
		if not self.collided[reflector] and reflector.id == "reflector" and self.collider:collidesWith(reflector) then
			onCollide(self, reflector)
			break
		end
	end
	
    Object.endCache()
end

return MyWorldBullet