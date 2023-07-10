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
	
    self.name = "Drawgon"
    self:setActor("drawgon")

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
        "drawgon/flames",
		"drawgon/draw",
	}
	
	self.prev_wave = nil
	
	self.spare_points = 25
	self.attack = 10
	self.health = 320
	self.max_health = self.health
	self.gold = 96
	
    self.text = {
        "* It's getting hot in here.",
		"* Drawgon wonders about the purpose\nof his life...",
		"* Through the fire and flames!"
    }
end

function MyEnemy:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

	Assets.playSound("drawgon_growl", 3.5, 0.5)
	
    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "[image:text/happy, 0, 0, 2, 2, 0.1]\n",
        }
    else
        dialogue = {
            "[image:text/growl, 0, 0, 2, 2, 0.1]\n",
        }
    end
    return dialogue[math.random(#dialogue)]
end


return MyEnemy