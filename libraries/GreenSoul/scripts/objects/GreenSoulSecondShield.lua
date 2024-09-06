local GreenSoulSecondShield, super = Class(Object)

local mathpi = math.pi
local mathsin = math.sin
local mathcos = math.cos

function GreenSoulSecondShield:init(x, y)
    super.init(self, x, y)
	
    self.layer = BATTLE_LAYERS["above_bullets"]
    self:setSprite("player/secondshield")

	local spr = self.sprite
	self.rotation_origin_x = 0.5
	self.rotation_origin_y = 0.5
	
    self.physics = nil
	self.additional_rotation = 0
	self.additional_distance = 0

	-- self.rotationHitboxes = {
		-- ["up"] 		= {0, 0, self.width, 1},
		-- ["right"]	= {self.width - 1, 0, 1, self.height},
		-- ["down"]	= {0, self.height - 1, self.width, 1},
		-- ["left"]	= {0, 0, 1, self.height},
		
		-- ["left+up"]		= {0, 0, self.width /2, self.height /2},
		-- ["up+right"]	= {self.width /2, 0, self.width /2, self.height /2},
		-- ["left+down"]	= {0, self.height /2, self.width /2, self.height /2},
		-- ["right+down"]	= {self.width /2, self.height /2, self.width /2, self.height /2},
	-- }
	
	self.blinkTimer = 0
	self._t = Timer()
	self:addChild(self._t)
	-- self:changeSide("up")
end

function GreenSoulSecondShield:draw()
	super:draw(self)
end

function GreenSoulSecondShield:resolveBulletCollision(bullet)
	if bullet and not bullet.ignore then
		Assets.playSound("greensoul/shield", 0.75)
		Assets.playSound("supportshield", 0.75, 1.25)

		if self.blinkTimer <= 0 then
			self.alpha = self.alpha - 0.32
		end

		self.blinkTimer = 2 --Kristal.getLibConfig("greensoul", "blinkTimer")
		self:setSprite("player/secondshieldHit")

		-- self:setScale(0.9)
		-- self._t:tween(0.1, self.sprite, {scale_x = 1, scale_y = 1}, 'out-sine')
		
		if bullet.onShieldHit then
			local remove = bullet:onShieldHit(self)
			
			if remove then
				return bullet:remove()
			end
		else
			bullet:remove()
			
		end

		if self.alpha <= 0.32 then
			GreenSoul.hasSecondShield = false
			Assets.playSound("supportshield", 0.75, 1)
			self:remove()
		end
	end
end

function GreenSoulSecondShield:updateCollider(d)
    --some notes: 
    --self.rotation is already in radians, you dont need to convert it to radians again
    --the soul's tip, graphically, is 90 degrees (pi radians) away from the soul's self.rot
    local rot = self.rotation - math.rad(90)
    local d = d or 32 --change as needed, maybe make this a part of the object?
    local w = 60 --same as above

    --midpoint. 90 degrees counterclokwise (+ angle) and d distance away from soul
    local m_x, m_y = d * math.cos(rot),  d * math.sin(rot)

    --left endpoint. w distance away from right endpoint, w/2 distance away from center, in the opposite direction the soul is facing
    local l_x, l_y = ( -w/2 * math.cos(rot + math.pi/2) ) + m_x,  ( -w/2 * math.sin(rot + math.pi/2) ) + m_y

    --right endpoint. w distance away from right endpoint, w/2 distance away from center, in the same direction the soul is facing
    local r_x, r_y = ( w/2 * math.cos(rot + math.pi/2) ) + m_x,  ( w/2 * math.sin(rot + math.pi/2) ) + m_y
    -- print( m_x, m_y)

    --collider spans points L to R
    self.collider = LineCollider(self.parent,  l_x, l_y,  r_x, r_y)
end

function GreenSoulSecondShield:update(_, d)
	self:updateCollider(d)
	
    local collided_bullets = {}
    Object.startCache()
    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
    	local collider = bullet.collider
    	local x, y = collider.x, collider.y

    	-- for distance = 0, self.additional_distance do
    	-- 	collider.x = x + math.sin(bullet.physics.direction) * distance
    	-- 	collider.y = y + math.cos(bullet.physics.direction) * distance

	        if bullet:collidesWith(self.collider) then
	            -- Store collided bullets to a table before calling onCollide
	            -- to avoid issues with cacheing inside onCollide
	            table.insert(collided_bullets, bullet)
	        end
    	-- end

    	-- collider.x = x
    	-- collider.y = y
    end
    Object.endCache()
	
    for _,bullet in ipairs(collided_bullets) do
        self:resolveBulletCollision(bullet)
    end
	
	if d then return end
	
	if self.blinkTimer > 0 then
		self.blinkTimer = self.blinkTimer - 1
		
		if self.blinkTimer <= 0 then
			self:setSprite("player/secondshield")
		end
	end
end

function GreenSoulSecondShield:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
	
    self.sprite = Sprite(sprite, 0, 0)
    self.sprite.inherit_color = true
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

function GreenSoulSecondShield:draw()
    super:draw(self)

    if DEBUG_RENDER and self.collider then
    	love.graphics.rotate(-self.parent.rotation)
    	-- love.graphics.rotate(self.additional_rotation)
        self.collider:drawFor(self, 1, 0, 0)
        -- love.graphics.rotate(-self.additional_rotation)
    	love.graphics.rotate(self.parent.rotation)
    end
end

return GreenSoulSecondShield