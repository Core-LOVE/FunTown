local MyEncounter, super = Class(Encounter)

-- function MyEncounter:onTurnStart()
	-- Assets.playSound(Utils.pick{"lumia shenanigans", "lumia grand illusions"})
-- end

function MyEncounter:init()
    super:init(self)
	
	local tenna = self:addEnemy("tenna", 520, 240)
	tenna:setAnimation('battle/idle')
	
    self.text = "* Tenna C. blocked the way!"
	self.music = Music("rookie mistake")
	self.music:setVolume(3)
	
	self.background = false
end

return MyEncounter