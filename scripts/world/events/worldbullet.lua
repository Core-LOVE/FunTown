local MyEvent, super = Class(Event)

function MyEvent:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

	self.bullet = self.world:spawnBullet()
    self:setOrigin(0.5, 0.5)
    self:setSprite("objects/ballon", 0.25)
	
	self.t = 0
end

function MyEvent:onCollide(chara)
    Assets.playSound("item")
	
	Game.world.player:setAnimation('ballon')
	
    self:remove()
end

function MyEvent:update()
	super:update(self)
	
	self.t = self.t + 0.05
	
	self.y = self.y - math.sin(self.t) * 3
end

return MyEvent