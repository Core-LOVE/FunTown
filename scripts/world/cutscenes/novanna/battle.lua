return function(cutscene)
	Game.world.fader.alpha = 1
	
    cutscene:detachFollowers()
	
	local kris = cutscene:getCharacter("kris")
	local susie = cutscene:getCharacter("susie")
	
	kris.x = -64
	kris.y = 128
	
	susie.x = -96
	susie.y = 128
	
	cutscene:fadeIn(2)
	
	kris:setFacing('right')
	susie:setFacing('right')
		
	cutscene:slideTo(kris, 96, 192, 4, 'out-circ')
	cutscene:slideTo(susie, 160, 300, 4, 'out-circ')
	
	cutscene:wait(4)
	
	cutscene:text("* Hey,[wait:4] look down!", 'surprise_smile', susie)
	cutscene:text("* We're pretty high in the sky,[wait:4] huh?", 'smile', susie)
	cutscene:text("* ... I wonder Novanna escaped already.", 'smile', susie)
	
	local novanna = cutscene:spawnNPC("novanna", 640, 240)
	cutscene:slideTo(novanna, 500, 300, 2)
	
	cutscene:wait(2)
	
	Game.world.music = Music("novanna")
	cutscene:text("* hi-hi-hi!!", 'happy', novanna)
	cutscene:text("* didn't expect for you to care about me uwu", 'uwu', novanna)
	cutscene:text("* did you need something? owo", 'owo', novanna)
	
	cutscene:text("* Yeah,[wait:6] actually I needed you.", 'neutral', susie)
	cutscene:text("* ... So you could give over Toriel.", 'teeth', susie)
	
	cutscene:text("* wwwwwwwww!!!", 'happy', novanna)
	
	cutscene:wait(99)
end