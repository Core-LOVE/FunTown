local MyEnemy, super = Class(EnemyBattler)

function MyEnemy:init()
    super.init(self)
	
    self.name = "Tenna C."
    self:setActor("tenna")

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
        "tenna/static",
	}
	
	self.spare_points = 50
	self.attack = 5
	self.health = 200
	self.max_health = self.health
	self.gold = 50
	
    self.text = {
        -- "* There's a snake in my boot!",
        -- "* Bookworm tries to grow legs...[wait:8]\nIt fails ultimately.",
    }
end

function MyEnemy:onHurt(...)
	super:onHurt(self, ...)
	self:getActiveSprite():removeBody()
end

return MyEnemy