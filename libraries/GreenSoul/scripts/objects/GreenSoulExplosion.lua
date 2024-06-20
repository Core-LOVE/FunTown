local GreenSoulExplosion, super = Class(Object)

local function explode(self, radius, dontExplode)
	local collider = CircleCollider(self, 0, 0, radius)
	
	if not dontExplode then
		local bullets = {}
		Object.startCache()
		
		for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
			if bullet:collidesWith(collider) then
				table.insert(bullets, bullet)
			end
		end
		
		Object.endCache()
		
		for _,bullet in ipairs(bullets) do
			if not bullet.cantExplode then
				bullet:remove()
			end
		end
	end

	self.trueRad = 0
	self.radAlpha = 1
	
	self.tween = Tween.new(0.35, self, {trueRad = radius, radAlpha = 0}, 'outQuart')
end

function GreenSoulExplosion:init(x, y, dontExplode)
	super:init(self, x, y)
	
	Game.battle:shakeCamera(8)
	Assets.playSound('bomb')
	
	self.radius = 256

	self.scale_origin_x = 0.5
	self.scale_origin_y = 0.5

	explode(self, self.radius, dontExplode)
end

function GreenSoulExplosion:update()
	super:update(self)
	
	local done = self.tween:update(0.01)
	
	if done then
		self:remove()
	end
end

function GreenSoulExplosion:draw()
	super:draw(self)
	
	local radius = self.radius
	
	love.graphics.push('all')
	love.graphics.setColor(0, 1, 0, 1 - (1 - self.radAlpha))
	love.graphics.circle('line', -self.x, -self.y, radius)
	love.graphics.pop()
	
	local radius = self.trueRad
	
	love.graphics.push('all')
	love.graphics.setColor(0, 1, 0, self.radAlpha)
	love.graphics.circle('line', -self.x, -self.y, radius)
	love.graphics.pop()
	
	local radius = self.trueRad * .5
	
	love.graphics.push('all')
	love.graphics.setColor(0, 1, 0, self.radAlpha * .5)
	love.graphics.circle('fill', -self.x, -self.y, radius)
	love.graphics.pop()
end

return GreenSoulExplosion