Mod._options = {}
Mod.VIDEO_MODE = false -- MUST TURN OFF WHEN RELEASING

local options = {
	values = {"nil", "nil", "nil", "nil", "nil", "nil"},
	default = {1, 3, 2, 1, false, false},
}

local optionMap = {
	["FuzzyPizza"] = 1,
	["Koola"] = 2,
	["PopCorn"] = 3,
	["ReviveBrite"] = 4,
	["NoShadowMantle"] = 5,
	["Instant"] = 6,
}

Mod.flags = {
	splash = true,
	encounter = false,
	secret = false,
}

function Mod:_getItems()
	for k,v in ipairs(Game.party) do
		v:heal(v:getStat("health"), false)
	end
	
	local itemarray = {
		fuzzypizza = "FuzzyPizza",
		koola = "Koola",
		popcorn = "PopCorn",
		revivebrite = "ReviveBrite",
	}

	Game.inventory:clear()

	for id, name in pairs(itemarray) do
		local val = Mod:_readOptionEntry(name)

		if val ~= 0 then
			for _ = 1, val do
				Game.inventory:tryGiveItem(id)
			end
		end
	end

	Game.inventory:addItemTo("key_items", "cell_phone")

	if not Mod:_readOptionEntry("NoShadowMantle") then
		Game.inventory:addItemTo("key_items", "shadow_mantle")
	end
end

function Mod:_readOptionEntry(name)
	local num = optionMap[name]
	local val = Mod._options.values[num]

	if val == "nil" then
		return Mod._options.default[num]
	end

	if tonumber(val) then
		val = tonumber(val)
	end

	if val == "false" then
		val = false
	elseif val == "true" then
		val = true
	end

	return val
end

function Mod:unload()
    FRAMERATE = Kristal.Config["fps"] -- to reset it to what it was originally
end

function Mod:init()
    FRAMERATE = 30 -- force a 30 fps cap

	-- local os_type = love.system.getOS()
	
	-- if os_type == "OS X" or os_type == "Windows" then
	-- 	-- Loads all Deltarune saves from Chapter 2
	-- 	DeltaruneLoader.load({chapter = 2})
	-- end
	local real_options = Kristal.loadData("options")

	if not real_options then
		Kristal.saveData("options", options)
		Mod._options = options
	else
		Mod._options = real_options
	end

	love.window.setTitle("Deltarune: Fun Town")
	love.window.setIcon(Assets.getTextureData("icon"))
end

Utils.hook(Bullet, 'getDamage', function(orig, self)
	if Mod:_readOptionEntry("NoShadowMantle") then
		Game:gameOver(Game.battle:getSoulLocation())
	end

	return orig(self)
end)

Utils.hook(Bullet, 'getTarget', function(orig, self)
	if Mod:_readOptionEntry("NoShadowMantle") then
		return "ANY"
	end

	return orig(self)
end)

Utils.hook(Game, 'returnToMenu', function(orig, self)
	self.fader:fadeOut(function()
		self.fader:fadeIn()
		Game.world:loadMap("splash")
	end, {speed = 0.5, music = 10/30})
end)

Utils.hook(Battler, "statusMessage", function(_, self, x, y, type, arg, color, kill)
    x, y = self:getRelativePos(x, y)

    local offset = 0
    if not kill then
        offset = (self.hit_count * 20)
    end

    local percent = DamageNumber(type, arg, x + 4, y + 20 - offset, color)
    percent:setParallax(0)
    percent:setLayer(BATTLE_LAYERS.top + 99)
    if kill then
        percent.kill_others = true
    end
    self.parent:addChild(percent)

    if not kill then
        self.hit_count = self.hit_count + 1
    end

    return percent
end)

Utils.hook(Game, 'gameOver', function(orig, self, ...)
    for _,wave in ipairs(Game.battle.waves) do
    	if wave.onGameOver then wave:onGameOver() end
    end

	return orig(self, ...)
end)

-- function Game:gameOver(x, y)
--     Kristal.hideBorder(0)

--     self.state = "GAMEOVER"
--     if self.battle   then self.battle  :remove() end
--     if self.world    then self.world   :remove() end
--     if self.shop     then self.shop    :remove() end
--     if self.gameover then self.gameover:remove() end
--     if self.legend   then self.legend  :remove() end

--     self.gameover = GameOver(x or 0, y or 0)
--     self.stage:addChild(self.gameover)
-- end