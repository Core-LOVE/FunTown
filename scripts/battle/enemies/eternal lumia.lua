local MyEnemy, super = Class(EnemyBattler)

local exposeShader = love.graphics.newShader[[
extern vec2 pxSize;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
{
	vec2 xy = tc.xy;
	xy = floor(xy*pxSize);
	vec4 c = Texel(tex, xy);

	return c * color;
}
]]

function MyEnemy:expose(fast)
	Assets.playSound("l_expose", 0.5, 1.1)

	if not fast then
		Assets.playSound("l_expose", 0.5, 0.9)
	end

   	local sprite = self:getActiveSprite()
	sprite:setHeadAnimation("hurt", nil, false)

	local t = Timer()
	t.pxSize = {0, 0}

	local fx = RecolorFX(1, 1, 1, 1, 1)
	local shader = ShaderFX(exposeShader, {["pxSize"] = function() return t.pxSize end}, 2)

	local timer = (fast and 0.225) or 0.32
	local size = 9999

	t:tween(timer, t, {pxSize = {size, size}})

	t:tween(timer, fx, {color = {0, 0, 0.5, 0.5}}, nil, function()
		t:tween(timer, t, {pxSize = {0, 0}})

		t:tween(timer + 0.1, fx, {color = {1, 1, 1, 1}}, nil, function()
			self:removeFX(shader)	
			t:remove()
			self:removeFX(fx)
		end)
	end)

	self:addChild(t)

	if not fast then
		self:shake(4, 2, 0.5, 1/15)
	end

	self:addFX(fx)
	self:addFX(shader)
end

function MyEnemy:onHurt(damage, battler)
	self:expose(true)

    return super.onHurt(self, damage, battler)
end

function MyEnemy:onAct(battler, name)
    if name == "Expose" then
   		self:expose(true)
        self:addMercy(2)
		return "* You tried to expose Lumia!"
	elseif name == "ExposeX" then
   		self:expose()
        self:addMercy(9)
		return "* Everyone tried to expose Lumia!"
	elseif name == "SupportShield" then
		GreenSoul.hasSecondShield = true
		return "* Ralsei created second shield!"
	elseif name == "PostDestruct" then
		GreenSoul.isExplosive = true
		return "* Susie made soul explosive!"
	end

	return super.onAct(self, battler, name)
end

function MyEnemy:selectWave()
	-- if Game.battle.state == "DEFEND" then
		-- Assets.playSound(Utils.pick{"grand illusions", "shenaniganing"})
	-- end

    local sprite = self:getActiveSprite()
	sprite:setHeadAnimation()

	if Game.world and Game.world.map and Game.world.map.spin_speed then
		Game.world.map.timer:tween(0.5, Game.world.map, {spin_speed = Game.world.map.spin_speed + 0.01}, 'in-sine')
	end

	local waves = self.waves
	self.wave_count = self.wave_count + 1
	
	if waves and #waves > 0 then
		local wave = waves[self.wave_count]
		
		if not wave then
			local wave = Utils.pick(self.random_waves)
			self.selected_wave = wave
			
			return wave
		end
		
		self.selected_wave = wave
		return waves[self.wave_count]
	end
end

function MyEnemy:onCheck(battler)
    local sprite = self:getActiveSprite()

	sprite:setHeadAnimation("check", nil, false)

	return super.onCheck(self, battler)
end

function MyEnemy:init()
    super.init(self)
	
    self.name = "Eternal Lumia"
    self:setActor("eternal_lumia")

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
	self.wave_count = 0

    self.waves = {
		-- "eternal_lumia/beginning",
		-- "eternal_lumia/mirrors",
		-- "eternal_lumia/carousel",
		"eternal_lumia/bounce",
		-- "eternal_lumia/rockets",		
		-- "eternal_lumia/carousel_hard",
		-- "eternal_lumia/ball",
		-- "eternal_lumia/final",
	}
	
	self.random_waves = self.waves

	self.exit_on_defeat = false
	self.prev_wave = nil
	
	self.spare_points = 5
	self.attack = 13
	self.health = 800
	self.max_health = self.health
	self.gold = 50
	
    self.text = {}
	self.check = "Your heartbeat quickened."
	self.dialogue = {
		"\n[image:text/static, 0, 0, 2, 2, 0.1]\n\n",
		"\n[image:text/break_heart, 0, 0, 2, 2, 0.075]\n\n",
		"\n[image:text/eternal_lumia_laugh, 0, 0, 2, 2, 0.075]\n\n",	
	}

    self.dialogue_offset = {0, -36}

    self:registerAct("Expose", "", nil)
    self:registerAct("ExposeX", "", "all")
end

function MyEnemy:onDefeat(damage, battler)
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

	local dialogue = self.dialogue
	
    return dialogue[math.random(#dialogue)]
end

function MyEnemy:cam_flash()
	local t = Timer()
	local effect = Sprite("effects/sparkle", (self.width * .5) + 6, (self.height * .5) - 15)
	effect:fadeOutAndRemove(.5)
	effect:setOrigin(1, 1)
	effect:setScale(2)
	t:tween(.5, effect, {scale_x = 3, scale_y = 3, x = effect.x - 4, y = effect.y - 4}, 'out-sine')
	
	self:addChild(effect)
	effect:addChild(t)
	Assets.playSound("camera")
end

function MyEnemy:onBubbleSpawn(bubble)
	local pitch = math.random() + 0.5
	Assets.playSound("eternal lumia dislike", 0.9, pitch)

    local sprite = self:getActiveSprite()
	sprite:setHeadAnimation("talk", nil, true)

	return super.onBubbleSpawn(self, bubble)
end

function MyEnemy:onTurnStart()
    local sprite = self:getActiveSprite()

    if sprite and sprite.setHeadAnimation then
		sprite:setHeadAnimation()
	end

	return super.onTurnStart(self)
end

return MyEnemy