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
		-- "lumia/ball",
		-- "lumia/flash",
		"lumia/trains"
	}
	
	self.exit_on_defeat = false
	self.prev_wave = nil
	
	self.spare_points = 5
	self.attack = 13
	self.health = 800
	self.max_health = self.health
	self.gold = 50
	
    self.text = {
        "* Lumia is showcasing various\nshenanigans!",
		"* Say cheese!",
		"* History repeats itself.",
		"* Grand Illusions are coming.",
    }
	
	self.dialogue_text = {
		{"WELL KRISsS!\n[wait:2]GLAD TO SEE YOU!", "... AGAIN."},
	}
	
	self.dialogue = 0
end

function EnemyBattler:onDefeat(damage, battler)
    if self.exit_on_defeat then
        self:onDefeatRun(damage, battler)
    else
        self.sprite:setAnimation("defeat")
    end
end

function MyEnemy:defeat(type, ...)
	super.defeat(self, type, ...)
	
	if type == "VIOLENCED" then
		Assets.playSound("lumia dislike")
	else
		Assets.playSound("lumia huh")
	end
end

function MyEnemy:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

	local dialogue = self.dialogue_text
	
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
	
    return dialogue[self.dialogue]
end

function MyEnemy:cam_flash()
	local t = Timer()
	local effect = Sprite("effects/sparkle", (self.width * .5) + 6, (self.height * .5))
	effect:fadeOutAndRemove(.5)
	effect:setOrigin(1, 1)
	effect:setScale(2)
	t:tween(.5, effect, {scale_x = 3, scale_y = 3, x = effect.x - 4, y = effect.y - 4}, 'out-sine')
	
	self:addChild(effect)
	effect:addChild(t)
	Assets.playSound("camera")
end

return MyEnemy