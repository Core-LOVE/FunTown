local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
    self:addEnemy("bookworm", 480, 240)
	
    self.text = "* Bookworm crawled out of\nthe ground!"
end

return MyEncounter