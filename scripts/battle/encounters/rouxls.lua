local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
	
    self:addEnemy("rouxls")
	
    self.text = "* Everyobdy wanna be a superstar!"
	self.music = "rules rules"
end

return MyEncounter