local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
	
    self:addEnemy("superstar")
    self:addEnemy("superstar")
	
    self.text = "* Everyobdy wanna be a superstar!"
end

return MyEncounter