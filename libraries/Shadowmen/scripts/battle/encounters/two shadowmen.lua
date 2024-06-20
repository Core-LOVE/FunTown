local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
	
    local enemy = self:addEnemy("shadowmen")
	enemy.x = enemy.x + enemy.width * .25
	enemy.y = enemy.y + enemy.height * .5
	
	do
		local new = self:addEnemy("shadowmen")
		new.x = enemy.x - enemy.width * .5
		new.y = new.y + new.height * .5
	end
	
    self.text = "* Two musicians struggle for\ncontrol!"
end

return MyEncounter