local MyEnemy, super = Class(EnemyBattler)

function MyEnemy:init()
    super.init(self)
	
    self.name = "Sunny"
    self:setActor("sunny")

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
        "weatherduo/bolts",
	}
	
	self.prev_wave = nil
	
	self.spare_points = 25
	self.attack = 10
	self.health = 320
	self.max_health = self.health
	self.gold = 96
	
    self.text = {
        "* ",
    }
end

return MyEnemy