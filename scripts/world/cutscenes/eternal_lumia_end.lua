return {
	mercy = function(cutscene, event, player, facing)
		cutscene:loadMap("abandoned_scene")

		local rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		rect.color = {0, 0, 0}
		rect.layer = 500

		Game.world:addChild(rect)

		cutscene:wait(2)

	    local kris = cutscene:getCharacter("kris")
	    local susie = cutscene:getCharacter("susie")
	    local ralsei = cutscene:getCharacter("ralsei")
	   	susie:setFacing('down')
	   	ralsei:setFacing('down')

	    cutscene:detachFollowers()
	    cutscene:setTextboxTop(false)

	    cutscene:text("* Kris...[wait:12] Are you sleeping or something?", nil, susie)

	    cutscene:wait(0.5)

	    local lumia = cutscene:getCharacter("lumia")
	    kris:setPosition(lumia.x + 12, lumia.y - 9)
	    cutscene:setSprite(kris, "fell")

	    ralsei:setPosition(550, 690)
	    susie:setPosition(450, 720)

	    lumia:remove()

	    rect:fadeOutAndRemove(2)
	    Assets.playSound("noise")

	    cutscene:wait(2)

	    Assets.playSound("wing")
	    
	    cutscene:setSprite(kris, "sit")
	    kris:shake(4)

	    cutscene:wait(0.5)

	    kris:resetSprite()
	    kris:setFacing('up')

	    cutscene:wait(0.5)

	    cutscene:text("* Finally![wait:8] What's gotten into you?", "sincere_smile", susie)
	    cutscene:text("* Kris,[wait:4] did you have a nice dream?", "surprise_smile", ralsei)

	    local choice = cutscene:choicer({"It was a\nnightmare", "..."})

	    if choice == 1 then
	   		cutscene:text("* Oh...", "frown", ralsei)
	   		cutscene:text("* Well,[wait:4] everything is fine now,[wait:4] isn't it?", "small_smile_side", ralsei)	
		end

	    cutscene:setSprite(susie, "away")
	    cutscene:text("* ...", "shy_down", susie)
	    cutscene:text("* Not gonna lie,[wait:6] this place feels... Off.", "shy_down", susie)
	    cutscene:text("* Let's just get out of here.", "annoyed_down", susie)
	    susie:resetSprite()

	    cutscene:interpolateFollowers()
	    cutscene:attachCamera()
	    cutscene:attachFollowers()

	    cutscene:text("* (You felt a dark pressence in your pocket.)")
	    Assets.playSound("item")
	    cutscene:text("* (You got MagicCloak.)")
	    cutscene:wait(0.1)
	    Assets.playSound("shadowcrystal")
	    cutscene:text("* (You got ShadowCrystal.)")

		cutscene:endCutscene()
	end,

	fight = function(cutscene, event, player, facing)
		cutscene:loadMap("abandoned_scene")

		local rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		rect.color = {0, 0, 0}
		rect.layer = 500

		Game.world:addChild(rect)

		cutscene:wait(2)

	    local kris = cutscene:getCharacter("kris")
	    local susie = cutscene:getCharacter("susie")
	    local ralsei = cutscene:getCharacter("ralsei")
	    
	    cutscene:detachFollowers()
	    cutscene:setTextboxTop(false)

	    cutscene:text("* Kris...[wait:12] Are you sleeping or something?", nil, susie)

	    cutscene:wait(0.5)

	    local lumia = cutscene:getCharacter("lumia")
	    kris:setPosition(lumia.x + 12, lumia.y - 9)
	    cutscene:setSprite(kris, "fell")

	    ralsei:setPosition(550, 690)
	    susie:setPosition(450, 720)

	    lumia:remove()

	    rect:fadeOutAndRemove(2)
	    Assets.playSound("noise")

	    cutscene:wait(2)

	    Assets.playSound("wing")
	    
	    cutscene:setSprite(kris, "sit")
	    kris:shake(4)

	    cutscene:wait(0.5)

	    kris:resetSprite()
	    kris:setFacing('up')

	    cutscene:wait(0.5)

	    cutscene:text("* Finally![wait:8] What's gotten into you?", "sincere_smile", susie)
	    cutscene:text("* Kris,[wait:4] did you have a nice dream?", "surprise_smile", ralsei)

	    local choice = cutscene:choicer({"It was great", "It was great"})

	    cutscene:text("* You sure?[wait:6] You look annoyed...", "surprise_neutral", ralsei)
	    cutscene:setSprite(susie, "away")
	    cutscene:text("* ...", "shy_down", susie)
	    cutscene:text("* Not gonna lie,[wait:6] this place feels... Off.", "shy_down", susie)
	    cutscene:text("* Let's just get out of here.", "annoyed_down", susie)
	    susie:resetSprite()

	    cutscene:interpolateFollowers()
	    cutscene:attachCamera()
	    cutscene:attachFollowers()

	    cutscene:text("* (You felt a dark pressence in your pocket.)")
	    Assets.playSound("item")
	    cutscene:text("* (You got HauntCam.)")
	    cutscene:wait(0.1)
	    Assets.playSound("shadowcrystal")
	    cutscene:text("* (You got ShadowCrystal.)")

		cutscene:endCutscene()
	end,
}