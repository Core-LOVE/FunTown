local SoulFlash, super = Class(Sprite)

function SoulFlash:init(parent, count, alpha)
    super:init(self, "player/heart_dodge", 0, 0)
    
    self.color = parent.color
    
    self:setParallax(0)
    self.scale_origin_x = 0.5
    self.scale_origin_y = 0.5
    
    self.count = count
    self.countAlpha = alpha
    
    parent:addChild(self)
end

function SoulFlash:update()
    self:setScale(self.scale_x + self.count)
    self.alpha = self.alpha - self.countAlpha
    
    if self.alpha < 0 then
        self:remove()
    end
end

local SoulTrail, super = Class(Sprite)

function SoulTrail:init(parent)
    super:init(self, "player/heart", parent.x, parent.y)
    
    self:setScale(parent.scale_x)
    self:setParallax(0)
    self.color = parent.color
    self.alpha = 0.6
    
    Game.world:spawnObject(self, 1005)
end

function SoulTrail:update()
    self.alpha = self.alpha - 0.08
    
    if self.alpha < 0 then
        self:remove()
    end
end

local function startEncounter(cutscene)
    cutscene:loadMap("eternal lumia arena")
    cutscene:startEncounter('eternal lumia', nil)

    return true
end

return function(cutscene, event, player, facing)
    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
    local lumia = cutscene:getCharacter("lumia")

    cutscene:detachFollowers()
    cutscene:detachCamera()
    cutscene:setTextboxTop(false)
    cutscene:panTo(lumia)

    do
        local t = 1.5

        local y = 640 + 52
        local x = 240

        susie:setFacing('down')
        ralsei:setFacing('down')
        kris:setFacing('down')

        cutscene:walkTo(susie, x, y, t, nil, true)
        cutscene:walkTo(ralsei, x + 80, y - 30, t, nil, true)
        cutscene:walkTo(kris, x + 160, y - 5, t, nil, true)

        cutscene:wait(t + 0.25)
    end

    cutscene:text("* WELCOME!", nil, lumia)
    cutscene:text("* ...", nil, lumia)
    cutscene:text("* I KNOW YOU, KRISsS.[wait:4] I KNOW YOUR TYPE.", nil, lumia)
    cutscene:text("* NEVER DOUBTED FOR A SsSECOND THAT YOU WOULD COME.", nil, lumia)
    cutscene:text("* THISsS[wait:6] WASsS MY PLACE OF LIVING ONCE.", nil, lumia)   
    cutscene:text("* BUCKETS OF FLOWERSsS ALWAYS FELL DOWN HERE.", nil, lumia)   
    cutscene:text("* ALMOST AS IF[wait:8] THEY WERE BEING PLACED ON MY GRAVE...", nil, lumia)   
    cutscene:text("* ... I WANTED TO COME BACK SsSO MUCH.", nil, lumia)   
    cutscene:text("* I WANTED TO BE ALIVE!\nI WANTED TO MEAN SsSOMETHING!", nil, lumia)   
    cutscene:text("* But it didn't matter.", nil, lumia)   
    cutscene:text("* AND THEN YOU CAME HERE...", nil, lumia)   
    cutscene:text("* YOU VENTURED DEEP INSsSIDE AND SsSAVED ME FROM THIS FATE.", nil, lumia)   
    cutscene:text("* BUT YOU REMEMBERED SsSOMETHING ELSE BESIDES JUST ME.", nil, lumia)   
    cutscene:text("* SsSO,[wait:8] ARE YOU READY TO FACE THE TRUTH?[wait:8] YOUR FATE?", nil, lumia)   

    local choice = cutscene:choicer({"Yes", "No"})

    lumia:setSprite("idle")
    Game.world.music:stop()

    if choice == 2 then
        cutscene:text("* ME DON'T CARESsS!", nil, lumia)
        cutscene:text("* LET THE MISsST TAKE CARE OF EVERYTHING!", nil, lumia)
    else
        cutscene:text("* GREAT![wait:6] LET THE MISsST TAKE CARE OF EVERYTHING!", nil, lumia)
    end

    Assets.playSound("smog")

    -- local t = Timer()

    -- t:every(0.4, function()
    --     local effect = Sprite("effects/smog", 0, 0)
    --     effect.parallax_x = 0
    --     effect.parallax_y = 0
    --     effect.layer = WORLD_LAYERS.below_textbox + 50
    --     effect:setScale(1, 2)
    --     effect.alpha = 0

    --     local effect2 = Sprite("effects/smog", 320, 0)
    --     effect2.parallax_x = 0
    --     effect2.parallax_y = 0
    --     effect2.layer = WORLD_LAYERS.below_textbox + 50
    --     effect2:setScale(-1, 2)
    --     effect2.alpha = 0

    --     t:tween(0.5, effect, {alpha = 1, scale_x = 2}, nil, function()
    --         t:tween(0.25, effect, {alpha = 0})
    --     end)

    --     -- t:tween(0.5, effect2, {alpha = 1, scale_x = -2}, nil, function()
    --     --     t:tween(0.25, effect2, {alpha = 0})
    --     -- end)

    --     Game.world:addChild(effect)
    --     Game.world:addChild(effect2)
    -- end)

    -- Game.world:addChild(t)

    Assets.playSound("wing")

    cutscene:setSprite(kris, "fell")

    kris:shake(4)

    cutscene:wait(0.1)

    cutscene:setSprite(susie, "shock_right")
    cutscene:setSprite(ralsei, "fall")
    susie:shake(4)
    ralsei:shake(4)

    cutscene:fadeOut(2, {
        color = {0.75, 0.75, 0.75},
    })
    cutscene:wait(2)

    -- t:remove()

    -- Game.world.music:stop()

	local black = Rectangle(0, 0, 640, 480)
	black.color = {0, 0, 0}
	black.parallax_x = 0
	black.parallax_y = 0
	black.layer = WORLD_LAYERS.above_bullets + 50

	Game.world:addChild(black)

	local start_x, start_y = 96, 52
	local dy = 100

    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
    local layer = (black.layer + 1)
    kris.layer = layer
    susie.layer = layer
    ralsei.layer = layer

    kris:setParallax(0)
    susie:setParallax(0)
    ralsei:setParallax(0)

    kris.x = start_x
    susie.x = start_x
    ralsei.x = start_x

    kris.y = start_y + (dy * 1)
    susie.y = start_y + (dy * 2)
   	ralsei.y = start_y + (dy * 3)

   	cutscene:setSprite(susie, "shock_right")
    cutscene:setSprite(ralsei, "fall")
    cutscene:setSprite(kris, "fell")

    -- REPLACE
    local lumia = cutscene:spawnNPC("lumia", SCREEN_WIDTH - 80, (SCREEN_HEIGHT * .5) + 48) 
    lumia.layer = layer
    lumia:setSprite("dark")
    lumia:setParallax(0)

    local eternal_lumia = cutscene:spawnNPC("eternal_lumia", lumia.x - 96, lumia.y - 28)
    eternal_lumia.layer = layer + 1
    eternal_lumia:setParallax(0)

    local el_body = eternal_lumia.sprite.parts.body

    el_body.visible = false

    cutscene:text("* What is going on?!", nil, susie)
    cutscene:text("* KRIS![wait:4] WAKE UP!", nil, ralsei)

    cutscene:wait(0.5)

    cutscene:fadeIn(1)
    cutscene:wait(1)

    Assets.playSound("eternal lumia appear")

    local update = eternal_lumia.timer
    eternal_lumia.sprite.timer.update = function() end

    local fx = ColorMaskFX()

	el_body:addFX(fx)
    el_body:setScale(0)
    el_body:setScaleOrigin(1, 1)
    el_body.visible = true

    local t = Timer()

    t:tween(3, el_body, {scale_x = 1, scale_y = 1}, 'in-out-cubic', function()
        Assets.playSound("l_shard", 1, 1)
        Assets.playSound("l_shard", 1, 0.8)

        kris:shake(9, 9, 0.5)
        susie:shake(9, 9, 0.5)
        ralsei:shake(9, 9, 0.5)
        lumia:shake(9, 9, 0.5)
        eternal_lumia:shake(9, 9, 0.5)

        local fade_options = {
            color = {1, 1, 1},
            speed = 0.15
        }

        Game.world.fader.layer = eternal_lumia.layer + 25
        Game.world.fader:fadeOut(function() 
            el_body:removeFX(fx)

            Game.world.fader:fadeIn(fade_options)
        end, fade_options)

        for dx = -40, 60, 16 do
            for dy = 0, 140, 16 do
                local effect = Sprite("effects/eternal lumia/shard", eternal_lumia.x + dx - 48, eternal_lumia.y + dy - 128)
                effect:setParallax(0)
                effect:setOrigin(.5, .5)
                effect:setScale(math.random(2)) 
                effect.alpha = math.random() + .5
                effect.physics.gravity = math.random(1) * .1
                effect.physics.speed_y = -math.random(6, 9)
                effect.physics.speed_x = math.random(-3, 3)
                effect:play(2 / 30, true)
                effect.layer = eternal_lumia.layer + 1
                effect:shake(9, 9, 0.5)

                local t = Timer()
                local timer = math.random(2) / 2

                t:after(timer, function()
                    t:tween(0.32, effect, {alpha = 0}, nil, function()
                        effect:remove()
                    end)            
                end)

                effect:addChild(t)

                Game.world:addChild(effect)
            end
        end

    	t:remove()
    end)

    t:every(0.1, function()
    	local shard = Sprite("effects/eternal lumia/shard", math.random(-32, 96), math.random(-32, 96))
		shard:play(2 / 30, true)
    	shard:setScale(.5)
    	shard.alpha = 0
    	shard.layer = eternal_lumia.layer + 1
        shard:setParallax(0)

    	local t = Timer()
    	local scale = el_body.scale_x + 1

    	t:tween(0.75, shard, {x = 8 + (16 * math.abs(1 - el_body.scale_x)), y = 8 + (52 * math.abs(1 - el_body.scale_x)), alpha = 1, scale_x = scale, scale_y = scale}, 'in-cubic', function()
    		shard:remove()
    	end)

    	shard:addChild(t)
    	eternal_lumia:addChild(shard)

    	local shake_amount = el_body.scale_x * 2
    	local shake_x = shake_amount * math.random(-1, 1)
    	local shake_y = shake_amount * math.random(-1, 1)

    	kris:shake(shake_x, shake_y, 0.5)
        susie:shake(shake_x, shake_y, 0.5)
        ralsei:shake(shake_x, shake_y, 0.5)
    	eternal_lumia:shake(shake_x, shake_y, 0.5)
        lumia:shake(shake_x, shake_y, 0.5)
    	-- lumia:shake(shake_x, shake_y, 0.5)
    end)

    -- t:during(3, function()
    -- 	Game.world.camera:shake(el_body.scale_x * 16)
    -- end)

    eternal_lumia:addChild(t)

    cutscene:wait(5)

    t:remove()

    eternal_lumia.sprite:setHeadAnimation("open_mouth", 0.08, false)

    Assets.playSound("eternal lumia charge")

    local head = eternal_lumia.sprite.parts['head']
    local t = Timer()
    local to_remove = {}

    t:every(0.05, function()
        local radius = math.random(64, 96)
        local angle = math.rad(math.random(0, 360))

        local x = math.cos(angle) * radius
        local y = math.sin(angle) * radius
        local scale = math.random() + 0.5

        local effect = Sprite("effects/sparkle", x, y)
        effect:setScale(0)
        effect:setOrigin(.5)
        effect:setParallax(0)
        effect.alpha = 0
        effect.layer = eternal_lumia.layer + 1

        t:tween(0.8, effect, {x = 4, y = 4, alpha = 0.5, scale_x = scale, scale_y = scale}, 'in-out-circ', function()
            for k,v in ipairs(to_remove) do
                if v == effect then
                    table.remove(to_remove, k)
                    break
                end
            end

            effect:remove()
        end)

        eternal_lumia:addChild(effect)
        table.insert(to_remove, effect)
    end)

    local effect = Sprite("effects/sparkle", 4, 4)
    effect:setScale(0)
    effect:setOrigin(.5)
    effect:setParallax(0)
    effect.alpha = 0
    effect.layer = eternal_lumia.layer + 1

    local effect2 = Sprite("effects/sparkle", 6, 6)
    effect2:setScale(0)
    effect2:setOrigin(.5)
    effect2:setParallax(0)
    effect2.alpha = 0

    effect:addChild(effect2)

    t:tween(3, effect, {scale_x = 3, scale_y = 3, alpha = 0.5}, 'in-out-circ')
    t:tween(3, effect2, {scale_x = 2, scale_y = 2, alpha = 0.5}, 'in-out-cubic')

    t:after(1.5, function()
        local effect2 = Ellipse(6, 6, 0, 0)
        effect2:setOrigin(.5)
        effect2:setParallax(0)
        effect2.line = true
        effect2.line_width = 6
        effect2.alpha = 0.25

        effect:addChild(effect2)

        t:tween(1, effect2, {width = 32, height = 32, line_width = 0, alpha = 0.75}, 'in-out-sine', function()
            effect2:remove()
        end) 
    end)

    eternal_lumia:addChild(effect)

    eternal_lumia:addChild(t) 

    cutscene:wait(3.25)

    t:remove()

    Assets.playSound("noise")

    kris.layer = 1001
    eternal_lumia.layer = kris.layer
    lumia.layer = kris.layer

    local black = Rectangle(0, 0, 640, 480)
    black:setParallax(0)
    black.color = {0, 0, 0}
    black.alpha = 0.75
    
    Game.world:spawnObject(black, 1000)
    
    local soul = Sprite("player/heart_dodge", kris.x + 150, lumia.y - lumia.height - 109)
    soul:setParallax(0)
    soul.color = {1, 0, 0}
    
    local soulFlash = FlashFade("player/heart_dodge", 0, 0)
    soul:addChild(soulFlash)
    
    Game.world:spawnObject(soul, 1001)

    cutscene:wait(0.5)
    
    Assets.playSound("greatshine", 1, 0.8)
    Assets.playSound("greatshine", 1, 1)
    Assets.playSound("closetimpact", 1, 1.5)
    
    soul.color = {0,192 / 255,0}

    local soulFlash = FlashFade("player/heart_dodge", 0, 0)
    soul:addChild(soulFlash)
    
    SoulFlash(soul, 0.1, 0.075)
    SoulFlash(soul, 0.25, 0.05)
    
    local shake = 6

    kris:shake(shake)
    susie:shake(shake)
    ralsei:shake(shake)
    eternal_lumia:shake(shake)
    lumia:shake(shake)

    cutscene:wait(1)

    Assets.playSound("spearappear")
    
    local greensoul = GreenSoul(10, 10)
    greensoul:setScale(0)
    greensoul.sprite:remove()
    greensoul.can_defend = false

    local t = Timer()

    t:tween(0.5, greensoul, {scale_x = 1, scale_y = 1}, 'out-sine', function()
        greensoul.can_defend = true
    end)

    soul:addChild(t)
    soul:addChild(greensoul)

    local text

    t:after(1.5, function()
        text = SimpleText("Press [RIGHT]", -32, -48)
        text.alpha = 0
        text:setScale(0.5)

        soul:addChild(text)
        t:tween(0.25, text, {alpha = 0.5}, 'out-sine')
    end)

    cutscene:wait(function()
        if Input.down('right') then
            t:remove()

            if text then text:remove() end

            for k,v in ipairs(to_remove) do
                v:remove()
            end

            to_remove = nil
            greensoul.can_defend = false
            -- lumia.sprite:resume()
            black:remove()
            effect:remove()
            Assets.playSound("noise")
            -- for k,particle in ipairs(absorber.particles) do
            --     particle:remove()
            -- end
            
            -- absorber:remove()
            -- flash:remove()
            
            return true
        end
    end)

    cutscene:wait(0.1)

    Assets.playSound("eternal lumia laser")

    local white = Rectangle(0, 0, 640, 480)
    white:setParallax(0)
    white.color = {1, 1, 1}
    white.alpha = 0.5
    white.layer = 1500

    Game.world:addChild(white)

    local effect = Sprite("effects/eternal lumia/laser", soul.x + 36, soul.y - 2)
    effect:setOrigin(0, 0.5)
    effect:setParallax(0)
    effect:setScale(1, 1.1)
    effect.layer = eternal_lumia.layer + 4

    Game.world:addChild(effect)

    greensoul.shield:resolveBulletCollision()

    local shake = 9

    kris:shake(shake)
    susie:shake(shake)
    ralsei:shake(shake)
    eternal_lumia:shake(shake)
    lumia:shake(shake)
    effect:shake(-shake)
    soul:shake(shake)

    local t = Timer()

    t:tween(0.36, effect, {scale_y = 0}, 'out-cubic', function()
        effect:remove()
    end)

    t:tween(0.25, white, {alpha = 0}, nil, function()
        white:remove()
    end)

    soul:addChild(t)

    cutscene:wait(0.75)

    Assets.playSound("spearappear")
    soul.layer = kris.layer + 1

    t:tween(1, soul, {x = kris.x, y = kris.y - kris.height, scale_x = 0, scale_y = 0}, 'out-sine')
    t:tween(0.5, greensoul, {scale_x = 0, scale_y = 0}, 'in-out-circ', function()
        greensoul:remove()
        greensoul = nil
    end)

    t:every(0.05, function()
        if greensoul then
            SoulTrail(soul)
        end
    end)

    
    Assets.playSound("wing")
    
    cutscene:setSprite(kris, "sit")
    kris:shake(4)

    susie:resetSprite()
    susie:setFacing('right')
    susie:shake(4)
    
    ralsei:resetSprite()
    ralsei:setFacing('right')

    cutscene:wait(0.5)
    eternal_lumia.sprite:setHeadAnimation("close_mouth", 0.08, false, function()
        eternal_lumia.sprite:setHeadAnimation()
    end)

    kris:resetSprite()
    kris:setFacing('right')

    cutscene:wait(0.5)

    cutscene:text("* YOUR SsSOUL TRIESsS TO PROTECT ITSsSELF IN ANY WAY POSsSIBLE...", nil, lumia)
    cutscene:text("* BUT NOBODY WILL SsSAVE YOU IN THE FUTURE, BECAUSsE YOU'LL FAIL EVERYONE.", nil, lumia)
    cutscene:text("* And the consequences of your actions came down to this.", nil, lumia)
    cutscene:text("* LET ME REVEAL MY[wait:6] GRAND ILLUSsSION!", nil, lumia)

    eternal_lumia.sprite:setHeadAnimation("talk")

    local shake = 6

    kris:shake(shake, shake)
    susie:shake(shake, shake)
    ralsei:shake(shake, shake)
    eternal_lumia:shake(shake, shake)
    lumia:shake(shake, shake)

    Assets.playSound("eternal lumia laugh", 1, 0.5)
    Assets.playSound("eternal lumia laugh")
    Assets.playSound("eternal lumia laugh", 1, 1.3)

    cutscene:wait(1)

    local black = Rectangle(0, 0, 640, 480)
    black:setParallax(0)
    black.color = {0, 0, 0}
    black.alpha = 0
    
    Game.world:spawnObject(black, 1009)

    t:tween(0.5, black, {alpha = 1})

    cutscene:wait(1.5)

    cutscene:endCutscene()
    startEncounter(cutscene)
end