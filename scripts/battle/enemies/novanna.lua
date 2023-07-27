local MyEnemy, super = Class(EnemyBattler)

function MyEnemy:selectWave()
    local waves = self:getNextWaves()
	
    if waves and #waves > 0 then
        local wave = Utils.pick(waves)
		
		while wave == self.prev_wave do
			wave = Utils.pick(waves)
		end
		
        self.selected_wave = wave
		self.prev_wave = wave
        return wave
    end
end

function MyEnemy:init()
    super.init(self)
	
    self.name = "Novanna"
    self:setActor("novanna")
	
	self:setAnimation('battle/idle')
    -- if Game:getPartyMember("susie"):getFlag("auto_attack") then
        -- self:registerAct("Warning")
    -- end

    -- self.susie_warned = false

    -- self.asleep = false
    -- self.become_red = false

    -- self:registerAct("Tell Story", "", {"ralsei"})
    -- self:registerAct("Red", "", {"susie"})
    -- self:registerAct("", "", nil, nil, nil, {"ui/battle/msg/dumbass"})
    -- self:registerAct("Red Buster", "Red\nDamage", "susie", 60)
    -- self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)
	
    self.waves = {
        -- "novanna/bedjump",
		"novanna/rainbow",
		-- "novanna/twitter",
	}
	
	self.spare_points = 5
	self.attack = 5
	self.health = 200
	self.max_health = self.health
	self.gold = 50
	self.check = "Beware of Gamer girls!"
    self.text = {
        -- "* There's a snake in my boot!",
        -- "* Bookworm tries to grow legs...[wait:8]\nIt fails ultimately.",
    }
	
    self:registerAct("Overthrow", "", nil)
    self:registerAct("OverthrowX", "", "all")
	
	self.dialogue = 0
end

function MyEnemy:getEnemyDialogue()
    local dialogue
	
	dialogue = {
		"BIG CHUNGUS",
		-- "kris, susie uwu\ni understand how\nhard it is to give up",
		-- {"but don't you\nget it? ;-;", "toriel would be happier\nwith my daddy!!"},
		-- {"sad and broken...", "don't you want\nto make your mommy happier?"},
		-- "they would create\na new world...\ntogether!! uwu",
		-- "a world where happiness\nknows no bounds!! ;w;",
		-- {"but if you wish\nto continue resisting...", "i will continue\nto fight back!!"}
	}
	
	self.dialogue = (self.dialogue + 1)
	
	if self.dialogue > #dialogue then
		dialogue = {
			"rain, rain,\ngo away!!",
			"darkners on\npostter won't be happy\nabout it... ;-;",
		}
		
		return dialogue[math.random(1, #dialogue)]
	end

    return dialogue[self.dialogue]
end

function MyEnemy:onAct(battler, name)
	self.acted_once = true
	
	if name == "Overthrow" then
		Game.battle:startActCutscene("novanna", "overthrow")
	elseif name == "OverthrowX" then
		Game.battle:startActCutscene("novanna", "overthrowX")
	else
		return super.onAct(self, battler, name)
	end
end

function MyEnemy:onSpareable()
	local action = Game.battle:getCurrentAction()
	local cutscene = BattleCutscene("novanna", "ending", action.target)
	
	Game.battle.cutscene = cutscene
end

return MyEnemy