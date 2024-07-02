local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
end

return {
	splash = function(cutscene)
		hide()

		Assets.stopAndPlaySound("katebulka")

		local continue = false
		local timer = Timer()
		local splash = Sprite("other/katebulka", (640 - 588) / 2, (-182 / 4))
		splash.alpha = 0

		timer:tween(1.5, splash, {y = splash.y + 182, alpha = 1}, 'in-out-sine')

		timer:after(3, function()
			timer:tween(1, splash, {y = splash.y + (182 / 2), alpha = 0}, 'in-sine', function()
				continue = true
			end)
		end)

		splash:addChild(timer)

		Game.world:spawnObject(splash, "ui")
		cutscene:wait(function()
		    return Input.pressed("confirm") or continue
		end)

		splash:remove()
		cutscene:gotoCutscene("splash", "warning")
	end,

	warning = function(cutscene)
		Assets.stopAndPlaySound("dont_forget_warning")	

		local continue = false
		local timer = Timer()
		local warning = Sprite("other/warning", 0, -24)
		warning.alpha = 0

		timer:tween(1, warning, {y = 0, alpha = 1}, 'out-sine')

		timer:after(5, function()
			timer:tween(2, warning, {y = warning.y + 48, alpha = 0}, 'in-sine', function()
				continue = true
			end)
		end)

		warning:addChild(timer)
		Game.world:spawnObject(warning, "ui")

		cutscene:wait(function()
		    return Input.pressed("confirm") or continue
		end)

		warning:remove()
		cutscene:gotoCutscene("splash", "menu")
	end,

	menu = function(cutscene)
		local end_cutscene = false

		hide()
		Game.world.music:play("findher")

		local timer = Timer()
		local parent = Object()
		parent.alpha = 0

		local function addToParent(obj)
			obj.inherit_color = true
			parent:addChild(obj)
		end

		local logo = Sprite("other/logo", (SCREEN_WIDTH / 2) - (224 / 2), 24)
		local eternal_lumia = Text("[color:yellow]Lumia", 76, 84)
		eternal_lumia.inherit_color = true

		logo:addChild(eternal_lumia)

		local menu = Object(48, 176)
		menu.can_confirm = true
		menu.index = 0
		menu.max = 0
		menu.actions = {}

		menu.actions[1] = function()
			menu.can_confirm = false

			Game.world.music:fade(0, 0.5)
			timer:tween(1, parent, {y = parent.y + 48, alpha = 0}, 'in-sine', function()
				timer:after(1, function()
					cutscene:loadMap("homewoods_lumia")
					black:remove()
					end_cutscene = true
				end)
			end)
		end

		menu.actions[2] = function()
			menu.can_confirm = false

			Game.world.music:fade(0, 0.5)
			timer:tween(1, parent, {y = parent.y + 48, alpha = 0}, 'in-sine', function()
				timer:after(1, function()
					cutscene:loadMap("abandoned_scene")
					black:remove()
					end_cutscene = true
				end)
			end)
		end

		local options = {
			Text("Encounter Bossfight", 0, 0),
			Text("Secret Bossfight", 0, 0),
			Text("Options", 0, 0),	
			Text("Credits", 0, 0),	
			Text("Quit", 0, 0),			
		}

		local dy = 0

		for k,v in ipairs(options) do
			v.y = dy
			v.inherit_color = true
			menu.max = menu.max + 1
			menu:addChild(v)
			dy = dy + 32
		end

		local arrow = Sprite("ui/flat_arrow_right", -24, 0)
		arrow:setScale(2)
		arrow.inherit_color = true

		Utils.hook(arrow, 'update', function(orig, arrow)
			arrow.y = (32 * menu.index) + 4

			orig(arrow)
		end)

		menu:addChild(arrow)

		timer:tween(1, parent, {y = parent.y + 32, alpha = 1}, 'out-sine')

		addToParent(logo)
		addToParent(menu)
		parent:addChild(timer)
		Game.world:spawnObject(parent, "ui")

		cutscene:wait(1)

		cutscene:wait(function()
			if Input.pressed("down") then
				Assets.playSound("ui_move")
				menu.index = (menu.index + 1) % menu.max
			elseif Input.pressed("up") then
				Assets.playSound("ui_move")
				menu.index = menu.index - 1
				if menu.index < 0 then menu.index = menu.max - 1 end
			end

			if Input.pressed("confirm") and menu.can_confirm then
				Assets.playSound("ui_select")

				local action = menu.actions[menu.index + 1]

				if action then action() end
			end

			return end_cutscene
		end)
	end,
}