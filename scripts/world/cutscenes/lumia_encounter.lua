return function(cutscene, event, player, facing)
    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
	
    cutscene:detachFollowers()
    cutscene:detachCamera()
	cutscene:setTextboxTop(false)
	
	local lumia = cutscene:spawnNPC("lumia", 660 + 480, 310)
	lumia:setSprite('ghost')

	do
		local t = 1
		local x = 660
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

	local appear_x, appear_y = lumia:getRelativePos(0, 0, lumia)
	local effect = ReverseNotFatalEffect("npcs/lumia/sad", appear_x, appear_y)
	effect:setColor(lumia:getDrawColor())
	effect:setScale(lumia:getScale())
	effect.layer = lumia.layer + 1
	lumia.visible = false
	
	Game.world:addChild(effect)

	cutscene:text("* What a poor world,[wait:4] living in fantasies.", nil, lumia)
	cutscene:text("* Constantly in hopes of seeing a new light in their life.", nil, lumia)
	cutscene:text("* A light which will open a gate of new truths and meanings.", nil, lumia)
	cutscene:text("* ... But worry not,[wait:4] fellow audience.", nil, lumia)
	cutscene:text("* Because that new light of life is...", nil, lumia)
	
	lumia:setAnimation('idle')
	
	Game.world.music:play("lumia")
	
	cutscene:text("* ME!!![wait:4] LUMIA!!", nil, lumia)
	cutscene:text("* Uhh... Who the HELL are you?", 'suspicious', susie)
	
	Game.world.music:stop()
	
	cutscene:wait(0.5)
	
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
	cutscene:text("* WELL,[wait:4] LET'S SsSEE IF YOU FULFILL THE ROLE OF HEROESsS,[wait:6] SsSHALL WE?", nil, lumia)
	
	Assets.playSound('lumia battle start', 2)
	
	local fader = Rectangle(320, 0, Game.world.width, Game.world.height)
	fader.alpha = 0
	fader.color = {0, 0, 0}
	
	Game.world:spawnObject(fader, kris.layer - 0.001)
	
	local timer = Timer()
	Game.world:spawnObject(timer)
	
	timer:tween(0.75, fader, {alpha = 0.75}, 'out-sine')
	
	cutscene:wait(1)
		
	cutscene:startEncounter('lumia', nil, lumia)
end