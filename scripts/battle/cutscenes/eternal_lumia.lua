local wave_shader = love.graphics.newShader([[
        extern number wave_sine;
        extern number wave_mag;
        extern number wave_height;
        extern vec2 texsize;
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
            number i = texture_coords.y * texsize.y;
            vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
            return Texel(texture, coords) * color;
        }
    ]])

return {
	mercy = function(cutscene, enemy)
		cutscene:wait(function()
			return Game.battle.battle_ui.encounter_text.text.text == ""
		end)

		Game.battle.music:stop()

		if Game.world and Game.world.map and Game.world.map.spin_speed then
			Game.world.map.timer:tween(0.5, Game.world.map, {spin_speed = 0}, 'in-out-sine')
		end

		enemy.sprite.timer:remove()
		Game.battle.timer:tween(0.5, enemy.sprite.parts.reel.graphics, {spin = 0}, 'out-sine')

		local lumia = cutscene:getCharacter("lumia")

		lumia:setSprite("dark")

		local susie = cutscene:getCharacter("susie")
		susie:resetSprite()

		local ralsei = cutscene:getCharacter("ralsei")
		ralsei:resetSprite()

		cutscene:wait(2)
	
		Assets.playSound("ghostappear")

		local fx = ColorMaskFX({1, 1, 1}, 0, 1)

		enemy.sprite.parts.body:addFX(fx)

		Game.battle.timer:tween(0.5, fx, {amount = 1}, 'out-expo')

		cutscene:wait(1)

		Assets.playSound("ghostappear")
		Assets.playSound("ghostappear", 0.5, 0.5)

		local body = enemy.sprite.parts.body

		body:setOrigin(1, 1)
		body.x = body.x + body.width
		body.y = body.y + body.height

		Game.battle.timer:tween(2, enemy.sprite.parts.body, {scale_x = 0, scale_y = 0, x = body.x - 3}, 'in-out-sine', function()
			local sparkle = Sprite("effects/sparkle", 548, 220)
			sparkle:setOrigin(0.5)
			sparkle:setScale(0)
			sparkle.layer = enemy.sprite.layer + 1000
			sparkle.rotation = math.rad(45)

			Game.battle.timer:tween(0.25, sparkle, {scale_x = 2, scale_y = 2}, nil, function()
				Game.battle.timer:tween(0.5, sparkle, {scale_x = 0, scale_y = 0}, nil, function()
					sparkle:remove()
				end)
			end)

			Game.battle:addChild(sparkle)
		end)

		cutscene:wait(4)

		cutscene:battlerText(lumia, "...")
		cutscene:battlerText(lumia, "SsSO THISsS\nISsS IT?")
		cutscene:battlerText(lumia, "HAHA![wait:8] YOU ARE\nMUCH SsSTRONGER THAN I\nTHOUGHT!")
		cutscene:battlerText(lumia, "SsSO THAT'S HOW\nYOU MANAGED TO GET THISsS\nFAR...")		
		cutscene:battlerText(lumia, "A BIG FUTURE ISsS\nAHEAD OF YOU.")	
		cutscene:battlerText(lumia, "AND YOU CAN\nKEEP IT!")		
		cutscene:battlerText(lumia, "ASsS FOR ME...")	
		cutscene:battlerText(lumia, "WELL,[wait:4] IT DOESsSN'T\nMATTER...\n[wait:6]HAHA.")
		cutscene:battlerText(lumia, "After all,[wait:8] I don't\neven exist.")


		Assets.playSound("eternal lumia defeat")

		local mag = 0
		local height = 6

		local shaderfx = ShaderFX(wave_shader, {
			["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT},
	        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
	        ["wave_mag"] = function () return mag end,
	        ["wave_height"] = function () return height end,
		})

		Game.battle:addFX(shaderfx)
		Game.world:addFX(shaderfx)

		local recolorfx = RecolorFX(1, 1, 1, 1, 1)
		Game.battle:addFX(recolorfx)
		Game.world:addFX(recolorfx)

		local t = Timer()

		t:tween(5, recolorfx, {color = {0, 0, 0.5, 0.5}})

		Game.world:addChild(t)

		cutscene:wait(function()
			mag = mag + 0.1
			height = height - 0.01

			if mag > 16 then
				return true
			end

			if height < 1 then
				height = 1
			end
		end)

		cutscene:fadeOut(1, {
			color = {0, 0, 0}
		})

		cutscene:wait(3)

		t:remove()
		Game.battle:removeFX(recolorfx)
		Game.battle:removeFX(shaderfx)
		Game.world:removeFX(recolorfx)
		Game.world:removeFX(shaderfx)

		Game.battle:returnToWorld()
		Game.world:startCutscene("eternal_lumia_end", "mercy")
	end,

	fight = function(cutscene, enemy)
		local rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		rect:setParallax(0)
		rect.alpha = 0
		rect.layer = BATTLE_LAYERS.battlers - 1
		Game.battle:addChild(rect)

		Game.battle.music:stop()

		if Game.world and Game.world.map and Game.world.map.spin_speed then
			Game.world.map.timer:tween(0.5, Game.world.map, {spin_speed = 0}, 'in-out-sine')
		end

		cutscene:wait(2)

		local lumia = cutscene:getCharacter("lumia")
		lumia:setSprite("dark")

		local susie = cutscene:getCharacter("susie")
		susie:resetSprite()

		local ralsei = cutscene:getCharacter("ralsei")
		ralsei:resetSprite()

		local delay = 0

		enemy.sprite.reelSpin = function() end
		enemy.sprite.parts.reel.spin = 0

		for i = 1, 8 do
			cutscene:shakeCamera(4 + delay)

            local dmg_sprite = Sprite("effects/attack/cut")
            dmg_sprite:setOrigin(0.5, 0.5)
            dmg_sprite:setScale(2.5, 2.5)

            dmg_sprite:setPosition(enemy:getRelativePos(enemy.width/2, enemy.height/2))
            dmg_sprite.layer = enemy.layer + 0.01
            dmg_sprite:play(1/15, false, function(s) s:remove() end)
            enemy.parent:addChild(dmg_sprite)

	        local src = Assets.stopAndPlaySound("scytheburst")
			Assets.stopAndPlaySound("criticalswing")

			local kris = cutscene:getCharacter("kris")
			kris:shake(2 + delay)
			kris:setAnimation("battle/attack")

			enemy:expose(false)
			enemy:shake(4 + delay)

			local scale = enemy.sprite.parts.body.scale_x - 0.1
			local alpha = enemy.sprite.parts.body.alpha - 0.1

			enemy.sprite.parts.body:setScaleOrigin(1, 1)
			enemy.sprite.timer:tween(0.5, enemy.sprite.parts.body, {scale_x = scale, scale_y = scale, alpha = alpha}, 'out-sine')

			delay = delay + 1
			local wait = 2 - (delay * 0.25)

			cutscene:wait(wait)
		end

        Assets.playSound("l_shard", 1, 1)
        Assets.playSound("l_shard", 1, 0.8)

        Game.fader.color = {1, 1, 1}
        Game.fader.alpha = 1

		cutscene:fadeIn(1, {
			color = {1, 1, 1},
		})

		enemy.sprite.parts.body.visible = false
		
        for dx = -40, 60, 16 do
            for dy = 0, 140, 16 do
                local effect = Sprite("effects/eternal lumia/shard", enemy.x + dx - 48, enemy.y + dy - 128)
                effect:setParallax(0)
                effect:setOrigin(.5, .5)
                effect:setScale(math.random(2)) 
                effect.alpha = math.random() + .5
                effect.physics.gravity = math.random(1) * .1
                effect.physics.speed_y = -math.random(6, 9)
                effect.physics.speed_x = math.random(-3, 3)
                effect:play(2 / 30, true)
                effect.layer = enemy.layer + 1
                effect:shake(9, 9, 0.5)

                local t = Timer()
                local timer = math.random(2) / 2

                t:after(timer, function()
                    t:tween(0.32, effect, {alpha = 0}, nil, function()
                        effect:remove()
                    end)            
                end)

                effect:addChild(t)

                Game.battle:addChild(effect)
            end
        end

		cutscene:wait(2)

		cutscene:battlerText(lumia, "...")
		cutscene:battlerText(lumia, "HA...")
		cutscene:battlerText(lumia, "HAHA.")
		cutscene:battlerText(lumia, "HAHAHAHAHAHA!")	
		cutscene:battlerText(lumia, "CONGRATULATIONSsS!")		
		cutscene:battlerText(lumia, "YOU BROKE MY\nILLUSsSION.")
		cutscene:battlerText(lumia, "... BUT IT DOESsSN'T\nMATTER.")		
		cutscene:battlerText(lumia, "I ALREADY BROKE\nYOU.")
		cutscene:battlerText(lumia, "YOUR LIFE\nIS COVERED IN LIESsS.")	
		cutscene:battlerText(lumia, "AND THE ONLY THING\n[wait:8]YOU CAN DO...")
		cutscene:battlerText(lumia, "IS TO ACT LIKE\nA WILD ANIMAL!")		

		Assets.playSound("eternal lumia defeat")

		local mag = 0
		local height = 6

		local shaderfx = ShaderFX(wave_shader, {
			["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT},
	        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
	        ["wave_mag"] = function () return mag end,
	        ["wave_height"] = function () return height end,
		})

		Game.battle:addFX(shaderfx)
		Game.world:addFX(shaderfx)

		local recolorfx = RecolorFX(1, 1, 1, 1, 1)
		Game.battle:addFX(recolorfx)
		Game.world:addFX(recolorfx)

		local t = Timer()

		t:tween(5, recolorfx, {color = {0, 0, 0.5, 0.5}})

		Game.world:addChild(t)

		cutscene:wait(function()
			mag = mag + 0.1
			height = height - 0.01

			if mag > 16 then
				return true
			end

			if height < 1 then
				height = 1
			end
		end)

		cutscene:fadeOut(1, {
			color = {0, 0, 0}
		})

		cutscene:wait(3)

		t:remove()
		Game.battle:removeFX(recolorfx)
		Game.battle:removeFX(shaderfx)
		Game.world:removeFX(recolorfx)
		Game.world:removeFX(shaderfx)

		Game.battle:returnToWorld()
		Game.world:startCutscene("eternal_lumia_end", "fight")
		-- cutscene:endCutscene()
		-- cutscene:wait(999)
	end
}