local function moveCharacter(t, character, distance, time)
	local time = time or 0.5
	local distance = distance or 4
	
	t:tween(time, character, {y = character.y + distance}, 'in-sine', function()
		t:tween(time, character, {y = character.y - distance}, 'in-sine', function()
			moveCharacter(t, character, distance)
		end)
	end)
end

local function addBallon(character)
	local t = Timer()
	
	local transport = Sprite("other/ballon_bottom_novanna", -character.width * .5, character.height - 6)
	character:addChild(transport)    
	
	local ballon = Sprite("other/ballon_novanna", -(character.width * .5) + 8, -character.height * 1.64)
	character:addChild(ballon) 
	
	character.parts = {}
	
	table.insert(character.parts, ballon)
	table.insert(character.parts, transport)
	
	do
		local line = Line(ballon.x, ballon.y + 32, transport.x + 8, transport.y + character.height)
		line.layer = ballon.layer + 1
		line.color = {0, 0, 0}
		Utils.hook(line, 'update', function(orig, _)
			orig(line)
			line.y = ballon.y + 32
		end)
		
		character:addChild(line)
		table.insert(character.parts, line)
	end
	
	do
		local line = Line(ballon.x + 64, ballon.y + 32, transport.x + 19, transport.y + character.height)
		line.layer = ballon.layer + 1
		line.color = {0, 0, 0}
		Utils.hook(line, 'update', function(orig, _)
			orig(line)
			line.y = ballon.y + 32
		end)
		
		character:addChild(line)
		table.insert(character.parts, line)
	end
	
	local index = 1
	
	moveCharacter(t, character, nil, index / 3)
	moveCharacter(t, ballon, -2, index / 3)	
	
	Game.world:addChild(t)
end

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
		
	cutscene:slideTo(kris, 96, 192, 2, 'out-circ')
	cutscene:slideTo(susie, 160, 300, 2, 'out-circ')
	
	cutscene:wait(2)
	
	cutscene:text("* Hey,[wait:4] look down!", 'surprise_smile', susie)
	cutscene:text("* We're pretty high in the sky,[wait:4] huh?", 'smile', susie)
	cutscene:text("* ... I wonder if Novanna escaped already.", 'suspicious', susie)
	
	local novanna = cutscene:spawnNPC("novanna", 640, 240)
	addBallon(novanna)
	cutscene:slideTo(novanna, 500, 300, 2)
	
	cutscene:wait(2)
	
	Game.world.music = Music("novanna")
	cutscene:text("* hi-hi-hi!![react:sus]", 'happy', novanna, {
		reactions = {
			sus = {"Oh nevermind.", "right", "bottom", "suspicious", susie},
		}
	})
	cutscene:text("* didn't expect for you to care about me uwu", 'uwu', novanna)
	cutscene:text("* did you need something? owo", 'owo', novanna)
	
	cutscene:text("* Yeah,[wait:6] actually I needed you.", 'neutral', susie)
	cutscene:text("* ... So you could give over Toriel.", 'teeth', susie)
	
	cutscene:text("* wwwwwwwww!!!", 'happy', novanna)
	
	cutscene:wait(99)
end