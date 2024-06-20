local MyEncounter, super = Class(Encounter)

-- function MyEncounter:onTurnStart()
	-- Assets.playSound(Utils.pick{"lumia shenanigans", "lumia grand illusions"})
-- end

function MyEncounter:init()
    super:init(self)
	
	self:addEnemy("lumia", 800, 256)
	
	self.default_xactions = false
	
    self.text = "* NO HELP NEEDED."
	self.music = "music for soul"
	self.background = false
end

-- function MyEncounter:createSoul()
-- 	return GreenSoul()
-- end

return MyEncounter