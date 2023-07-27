local Player, super = Class(Player)

function Player:updateBallon()
    if not self:isMovementEnabled() then return end

	local accel = 0.35
	local gravity = 0.075
	
	if Input.down("down") then self.physics.speed_y = self.physics.speed_y + accel end
	if Input.down("up") then self.physics.speed_y = self.physics.speed_y - accel end
	if Input.down("left") then self.physics.speed_x = self.physics.speed_x - accel end
	if Input.down("right") then self.physics.speed_x = self.physics.speed_x + accel end
	
	self.physics.speed_y = self.physics.speed_y - gravity
	
	self.physics.speed_x = Utils.clamp(self.physics.speed_x, -8, 8)
	self.physics.speed_y = Utils.clamp(self.physics.speed_y, -8, 8)
end

function Player:beginBallon()
	self.noclip = true
	
	self.sprite:setAnimation('ballon')
end

function Player:init(...)
	super.init(self, ...)
	
    self.state_manager:addState("BALLON", {update = self.updateBallon, enter = self.beginBallon})
	
	self.slide_texture = "effects/slide_dust"
end

function Player:updateSlideDust()
    self.slide_dust_timer = Utils.approach(self.slide_dust_timer, 0, DTMULT)

    if self.slide_dust_timer == 0 then
        self.slide_dust_timer = 3

        local dust = Sprite(self.slide_texture)
        dust:play(1/15, false, function() dust:remove() end)
        dust:setOrigin(0.5, 0.5)
        dust:setScale(2, 2)
        dust:setPosition(self.x, self.y)
        dust.layer = self.layer - 0.01
        dust.physics.speed_y = -6
        dust.physics.speed_x = Utils.random(-1, 1)
        self.world:addChild(dust)
    end
end

function Player:endSlide(next_state)
	super.endSlide(self, next_state)
	
	self.slide_texture = "effects/slide_dust"
end

return Player
