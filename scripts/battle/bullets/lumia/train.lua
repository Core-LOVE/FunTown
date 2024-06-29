local id = "lumia/train"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(sprite, x, y, is_smoking)
    super:init(self, x, y)

    self:setSprite("bullets/lumia/" .. sprite, 3 / 30, true)
	
    local hitbox_w, hitbox_h = 12, 5
    local hitbox_x, hitbox_y = (16 - hitbox_w) * .5, (16 - hitbox_h) * .5

    self:setHitbox(hitbox_x, hitbox_y, hitbox_w, hitbox_h)

    if (is_smoking) then
        local t = Timer()

        t:every(0.75, function()
            local x = 9

            if self.physics.speed_x < 0 then x = 8 end

            t:script(function(wait)
                for i = 0, 3 do
                    local smoke = Sprite("effects/lumia/smoke", x, -3)
                    smoke:setOrigin(.5)
                    smoke.physics.speed_x = (-self.physics.speed_x * .25) * self.scale_x
                    smoke.physics.speed_y = -2
                    smoke.inherit_color = true

                    t:tween(0.5, smoke, {alpha = 0, scale_x = 2, scale_y = 2}, nil, function()
                        smoke:remove()
                    end)

                    self:addChild(smoke)
                    wait(0.1)
                end
            end)
        end)

        self:addChild(t)
    end
end

function MyBullet:update()
	super.update(self)
end

return MyBullet