local MyEnemy, super = Class(EnemyBattler)

function MyEnemy:selectWave()
	local wave = Utils.pick(self.waves)

	if self.prev_wave and #self.waves > 1 then
		while (wave == self.prev_wave) do
			wave = Utils.pick(self.waves)
		end
	end

	self.prev_wave = wave
	self.selected_wave = wave

	return wave
end

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
		"lumia/ball",
		"lumia/flash",
		"lumia/trains",
		"lumia/doll",
		"lumia/jackbox",
	}
	
	self.prev_wave = nil
	
	self.spare_points = 5
	self.attack = 13
	self.health = 1
	-- self.health = 800
	self.max_health = self.health
	self.gold = 50
	self.check = "An illusory being."

    self.text = {
        "* Lumia is showcasing various\nshenanigans!",
		"* Say CHEESsSE!",
		"* History repeats.",
		"* Grand Illusions are coming.",
		"* You want to try snake oil...\nFor some unknown reason."
    }
	
	self.dialogue_text = {
		{"WELL KRISsS!\n[wait:2]GLAD TO SEE YOU!", "... AGAIN."},
		{"SsSO, DID YOU MISsS ME?", [[W-WHAT DO YOU MEAN BY
"I don't know you"?!]]},
		{"REMEMBER YOU USED TO\nTAKE THESsSE...", "PRECIOUSsS PHOTOSsS??"},
		{"KRISsS...", "A BIG FUTURE ISsS\nAHEAD OF YOU.", "BUT CAN YOU KEEP IT?"}
	}

	self.random_dialogue_text = {
		"LET'SsS TELL FORTUNE ON\nCARDSsS!",
		"THE CRYSsSTAL BALL WILL TELL YOUR FATE...",
		{"I HAVE SsSO SsSO\nMANY TOYS!", "CAN'T EVEN\nCOUNT THEM..."},
		"CAMERASsS SsSEE THINGS\nLIGHTNERS CAN'T SsSEE!",
		{"CURE TO ALL DISsSEAESsS!", "INCLUDING...\n Abandonment."},
	}

    self:registerAct("Trick", "Magic", nil)
    self:registerAct("TrickX", "Super\nMagic", "all", 25)
    self:registerActFor("ralsei", "Trick")
    self:registerActFor("susie", "Trick")

	self.dialogue = 0

	-- self.exit_on_defeat = false
end

-- function MyEnemy:defeat(type, ...)
-- 	super.defeat(self, type, ...)
	
-- 	if type == "VIOLENCED" then
-- 		Assets.playSound("lumia dislike")
-- 	else
-- 		Assets.playSound("lumia huh")
-- 	end
-- end

function MyEnemy:onDefeatRun(damage, battler)
    self.hurt_timer = -1
    self.defeated = true

    -- Assets.playSound("defeatrun")

    -- local sweat = Sprite("effects/defeat/sweat")
    -- sweat:setOrigin(0.5, 0.5)
    -- sweat:play(5/30, true)
    -- sweat.layer = 100
    -- self:addChild(sweat)

    Game.battle.timer:after(1, function()
	    local sprite = self:getActiveSprite()
	    sprite:setAnimation("defeat")
	    sprite.visible = false
	    sprite.shake_x = 0

	    local death_x, death_y = sprite:getRelativePos(0, 0, self)
	    local death = NotFatalEffect(sprite:getTexture(), death_x, death_y, function() self:remove() end)
	    death:setColor(sprite:getDrawColor())
	    death:setScale(sprite:getScale())
	    self:addChild(death)

		Assets.playSound("lumia dislike")
 	  	Assets.playSound("deathnoise", 1, 0.5)
    end)

    self:defeat("VIOLENCED", true)
    Game.battle.used_violence = false
end

function MyEnemy:spare(pacify)
    Game.battle.spare_sound:stop()
    Game.battle.spare_sound:play()

	Assets.playSound("lumia huh")

    self:defeat(pacify and "PACIFIED" or "SPARED", false)
    self:onSpared()
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
		return Utils.pick(self.random_dialogue_text)
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

function MyEnemy:getXAction(battler)
    return "Trick"
end

local function actSprite(self, ox, oy)
	local sprite = "trick"
	
    self:setSprite(sprite, ox, oy, speed, loop, after)

    local x = self.x - (self.actor:getWidth()/2 - ox) * 2
    local y = self.y - (self.actor:getHeight() - oy) * 2
    local flash = FlashFade(sprite, x, y)
    flash:setOrigin(0, 0)
    flash:setScale(self:getScale())
    self.parent:addChild(flash)

    local afterimage1 = AfterImage(self, 0.5)
    local afterimage2 = AfterImage(self, 0.6)
    afterimage1.physics.speed_x = 2.5
    afterimage2.physics.speed_x = 5

    afterimage2.layer = afterimage1.layer - 1

    self:addChild(afterimage1)
    self:addChild(afterimage2)
end

function MyEnemy:onAct(battler, name)
    if name == "Trick" or name == "R-Trick" or name == "S-Trick" then
        self:addMercy(7)
        return "* You showcased cool tricks to Lumia!"
	elseif name == "TrickX" then
        for _,battler in ipairs(Game.battle.party) do
			actSprite(battler, battler.x, battler.y)
        end
		
        self:addMercy(100)
        return "* Everyone showcased cool tricks to Lumia!"
	elseif name == "Applause" then
        self:addMercy(2)
        return {"* You applause to Lumia's tricks!", "* Lumia respects that!"}
	end

    return super:onAct(self, battler, name)
end

return MyEnemy