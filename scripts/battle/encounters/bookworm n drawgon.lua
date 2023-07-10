local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
    self:addEnemy("bookworm", 500 + 32, 180)
    self:addEnemy("drawgon", 470 + 32, 260)
	
    self.text = "* Smells like burnt books."
end

return MyEncounter