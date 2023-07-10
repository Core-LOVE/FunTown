local MyEnemy, super = Class(EnemyBattler)

function MyEnemy:init()
    super.init(self)
	
    self.name = "Lumia"
    self:setActor("lumia")

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
		"lumia/hats",
        -- "drawgon/flames",
		-- "drawgon/draw",
	}
	
	self.prev_wave = nil
	
	self.spare_points = 5
	self.attack = 16
	self.health = 800
	self.max_health = self.health
	self.gold = 50
	
    self.text = {
        "* Lumia is showcasing various\nshenanigans!",
		"* Say cheese!",
		"* History repeats itself.",
		"* Grand Illusions are coming.",
    }
	
	self.dialogue = 0
end

function MyEnemy:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

	local dialogue = {
		{"WELL KRISsS!\n[wait:2]GLAD TO SEE YOU!", "... AGAIN."},
		
	}
	self.dialogue = self.dialogue + 1
	
	if self.dialogue > #dialogue then
		self.dialogue = #dialogue
	end
	
    -- if self.mercy >= 100 then
        -- dialogue = {
            -- "[image:text/happy, 0, 0, 2, 2, 0.1]\n",
        -- }
    -- else
        -- dialogue = {
            -- "GOOFY AH"
        -- }
    -- end
	
    return dialogue[math.random(#dialogue)]
end


return MyEnemy