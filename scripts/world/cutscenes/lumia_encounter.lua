return function(cutscene, event, player, facing)
    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
	
    cutscene:detachFollowers()
    cutscene:detachCamera()
	cutscene:setTextboxTop(false)
	
	local lumia = cutscene:spawnNPC("lumia", 660 + 480, 310)
	lumia:setSprite("cloth")

	do
		local t = 1
		local x = 680
		local y = 390

		kris:setFacing('right')
		susie:setFacing('right')
		ralsei:setFacing('right')

		cutscene:panTo(x + 260, 335, 1)

		cutscene:walkTo(kris,  x + 8, y - (kris.height * 4) - 4, t, nil, true)
		cutscene:walkTo(susie, x + 4, y - (kris.height * 2) - 16, t, nil, true)
		cutscene:walkTo(ralsei, x, y - (kris.height * 1), t, nil, true)
		cutscene:wait(t + 0.25)
	end

	cutscene:wait(0.5)

	if not Mod.flags.encounter then
		cutscene:text("* Uhh...[wait:8] Kris,[wait:4] why did you stop?", 'suspicious', susie)
		cutscene:text("* Is anything wrong?", 'suspicious', susie)
		cutscene:text("* Kris,[wait:4] there's nothing on our path...", 'frown_b', ralsei)
	end

	Assets.playSound("ghostappear", 1, 1.5)

	lumia:shake(2, 0)
	lumia:setAnimation('appear')
	
	cutscene:wait(0.75)

	if not Mod.flags.encounter then
		Game.world.music:play("lumia", 1)
		
		cutscene:text("* HEY GUYSsS!", nil, lumia)
		cutscene:text("* MY NAME ISsS[wait:4] LUMIA!", nil, lumia)
		cutscene:text("* OH RIGHT,[wait:4] HAHAHA,[wait:4] YOUR FRIENDSsS CAN'T SsSEE ME!", nil, lumia)
		cutscene:text("* HOLD ON.", nil, lumia)

		local old_x, old_y = lumia.x, lumia.y

		cutscene:walkTo(lumia, kris.x + 160, kris.y + 20, 0.5)
		cutscene:wait(0.5)

		lumia:setAnimation("on")

		cutscene:wait(0.75)
		Assets.playSound("camera")

		cutscene:wait(0.75)

		lumia:setAnimation("world_off")

		cutscene:wait(0.5)

		cutscene:text("* HAHA!! GOLLY,[wait:4] YOUR FACE IS SO FUNNY ON THIS PHOTO!", nil, lumia)
		cutscene:text("* ANYWAYSsS", nil, lumia)

		cutscene:walkTo(lumia, old_x, old_y, 0.5)
		cutscene:wait(0.5)

		cutscene:text("* NAME'SsS LUMIA![wait:6] I'M JUST A SIMPLE ILLUSsSIONISsST!", nil, lumia)
		cutscene:text("* I MAKE PEOPLE HAPPIER BY LETTING THEM SsSEE MY LIESsS!", nil, lumia)
		cutscene:text("* BUT TRUSsST ME ON THIS,[wait:4] KRISsS,[wait:4] THISsS ISsS FAR FROM MY FULL POTENTIAL!", nil, lumia)
		cutscene:text("* THE THING ISsS...", nil, lumia)

		Game.world.music:pause()
		lumia:setSprite("sad")
		cutscene:text("* I'm not as alive as before.", nil, lumia)
		Game.world.music:resume()

		lumia:setSprite("idle")
		cutscene:text("* AND I DON'T CARE!!", nil, lumia)
		cutscene:text("* BECAUSsSE I'M STILL ALIVE IN YOUR MEMORY!", nil, lumia)
		cutscene:text("* THANKSsS TO YOU,[wait:4] I EXISsST!", nil, lumia)

		Game.world.music:pause()
		lumia:setSprite("sad")
		cutscene:text("* But...[wait:6] What's the point if nobody else sees me?", nil, lumia)
		Game.world.music:resume()

		lumia:setSprite("idle")
		cutscene:text("* ANYWAYSsS", nil, lumia)
		cutscene:text("* WHY NOT HAVE A HEART-TO-HEART TALK AFTER SsSO MANY YEARSsS OF ABANDONMENT?", nil, lumia)

		cutscene:text("* (Psst,[wait:4] want me to do something?)", 'shy', susie)
		cutscene:text("* (Huh,[wait:6] you want me to hit this empty spot?)", 'surprise', susie)
		
		Game.world.music:stop()
		
		cutscene:wait(0.25)
		
		susie:setAnimation('battle/rude_buster')
		
		do
			local rudeBuster = Game.world:spawnObject(RudeBusterBeam(false, susie.x, susie.y - (susie.height * .5), lumia.x, lumia.y - lumia.height))
			
			cutscene:wait(.42)
		end
		
		lumia:shake(8)
		lumia:setAnimation('hurt')
		
		cutscene:wait(1)
		lumia:setAnimation('idle')
		
		cutscene:text("* OH.", nil, lumia)
		cutscene:text("* I see now.", nil, lumia)
		cutscene:text("* WELL,[wait:4] LET'S SsSEE IF YOU FULFILL THE ROLE OF HERO,[wait:6] SsSHALL WE?", nil, lumia)
	end
	
	Assets.playSound('lumia battle start', 2)
	
	local fader = Rectangle(320, 0, Game.world.width, Game.world.height)
	fader.alpha = 0
	fader.color = {0, 0, 0}
	
	Game.world:spawnObject(fader, kris.layer - 0.001)
	
	local timer = Timer()
	Game.world:spawnObject(timer)
	
	timer:tween(0.75, fader, {alpha = 0.75}, 'out-sine')
	
	cutscene:wait(1)
		
	Mod.flags.encounter = true

	cutscene:startEncounter('lumia', nil, lumia)

	Mod.flags.encounter = false
end