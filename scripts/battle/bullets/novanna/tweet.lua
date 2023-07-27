local id = "novanna/tweet"
local MyBullet, super = Class(Bullet, id)

function MyBullet:setText(text)
	self.text = text[math.random(#text)]
end

function MyBullet:init(x, y, w, h)
    super:init(self, x, y)

	Assets.playSound("voice/novanna")
    -- self:setSprite("bullets/" .. id, 4 / 60, true)
	
	self.width = w
	self.height = h
	self.realWidth = 16
	self.realHeight = 16
	
	self:setScale(1)
	self:setOrigin(0, 0)
    self:setHitbox(0, 0, w, h)
	self.tp = 0
	
	local t = Timer()
	
	t:tween(.5, self, {realWidth = w, realHeight = h}, 'in-out-circ', function()
		self.physics.speed_x = -3
		self.physics.friction = -0.1
	end)
	
	self:addChild(t)
	self:setText{
		"so lonely\n;w;",
		"let's\nparty!!",
		"love you\nall uwu",
		"helping\ndaddy rn!",
		"fighting\nlight omg",
		"having\ngood time!",
		"goatmommy\nwith me!"
	}
	
	self.font = Assets.getFont("main", 12)
	self.liked = math.random(0, 9)
end

local r = 6

local miniHeart = Assets.getTexture("player/heart_menu")

function MyBullet:draw()
	super.draw(self)
	
    love.graphics.setColor(1, 1, 1, .5)
    love.graphics.rectangle("line", 0, 0, self.width, self.height, r, r)
	
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, self.realWidth, self.realHeight, r, r)
	
	love.graphics.stencil(function()
		love.graphics.rectangle("fill", 0, 0, self.realWidth, self.realHeight, r, r)
	end)
	
	love.graphics.setStencilTest("greater", 0)
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.draw(miniHeart, 4, self.realHeight - 8)
	
    love.graphics.setColor(0, 0, 0, 1)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, 4, 4)
	
    love.graphics.setColor(.5, .5, .5, 1)
	love.graphics.print(self.liked, 8 + miniHeart:getWidth(), self.realHeight - 12)
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setStencilTest()
	
    super.draw(self)
end

return MyBullet