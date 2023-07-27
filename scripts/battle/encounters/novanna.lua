local MyEncounter, super = Class(Encounter)

local function moveCharacter(t, character, distance, time)
	local time = time or 0.5
	local distance = distance or 4
	
	t:tween(time, character, {y = character.y + distance}, 'in-sine', function()
		t:tween(time, character, {y = character.y - distance}, 'in-sine', function()
			moveCharacter(t, character, distance)
		end)
	end)
end

function MyEncounter:initTransport()
	local t = Timer()
	
    for index, character in ipairs(Game.battle.party) do
		local transport = Sprite("other/ballon_bottom", -character.width * .5, character.height - 12)
		character:addChild(transport)    
		
		local ballon = Sprite("other/ballon_" .. character.chara.id, 0, -character.height * .75)
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
	
    for index, character in ipairs(Game.battle.enemies) do
		local transport = Sprite("other/ballon_bottom_novanna", -character.width * .5, character.height - 6)
		character:addChild(transport)    
		
		local ballon = Sprite("other/ballon_" .. character.id, -(character.width * .5) + 8, -character.height * 1.64)
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
		
		moveCharacter(t, character, nil, index / 3)
		moveCharacter(t, ballon, -2, index / 3)	
	end
	
	Game.battle:addChild(t)
end

function MyEncounter:init()
    super:init(self)
	
	self:addEnemy("novanna", 520, 240)

    self.text = "* Novanna laughs with her pony pet!"
	self.music = "hot flutter"
	
	self.background = false
	self.default_xactions = false
	self.no_end_message = true
	
	-- Game.battle:registerXAction("ralsei", "Overthrow")
    Game.battle:registerXAction("susie", "Overthrow")
	
	self:initTransport()
end

function MyEncounter:getPartyPosition(index)
    local x, y = 0, 0
    if #Game.battle.party == 1 then
        x = 80
        y = 140
    elseif #Game.battle.party == 2 then
        x = 80
        y = 100 + (80 * (index - 1))
    elseif #Game.battle.party == 3 then
        x = 80
        y = 50 + (80 * (index - 1))
    end

	if index == 2 then
		x = x + 32
	end
	
    local battler = Game.battle.party[index]
    local ox, oy = battler.chara:getBattleOffset()
    x = x + (battler.actor:getWidth()/2 + ox) * 2
    y = y + (battler.actor:getHeight()  + oy) * 2
    return x, y
end

return MyEncounter
