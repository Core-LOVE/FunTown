local MyEncounter, super = Class(Encounter)

local function spawnLumia(self, x, y)
    local enemy = self:addEnemy("eternal lumia", x - 100, y - 80)
	enemy:setLayer(BATTLE_LAYERS["battlers"] + 0.01)
	
    local enemy = self:addEnemy("lumia", x, y - 52)
	enemy.actor.default = "dark/idle"
	enemy.sprite:setAnimation(enemy.actor.default)
	enemy.selectable = false
	enemy.waves = {}
	enemy.dialogue_text = {
		{"SILLY HEROESsS!", "DON'T YOU GET IT?[wait:6]\nYOU ARE RUINING FREEDOM!"},
		{"YOU SsSHOULD\nREFLECT ON YOUR ACTIONS..."},
		{"WE'VE ALREADY BEEN THROUGH\nTHISsS, DIDN'T WE?", "HISsSTORY REPEATSsS."},
		{"IF YOU CONTINUE\nTO RESsSIST...", "EVERYONE IS GOING TO BE\nDOOMED!"},
		{"AND IF YOUR LIFE MEANSsS\nDOOM...", "THEN I WON'T GIVE UP!"}
	}
	enemy.text = {
		"* The air crackles with freedom.",
		"* Memories fly off the scene.",
		"* History repeats again.",
		"* TOO DETERMINED?[wait:6]\nI CAN FIX THAT.",
		"* Grand Illusions are everywhere.",
		"* Feels like an utopian show."
	}
	
	-- Game.battle.enemies[1] = nil 
end

-- function MyEncounter:onTurnStart()
	-- Assets.playSound(Utils.pick{"lumia shenanigans", "lumia grand illusions"})
-- end

function MyEncounter:init()
    super:init(self)
	
	spawnLumia(self, 640, 320)
	-- spawnLumia(self)
	-- spawnLumia(self)
	-- spawnLumia(self)
	
	self.default_xactions = false
	
    self.text = "* FATE is decided."
	self.music = "grand illusions"
	self.background = false

    Game.battle:registerXAction("ralsei", "Expose")
    Game.battle:registerXAction("susie", "Expose")
    Game.battle:registerXAction("ralsei", "SupportShield", "Second\nshield", 32)
    Game.battle:registerXAction("susie", "PostDestruct", "Explodes\nin danger", 32)
end

function MyEncounter:createSoul()
	return GreenSoul()
end

return MyEncounter