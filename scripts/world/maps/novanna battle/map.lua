local MyMap, super = Class(Map)

local function moveCharacter(t, character, distance, time)
	local time = time or 0.5
	local distance = distance or 4
	
	t:tween(time, character, {y = character.y + distance}, 'in-sine', function()
		t:tween(time, character, {y = character.y - distance}, 'in-sine', function()
			moveCharacter(t, character, distance)
		end)
	end)
end

function MyMap:initCharacters()
	local chars = {'kris', 'susie'}
	local t = Timer()
	
	for index, character in ipairs(chars) do
		local character = Game.world:getCharacter(character)
		
		local transport = Sprite("other/ballon_bottom", -character.width * .5, character.height - 12)
		character:addChild(transport)    
		
		local ballon = Sprite("other/ballon_" .. ((index == 1 and 'kris') or 'susie'), 0, -character.height * .75)
		ballon.onCollide = function(other)
			if other.id == "bag" then
				ballon.visible = false
			end
		end
		
		character:addChild(ballon) 
		
		do
			local line = Line(ballon.x, ballon.y + 16, transport.x + 8, transport.y + character.height * .5)
			line.layer = ballon.layer + 1
			line.color = {0, 0, 0}
			Utils.hook(line, 'update', function(orig, _)
				orig(line)
				line.y = ballon.y + 16
			end)
			
			character:addChild(line)
		end
		
		do
			local line = Line(ballon.x + 32, ballon.y + 16, transport.x + 16, transport.y + character.height * .5)
			line.layer = ballon.layer + 1
			line.color = {0, 0, 0}
			Utils.hook(line, 'update', function(orig, _)
				orig(line)
				line.y = ballon.y + 16
			end)
			
			character:addChild(line)
		end
		
		moveCharacter(t, character, nil, index / 3)
		moveCharacter(t, ballon, -2, index / 3)	
	end
	
	Game.world.stage:addChild(t)
end

function MyMap:onEnter()
	super.onEnter(self)
	self:initCharacters()
	
	-- Game.world:startCutscene("novanna/battle", self):after(function()
		
	-- end)
end

return MyMap