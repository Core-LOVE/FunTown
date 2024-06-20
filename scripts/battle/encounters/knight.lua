local MyEncounter, super = Class(Encounter)

-- function MyEncounter:onTurnStart()
	-- Assets.playSound(Utils.pick{"lumia shenanigans", "lumia grand illusions"})
-- end

function MyEncounter:init()
    super:init(self)
	
	local knight = self:addEnemy("knight", 544, 210 - 12)
	knight.sprite:setAnimation('battle')
	
    -- self.text = "* There is no choice."
	
	self.music = nil
	self.background = false
end

function MyEncounter:onTurnStart()
	Game.battle:startCutscene("knight", "no_mercy")
end

return MyEncounter