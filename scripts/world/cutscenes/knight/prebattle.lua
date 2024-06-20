return function(cutscene, event, player, facing)
    local kris = cutscene:getCharacter("kris")
	kris.y = 460
	
    local knight = cutscene:spawnNPC("knight", kris.x + 32, kris.y - 20)
	
	kris.x = kris.x - 32
	
	cutscene:walkTo(kris, kris.x, kris.y - 96, 3)
	cutscene:walkTo(knight, knight.x, knight.y - 96, 3)
	
	cutscene:fadeIn(2)
	cutscene:wait(3)
	
	local chars = Game.stage:getObjects(Character)
	
	cutscene:wait(function()
		for _,chara in ipairs(chars) do
			local fx = chara:getFX("shadow")
			
			fx.alpha = fx.alpha - 0.01
			
			if fx.alpha < 0.5 then
				return true
			end
		end
	end)
	
	cutscene:wait(1)

	cutscene:text("* ...", "neutral", knight)
	cutscene:text("* So it has come to this.", "neutral", knight)
	cutscene:text("* ... Kris.", "neutral", knight)	
	cutscene:text("* Just so you know...", "neutral", knight)	
	cutscene:text("* We don't have to fight.", "worried", knight)	
	
	kris:shake(1, 0)
	
	cutscene:text("* We could just go back to our normal life.", "neutral", knight)	
	cutscene:text("* Opening and closing fountains, having fun...", "neutral", knight)	
	cutscene:text("* Isn't that what you always wanted?", "neutral", knight)	
	
	kris:shake(2, 0)
	
	cutscene:text("* I know you only feel hatred towards me now,[wait:4] but...", "neutral", knight)	
	
	Assets.playSound('laz_c')
	cutscene:setAnimation(kris, 'battle/attack')
	cutscene:slideTo(knight, knight.x + 48, knight.y, 0.25, 'out-sine')
	knight:setFacing('left')
	knight:shake(2)
	
	cutscene:wait(function()
		for _,chara in ipairs(chars) do
			local fx = chara:getFX("shadow")
			
			fx.alpha = fx.alpha - 0.01
			
			if fx.alpha < 0 then
				return true
			end
		end
	end)
	
	cutscene:text("* Oh.", "worried", knight)
	cutscene:text("* ... Sorry.[wait:8] It doesn't justify my actions at all.", "neutral", knight)
	cutscene:text("* Well then.", "neutral", knight)
	
	cutscene:startEncounter('knight', nil, knight)
end