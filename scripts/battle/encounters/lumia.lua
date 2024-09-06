local MyEncounter, super = Class(Encounter)

local function spawnLumia(self, x, y)
    local enemy = self:addEnemy("lumia", x, y)
	enemy.actor.default = "battle/idle"
	enemy.sprite:setAnimation(enemy.actor.default)
end

-- function MyEncounter:onTurnStart()
	-- Assets.playSound(Utils.pick{"lumia shenanigans", "lumia grand illusions"})
-- end

function MyEncounter:beforeStateChange(old, new) 
	if new == "DIALOGUEEND" then
		Assets.playSound(Utils.pick{"lumia shenanigans", "lumia grand illusions", "lumia ooh"})
	end
end

function MyEncounter:init()
    super:init(self)
	
	spawnLumia(self, 525, 230)
	-- spawnLumia(self)
	-- spawnLumia(self)
	-- spawnLumia(self)
	
    self.text = "[facec:susie/teeth_b][voice:susie]* WHO ARE WE EVEN FIGHTING??"
	self.music = "shenanigans"
end

-- function MyEncounter:createSoul()
	-- return GreenSoul()
-- end

return MyEncounter