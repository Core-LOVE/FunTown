local GreenSoulCircle, super = Class(Object)

function GreenSoulCircle:init(x, y)
    super:init(self, x, y)
	
    self.layer = BATTLE_LAYERS["above_bullets"]
	
    self:setSprite("player/greenCircle")
	self.sprite.color = Kristal.getLibConfig("greensoul", "circleColor")
	
    self.physics = nil
end

function GreenSoulCircle:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
	
    self.sprite = Sprite(sprite, 0, 0)
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

return GreenSoulCircle