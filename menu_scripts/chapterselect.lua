local ChapterSelect, super = Class('Object')

function ChapterSelect:init()
	super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	
    self.heart = Sprite("player/heart_menu", 32, 32)
    self.heart.visible = true
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setScale(2, 2)
    self.heart:setColor(1, 0, 0)
    self.heart.layer = 200
    self:addChild(self.heart)
	
	-- self.physics.friction = 0.2
end

return ChapterSelect