local id = "lumia/doll"
local MyBullet, super = Class(Bullet, id)

function MyBullet:initPart(part, x, y, real_pos, no_strings)
	local sprite = Sprite("bullets/" .. id .. "/part_" .. part, x or 0, y or 0)
	sprite:setRotationOrigin(.5)
	sprite.real_pos = real_pos or {x = 0, y = 0}
	sprite.init_pos = real_pos or {x = 0, y = 0}
	sprite.no_strings = no_strings

	self:addChild(sprite)
	self.parts[part] = sprite

	return self.parts[part]
end

function MyBullet:animate(part, tw, t, ease)
	local t1 = tw(self.parts[part])

	self.t:tween(t or 1, self.parts[part], t1, ease or 'in-out-sine', function()
		local _, t2 = tw(self.parts[part])

		self.t:tween(t or 1, self.parts[part], t2, ease or 'in-out-sine', function()
			self:animate(part, tw, t, ease)
		end)	
	end)
end

function MyBullet:onWaveSpawn(wave)
	self.wave = wave
end

function MyBullet:init(x, y)
    super:init(self, x, -52)

    self.parts = {}

    self:initPart("head", nil, nil, {x = 26, y = 6}).rotation = math.rad(45)
    self:initPart("body", nil, nil, {x = 32, y = 32})
    self:initPart("legs", nil, nil, nil, true).rotation = math.rad(-45)  
    self:initPart("hands", nil, nil, nil, true).rotation = math.rad(25)

    local nose = self:initPart("nose", 1, 2, nil, true)
    nose:setScale(0.75)
    nose:setRotationOrigin(0.75, 0.5)

    self:setScale(2.5)
    -- self:setSprite("bullets/" .. id .. "/" .. (part or "head"), 3 / 30, true)

    self:setHitbox(0, 0, 32, 52)

    local t = Timer()

    t:tween(0.5, self, {y = y}, 'out-back')
    
    for k,v in pairs(self.parts) do
   		t:tween(1, v, {rotation = math.rad(0)}, 'out-elastic')
    end

    self:addChild(t)
    self.t = t

    t:after(1, function()
    	t:every(0.35, function()
    		local part = self.parts.nose
    		local soul = Game.battle.soul

			local x, y = part:getRelativePos(8, 8, Game.battle)
    		local bullet = self.wave:spawnBullet("lumia/doll/part_nose", x, y, part.rotation)

    		-- local radius = 96
    		-- local rot = math.rad(part.rotation) + math.rad(90)

    		-- local dx = math.cos(rot) * radius
    		-- local dy = math.sin(rot) * radius

    		t:tween(0.75, bullet.physics, {speed = -32}, 'in-out-sine', function()
    			bullet.physics.speed = 0

    			t:tween(0.35, bullet, {x = bullet.init_x, y = bullet.init_y}, 'in-out-sine', function()
    				bullet:remove()
    			end)
    		end)
    	end)

    	self:animate("nose", function(part)
    		return
    		{
    			y = part.y - 2,
    			rotation = math.rad(-45),
    		},
    		{
    			y = part.y + 2,
    			rotation = math.rad(22),
    		} 		
    	end, 1.25)

	    self:animate("head", function(part)
	    	return {y = part.y - 2}, {y = part.y + 2}
	    end)

	    self:animate("body", function(part)
	    	return {x = part.x - 2}, {x = part.x + 2}
	    end)

	    self:animate("legs", function(part)
	    	return {x = part.y + 1}, {x = part.y - 1}
	    end)

	    self:animate("hands", function(part)
	    	return 
	    	{
	    		rotation = math.rad(-10),
	    		x = part.y + 1
	    	}, 
	    	{
	    		rotation = math.rad(0),
	    		x = part.y - 1
	    	}
	    end)
	end)
end

function MyBullet:update()
	super.update(self)
end

function MyBullet:draw()
	for k, part in pairs(self.parts) do
		if not part.no_strings then
			love.graphics.push('all')
			love.graphics.origin()

			love.graphics.setColor(0.5, 0.5, 0.5)
			love.graphics.line(self.x + part.real_pos.x + part.x, self.y + part.real_pos.y, self.x + part.init_pos.x, -52)

			love.graphics.pop()
		end
	end

	super.draw(self)
end

return MyBullet