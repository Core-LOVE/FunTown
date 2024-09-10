local MyEncounter, super = Class(Encounter)

local function spawnLumia(self, x, y)
    local enemy = self:addEnemy("eternal lumia", x - 100, y - 80)
	enemy:setLayer(BATTLE_LAYERS["battlers"] + 0.01)
	
    local enemy = self:addEnemy("lumia", x, y - 52)
    enemy.hp = 99999
	enemy.actor.default = "dark/idle"
	enemy.sprite:setAnimation(enemy.actor.default)
	enemy.selectable = false
	enemy.waves = {}
	enemy.dialogue_text = {
		{"SILLY HERO!", "DON'T YOU GET IT?[wait:6]\nYOU ARE RUINING ALL\nFREEDOM!"},
		{"YOU LOVE YOUR FRIENDSsS,\n[wait:6]DON'T YOU?", "BUT HISsSTORY WILL PLACE\nEVERYTHING IN ITSsS PLACE", 
		"SsSO WATCH HOW THEY ALL DIE\nONE BY ONE!", "WATCH HOW YOUR HOPE\nGETSsS CRUSHED HARDER YET HARDER..."},
		{"YOU SsSHOULD\nREFLECT ON YOUR ACTIONS...", "Otherwise you'll\nforget everything you've done."},
		{"IF YOU CONTINUE\nTO RESsSIST...", "EVERYONE IS GOING TO BE\nDOOMED!", "ALL BECAUSsSE OF\n[wait:2]YOU..."},

		-- hard

		{"AND IF YOUR LIFE MEANSsS\nDOOM...", "THEN YOU SsSHOULD\nGIVE UP!"},
		{"DO YOU REALLY THINK", "THAT ANY OF THISsS\nWILL CHANGE[wait:8] ANYTHING?", "RIP YOUR SsSOUL."},
		{"IT WON'T GET BETTER FROM\nHERE", "IT WILL NEVER GET\nBETTER FROM HERE", "ONLY DOOM"},
		{"SsSO WHY ARE YOU...\n Trying?", "EVERY TIME YOU\nCLOSE THE FOUNTAIN...", "A NEW ONE POPS UP", "WE'VE ALREADY BEEN THROUGH\nTHISsS, HAVEN'T WE?", "HISsSTORY REPEATSsS."},
		{"YOUR FRIENDSsS\nDON'T NEED YOU, SsSILLY!", "THEY ONLY\nCRAVE FOR YOUR\n[wait:8]SsSOUL...", "WITHOUT IT YOU'RE\nNOTHING."},
		{"WITHOUT DARK WORLDSsS...", "YOU WOULDN'T MATTER."},

		-- finale
		{"...", "YET...", "YOU SsSTILL\nSsSTAND.", "ARE YOU TRYING\nTO PROVE ME WRONG?", "CAN'T YOU JUST\nACCEPT THE REALITY,[wait:4]\nKRISsS?"},
		{"HAHAHA!", "WELL THEN!\nHAVE A NICE EGOTRIP!"},	
	}

	enemy.random_dialogue_text = {
		"YOU CAN'T FORGET THESsSE[wait:8]\nMEMORIESsS",
		
		{"I'll always be there\to remind you...", "That you are\not a hero."},
		{"I MAY NOT BE ALIVE\nLIKE BEFORE...", "But I'm still\nin your mind."},
		{"DO YOU WISH\nTO SsSEE THEM DEAD?", "JUST END IT!\n[wait:8]END IT ALL!"},
		{"You can't just\nlisten to yourself,\n[wait:6]don't you?", "This won't lead you\nanywhere."},

		{"SsSELF HATRED IS NOT BAD!", "It's[wait:6] good."},
		
	}

	enemy.text = {
		"* The air crackles with freedom.",
		"* Memories fly off the scene.",
		"* History repeats again.",
		"* TOO DETERMINED?[wait:6]\nI CAN FIX THAT.",
		"* Grand Illusions are everywhere.",
		"* Feels like an utopian show.",
		"* Is any of this real...?",
		"* Memories flash before your eyes,[wait:8]as if they were just frames.",
		"* Many layers of abstraction."
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