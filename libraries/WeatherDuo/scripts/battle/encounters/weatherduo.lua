local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
	
    self:addEnemy("sunny")
    self:addEnemy("luna")
	
    self.text = "* "
end

return MyEncounter