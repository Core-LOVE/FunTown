local function spawnEffect(x, y)
	local effect = Sprite("effects/attack/slap", x + 16, y)
	effect:setOrigin(.5, .5)
	effect:setScale(2)
	effect:play(0.05, false, function()
		effect:remove()
	end)
	
	Game.battle:addChild(effect)
end

return {
	ending = function(cutscene, enemy)
		Game.battle.music:stop()
		
        for _,battler in ipairs(Game.battle.party) do
			battler:setAnimation("battle/idle")
		end
		
		cutscene:wait(1.25)
		
		Assets.playSound("damage")
		Assets.playSound("voice/novanna", 1)
		
		enemy:setSprite("shock")
		cutscene:shakeCharacter(enemy, 12)
		
		for k, part in ipairs(enemy.parts) do
			part:shake(8, 0)
		end
		
		cutscene:wait(.5)
		
		cutscene:battlerText(enemy, "ohhh nooo!! ;-;")
		cutscene:battlerText(enemy, "ballon will start to\ngo down now <:((")
		
		cutscene:slideTo(enemy, 900, 900, 3.5)
		
		cutscene:wait(3)
		
		Game.battle:setState("TRANSITIONOUT")
        Game.battle.encounter:onBattleEnd()
		
		cutscene:wait(2)
		
        for _,battler in ipairs(Game.battle.party) do
			cutscene:slideTo(battler, 900, 900, 3.5)
		end
	end,
	
    overthrow = function(cutscene, battler, enemy)
		battler:setAnimation("battle/attack")
		Assets.playSound("grab")
		
		local bag = Sprite("battle/bag", battler.x, battler.y - 64)
		bag:setScale(2)

		spawnEffect(bag.x, bag.y)
			
		bag.physics.speed_x = 18
		
		bag.physics.gravity = 0.6
		
		Game.battle:addChild(bag)
		
		if battler.chara.id ~= "kris" then
			bag.physics.speed_y = -15
		
			cutscene:wait(.62)	
		else
			bag.physics.speed_y = -10
			
			cutscene:wait(.72)
		end
		
		spawnEffect(bag.x, bag.y)
		
		Assets.playSound("damage")
		Assets.playSound("voice/novanna", 1)
		
		enemy:setSprite("shock")
		cutscene:shakeCharacter(enemy, 12)
		
		for k, part in ipairs(enemy.parts) do
			part:shake(8, 0)
		end

		enemy:addMercy(50)
		
		cutscene:wait(1)
		bag:remove()
		enemy:setAnimation("battle/idle")
	end,
	
	overthrowX = function(cutscene, _, enemy)
		local bags = {}
		
        for _,battler in ipairs(Game.battle.party) do
			battler:setAnimation("battle/attack")
			Assets.playSound("grab")
			cutscene:wait(.2)
				
			local bag = Sprite("battle/bag", battler.x, battler.y - 64)
			bag:setScale(2)
			
			table.insert(bags, bag)
			
			bag.physics.speed_x = 18
			
			bag.physics.gravity = 0.6
			
			Game.battle:addChild(bag)
			
			if battler.chara.id ~= "kris" then
				bag.physics.speed_y = -15
			else
				bag.physics.speed_y = -10
			end
        end
		
		cutscene:wait(.4)	
		
		for i = 1, 2 do
			local bag = bags[i]
			spawnEffect(bag.x, bag.y)
			
			Assets.playSound("damage")
			Assets.playSound("voice/novanna", 1)
			
			enemy:setSprite("shock")
			cutscene:shakeCharacter(enemy, 12)
			
			for k, part in ipairs(enemy.parts) do
				part:shake(8, 0)
			end

			enemy:addMercy(6)
			
			cutscene:wait(.1)	
		end

		cutscene:wait(1)
		
		for i = 1, 2 do
			bags[i]:remove()
		end
		
		enemy:setAnimation("battle/idle")
	end,
}