local item, super = Class(HealItem, "popcorn")

function item:init()
    super:init(self)

    -- Display name
    self.name = "Pop!Corn"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    -- self.effect = "Healing\nvaries"
	
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Hot popcorn!\nBe careful with it! Heals 90 HP."

    -- Amount healed (HealItem variable)
    self.heal_amount = 90
    -- Amount this item heals for specific characters
    -- self.heal_amounts = {
        -- ["kris"] = 100
    -- }

    -- Default shop price (sell price is halved)
    self.price = 160
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Right into my face!",
        ralsei = "It's so shaky...",
    }
end

return item