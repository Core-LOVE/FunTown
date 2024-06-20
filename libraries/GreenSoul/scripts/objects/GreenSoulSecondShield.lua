local GreenSoulSecondShield, super = Class(Object)

function GreenSoulSecondShield:init(x, y)
    super:init(self, x, y)
	
    self.layer = BATTLE_LAYERS["above_bullets"]
    self:setSprite("player/secondShield")

	local spr = self.sprite

	self.rotation_origin_x = 0.5
	self.rotation_origin_y = 0.5
	
    self.physics = nil
	
	self.rotationHitboxes = {
		["up"] 		= {0, 0, self.width, 1},
		["right"]	= {self.width - 1, 0, 1, self.height},
		["down"]	= {0, self.height - 1, self.width, 1},
		["left"]	= {0, 0, 1, self.height},
		
		["left+up"]		= {0, 0, self.width * .5, self.height * .5},
		["up+right"]	= {self.width * .5, 0, self.width * .5, self.height * .5},
		["left+down"]	= {0, self.height * .5, self.width * .5, self.height * .5},
		["right+down"]	= {self.width * .5, self.height * .5, self.width * .5, self.height * .5},
	}
	
	self.blinkTimer = 0
	self:changeSide("up")
end

function GreenSoulSecondShield:draw()
	super:draw(self)
end

function GreenSoulSecondShield:resolveBulletCollision(bullet)
	Assets.playSound("greensoul/shield")

	if bullet then
		if bullet.onShieldHit then
			local remove = bullet:onShieldHit(self)
			
			if remove then
				bullet:remove()
			end
		else
			bullet:remove()
		end
	end
	
	local fade = Sprite("player/secondShield", self.x, self.y)
	fade.rotation = self.rotation
	fade.rotation_origin_x = 0.5
	fade.rotation_origin_y = 0.5
	fade.color = {1, 0, 0}
	
	fade.update = function()
		fade.alpha = fade.alpha - 0.075
		
		if fade.alpha < 0 then
			GreenSoul.hasSecondShield = false

			fade:remove()
		end
	end
	
	Game.battle.soul:addChild(fade, 9999)
	
	self:remove()
end

function GreenSoulSecondShield:update()
    local collided_bullets = {}
    Object.startCache()
    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
        if bullet:collidesWith(self.collider) then
            -- Store collided bullets to a table before calling onCollide
            -- to avoid issues with cacheing inside onCollide
            table.insert(collided_bullets, bullet)
        end
    end
    Object.endCache()
	
    for _,bullet in ipairs(collided_bullets) do
        self:resolveBulletCollision(bullet)
    end
end

function GreenSoulSecondShield:changeSide(side)
	self.collider = Hitbox(self, unpack(self.rotationHitboxes[side or "up"]))
end

function GreenSoulSecondShield:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
	
    self.sprite = Sprite(sprite, 0, 0)
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

function GreenSoulSecondShield:draw()
    super:draw(self)

    if DEBUG_RENDER and self.collider then
        self.collider:drawFor(self, 1, 0, 0)
    end
end

return GreenSoulSecondShield