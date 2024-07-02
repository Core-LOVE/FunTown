local GreenSoul, super = Class(Soul)

GreenSoul.hasSecondShield = false
GreenSoul.isExplosive = false

local invert = {
	["left"] = "right",
	["up"] = "down",
	["right"] = "left",
	["down"] = "up",
	
	["left+up"] = "down+right",
	["left+down"] = "up+right",
	["up+right"] = "left+down",
	["down+right"] = "left+up",
}

function GreenSoul:init(x, y)
    super:init(self, x, y)

    self.color = {0,192 / 255,0}
	
	-- internal stuff
	self.can_move = false
	self.can_defend = true
	
	self.tween = nil
	
	self.shield = GreenSoulShield(-self.width * 1.5, -self.height * 1.5)
	
	if GreenSoul.hasSecondShield then
		self.shield2 = GreenSoulSecondShield(-self.width * 1.5, -self.height * 1.5)
		self:addChild(self.shield2)
	end
	
	self.circle = GreenSoulCircle(-self.width * 1.5, -self.height * 1.5)
	
	self.usingAbility = false
	
	self:addChild(self.shield)
	self:addChild(self.circle)

	-- parameters
	self.rotationSides = {
		["left+up"] = 315,
		["left+down"] = 225,
		["up+right"] = 45,
		["down+right"] = 135,
		
		["left"] 	= 270,
		["right"] 	= 90,
		["down"] 	= 180,
		["up"] 		= {0, 360},
	}
	
	self.rotationSidesIterator = {
		"left",
		"right",
		"down",
		"up",
		
		"left+up",
		"left+down",
		"up+right",
		"down+right",
	}
	
	self.rotationSpeed = Kristal.getLibConfig("greensoul", "rotationSpeed")
	self.rotationStyle = Kristal.getLibConfig("greensoul", "rotationStyle")
	self.isDiagonal = Kristal.getLibConfig("greensoul", "diagonal")
	
	self:setShieldRotation(Kristal.getLibConfig("greensoul", "side"))
	self.defaultSide = self.side
	
	if self.shield2 then
		self:setSecondShieldRotation(Kristal.getLibConfig("greensoul", "side"))
	end
	
	if GreenSoul.isExplosive then
		local spr = Sprite("player/heart_outline_filled_inner", self.x, self.y)
		spr:setOrigin(0.5, 0.5)
		
		spr.scale_origin_x = 0.5
		spr.scale_origin_y = 0.5
		
		spr.color = {0, 1, 0}
		spr._t = 0
		
		spr.update = function(self)
			self._t = self._t + 0.15
			
			self:setScale(1.5 + math.sin(self._t))
			self.alpha = math.sin(self._t) / 2
			
			if self.alpha < 0.25 then
				self.alpha = 0.25
			end
		end
		
		self.explosive = spr
		self:addChild(spr)
	end
	
	self._t = Timer()
	self.timer = Timer()
	self:addChild(self._t)
	self:addChild(self.timer)

	self.canSwipe = false
	self.swipeTimerMax = 16
	self.swipeTimer = self.swipeTimerMax
end

function GreenSoul:setShieldRotation(side)
	local shield = self.shield
	local val = self.rotationSides[side]
	
	if type(val) == 'table' then val = val[1] end
	
	shield.rotation = math.rad(val)
	shield.side = side
end

function GreenSoul:setSecondShieldRotation(side)
	local shield = self.shield2
	local val = self.rotationSides[invert[side]]
	
	if type(val) == 'table' then val = val[1] end
	
	shield.rotation = math.rad(val)
	shield.side = side
end

function GreenSoul:rotateShield(side)
	local val = self.rotationSides[side]
	local shield = self.shield
	
	if type(val) == 'table' then
		if math.deg(shield.rotation) > 180 then
			val = val[2]
		else
			val = val[1]
		end
	end
	
	shield.side = side
	self.tween = Tween.new(1, shield, {rotation = math.rad(val)}, self.rotationStyle)
end

function GreenSoul:rotateSecondShield(side)
	local val = self.rotationSides[invert[side]]
	local shield = self.shield2
	
	if type(val) == 'table' then
		if math.deg(shield.rotation) > 180 then
			val = val[2]
		else
			val = val[1]
		end
	end
	
	shield.side = side
	self.tween2 = Tween.new(1, shield, {rotation = math.rad(val)}, self.rotationStyle)
end

local function isDown(key)
	return Input.key_down[key] or Input.key_pressed[key]
end

local function inputCheck(self, keyArg)
	if not self.isDiagonal then
		return Input.down(keyArg)
	end
	
	local firstKey, secondKey = keyArg:match("([^,]+)%+([^,]+)")
	
	if not firstKey then
		firstKey = keyArg
	end
	
	if secondKey and not isDown(secondKey) then
		return false
	end

	return isDown(firstKey)
end

local function secondShield(self)
	if not self.shield2 then return end
	
	if self.tween2 then 
		if self.tween2:update(self.rotationSpeed) then 
			self.tween2 = nil
		else
			return
		end
	end
	
	if not self.can_defend then return end
	
	for _, key in ipairs(self.rotationSidesIterator) do
		if inputCheck(self, key) then
			self:rotateSecondShield(key)
		end
	end
end

function GreenSoul:draw()
	super.draw(self)
end

local function getPhantombullets(self)
	local collider = CircleCollider(self.sprite, 8, 8, 40)
    local collided_bullets = {}

    Object.startCache()

    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
        if bullet:collidesWith(collider) and bullet.ignore then
            -- Store collided bullets to a table before calling onCollide
            -- to avoid issues with cacheing inside onCollide
            table.insert(collided_bullets, bullet)
        end
    end

    Object.endCache()

    for _,bullet in ipairs(collided_bullets) do
        Assets.playSound("graze")
        Game:giveTension(bullet.tp * self.graze_tp_factor)

		self.graze_sprite.timer = 1/2  
		     	
        bullet:_onCollide(self)
        bullet:remove()
    end
end

function GreenSoul:update()
	super:update(self)
	secondShield(self)
	
	if self.tween then 
		if self.tween:update(self.rotationSpeed) then 
			self.tween = nil
		else
			return
		end
	end
	
	if not self.can_defend then return end
	
	if self.swipeTimer > 0 then
		self.swipeTimer = self.swipeTimer - 1
	end

	if Input.down("confirm") and self.canSwipe and self.swipeTimer <= 0 then
		self.canSwipe = false
		Assets.playSound('swipe')

		local shield = self.shield

		local rotSpeed = self.rotationSpeed * 2.5

		local t = Timer()
		t:tween(rotSpeed, shield, {rotation = shield.rotation + math.rad(360)}, 'out-quad', function()
			self.canSwipe = true
			self.sprite.rotation = math.rad(0)
			self.swipeTimer = self.swipeTimerMax

			t:remove()
		end)

		t:during(rotSpeed, function()
			getPhantombullets(self)
		end)

		t:tween(rotSpeed, self.sprite, {rotation = math.rad(360)}, 'out-quad')

		t:every(0.1, function()
			local shield_after = Sprite("player/shield", shield.x, shield.y)
			shield_after.rotation_origin_x = 0.5
			shield_after.rotation_origin_y = 0.5
			shield_after.physics.match_rotation = true		
			shield_after.rotation = shield.rotation
			shield_after.physics.speed = 0.25
			shield_after.color = {math.random(), math.random(), math.random()}
			shield_after.alpha = 0.5
			shield_after:fadeOutAndRemove(0.36)

			self:addChild(shield_after)
		end)

		self.sprite:shake(math.random(4), math.random(4), .5, 2/30)
		-- shield.sprite:shake(math.random(2), math.random(2))

		self:addChild(t)
		-- local shield = self.shield
		-- local speed = math.rad(6)
		
		-- if Input.down("down") or Input.down("right") then
		-- 	shield.rotation = shield.rotation + speed
		-- elseif Input.down("up") or Input.down("left") then
		-- 	shield.rotation = shield.rotation - speed
		-- end
		
		-- local sprite = self.sprite
		
		-- sprite.rotation = shield.rotation + math.rad(180)
		
		-- if sprite.rotation > 360 then
		-- 	sprite.rotation = 0
		-- elseif sprite.rotation < 0 then
		-- 	sprite.rotation = 360
		-- end
		
		-- self.usingAbility = true
		-- return
	end
	
	self.usingAbility = false
	
	-- if not self.canSwipe then return end

	for _, key in ipairs(self.rotationSidesIterator) do
		if inputCheck(self, key) then
			self:rotateShield(key)
		end
	end
end

function GreenSoul:onDamage(bullet, amount)
	if not GreenSoul.isExplosive then return end
	
	self.explosive:remove()
	GreenSoul.isExplosive = false
	
	self:addChild(GreenSoulExplosion(self.x, self.y))
end

return GreenSoul