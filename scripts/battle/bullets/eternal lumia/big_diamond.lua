local id = "eternal lumia/big_diamond"
local MyBullet, super = Class(Bullet, id)

local function explode(self)
    self.exploded = true

    Assets.playSound("eternal lumia laser", 0.25, 1.5)
    Assets.playSound("l_shard", 0.5, 1.1)

    Game.battle:shakeCamera(3, 3, .5)

    local circle = Ellipse(self.x, self.y, 15)
    circle:setOrigin(.5)
    circle.parallax_x = 0
    circle.parallax_y = 0

    local t = Timer()

    t:tween(0.25, circle, {alpha = 0, width = circle.width * 4, height = circle.height * 4}, nil, function()
        circle:remove()
    end)
    
    circle:addChild(t)
    circle:setLayer(self.layer + 1)
    
    Game.battle:addChild(circle)
    
    for i = 1, 3 do
        local x = self.x + 16
        local y = self.y + (4 * i)
        local speed = 8
        local angle = -1

        if self.slower then
            angle = -3
        end

        if i == 2 then
            x = self.x + 8
            speed = speed + 2
            angle = 0
        elseif i == 3 then
            angle = -angle
        end

        if self.slower then
            speed = speed * 0.8
        end

        local bullet = self.wave:spawnBullet("diamond", x, y, Utils.angle(Game.battle.soul, self) + math.rad(angle), speed)
        bullet:setScale(1)
        bullet:setHitbox(0, 0, 12, 12)
        bullet.tp = 1
    end

    for dx = 0, 32, 10 do
        for dy = 0, 36, 10 do
            if math.random() > 0.1 then
                local effect = Sprite("effects/eternal lumia/shard", self.x + dx, self.y + dy)
                effect:setOrigin(.5, .5)
                effect:setScale(math.random(2)) 
                effect.alpha = math.random() + .5
                effect.physics.gravity = (math.random() * .25) + 0.4
                effect.physics.speed_y = -math.random(6, 9)
                effect.physics.speed_x = math.random(-3, 3)
                effect:play(2 / 30, true)

                local t = Timer()
                local timer = math.random(2) / 2

                t:after(timer, function()
                    t:tween(0.32, effect, {alpha = 0}, nil, function()
                        effect:remove()
                    end)            
                end)

                effect:addChild(t)

                Game.battle:addChild(effect, BATTLE_LAYERS.above_bullets)
            end
        end
    end
end

function MyBullet:onWaveSpawn(wave)
    self.wave = wave
end

function MyBullet:init(x, y)
    Assets.playSound("l_shard", 0.5, 2)

    super:init(self, x, -34)
    self:setSprite("bullets/" .. id .. "_flash", 4 / 60, true)

    local t = Timer()

    self.start = {x, -34}

    t:tween(0.75, self, {x = x, y = y}, 'out-back')
    t:after(1, function()
        explode(self)

        t:tween(0.5, self, {y = -32}, 'in-sine', function()
            self:remove()
        end)
    end)

    self:addChild(t)
    self.timer = t
    self.t = 0

    self.exploded = false
end

function MyBullet:update()
    super.update(self)

    if self.exploded then return end

    self.t = self.t + 0.1

    self.x = self.x + math.cos(self.t) * 2
end

function MyBullet:draw()
    love.graphics.push('all')
    love.graphics.origin()
    love.graphics.setLineWidth(2)
    love.graphics.setColor(0, 0, 0)
    love.graphics.line(self.start[1], self.start[2], self.x, self.y)
    love.graphics.pop()

    if self.exploded then return end

    super.draw(self)
end

return MyBullet