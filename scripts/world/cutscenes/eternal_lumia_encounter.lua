return function(cutscene, event, player, facing)
    cutscene:detachFollowers()

    Game.world.music:stop()

	local black = Rectangle(0, 0, 640, 480)
	black.color = {0, 0, 0}
	black.parallax_x = 0
	black.parallax_y = 0
	black.layer = WORLD_LAYERS.below_textbox + 50

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

    local eternal_lumia = cutscene:spawnNPC("eternal_lumia", lumia.x - 96, lumia.y - 28)
    eternal_lumia.layer = layer + 1

    local el_body = eternal_lumia.sprite.parts.body

    el_body.visible = false

    cutscene:wait(2)

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

        Game.world.camera:shake(9, 9, 0.5)

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
                effect:setOrigin(.5, .5)
                effect:setScale(math.random(2)) 
                effect.alpha = math.random() + .5
                effect.physics.gravity = math.random(1) * .1
                effect.physics.speed_y = -math.random(6, 9)
                effect.physics.speed_x = math.random(-3, 3)
                effect:play(2 / 30, true)
                effect.layer = eternal_lumia.layer + 1

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

    	Game.world.camera:shake(shake_x, shake_y, 0.5)
    	eternal_lumia:shake(shake_x, shake_y, 0.5)
    	-- lumia:shake(shake_x, shake_y, 0.5)
    end)

    -- t:during(3, function()
    -- 	Game.world.camera:shake(el_body.scale_x * 16)
    -- end)

    eternal_lumia:addChild(t)
end