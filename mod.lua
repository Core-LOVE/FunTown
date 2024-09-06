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

function Mod:init()
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