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

		local hold_t = 3

		if Mod.VIDEO_MODE then
			cutscene:wait(0.5)
			hold_t = 3.5
		end

		Assets.stopAndPlaySound("katebulka")

		local continue = false
		local timer = Timer()
		local splash = Sprite("other/katebulka", (640 - 588) / 2, (-182 / 4))
		splash.alpha = 0

		if Mod.VIDEO_MODE then
			local boosty = Sprite("other/boosty")
			boosty:setRotationOrigin(.5)
			boosty:setScale(2)
			boosty.inherit_color = true
			boosty.y = SCREEN_HEIGHT - 48
			boosty.rotation = math.rad(42)
			splash:addChild(boosty)

			timer:tween(1.5, boosty, {y = boosty.y - 160}, 'in-out-sine')	
			timer:tween(1, boosty, {rotation = math.rad(0)}, 'in-bounce')	

			timer:after(hold_t, function()
				timer:tween(1, boosty, {y = boosty.y - (182 / 5)}, 'in-sine')
			end)
		end

		timer:tween(1.5, splash, {y = splash.y + 182, alpha = 1}, 'in-out-sine')

		timer:after(hold_t, function()
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

		if Mod.VIDEO_MODE then
			cutscene:wait(2)
			cutscene:loadMap("homewoods_lumia")
			black:remove()
			end_cutscene = true
			Mod:_getItems()
		else
			cutscene:gotoCutscene("splash", "menu")
		end
	end,

	menu = function(cutscene)
		local end_cutscene = false

		hide()
		Game.world.music:play("findher", 1)

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
		menu.can_move = true
		menu.index = 0
		menu.max = 0

		local arrow

	local function startMenu()
		menu.actions = {}
		menu.hover = {}
		menu.text = {}
		
		Game:saveQuick()

		menu.actions[1] = function()
			menu.can_confirm = false

			Game.world.music:fade(0, 0.5)

			if Mod:_readOptionEntry("Instant") then
				Assets.playSound("lumia battle start")
				Assets.playSound("lumia battle start")
			end

			timer:tween(1, parent, {y = parent.y + 48, alpha = 0}, 'in-sine', function()
				timer:after(1, function()
					if Mod:_readOptionEntry("Instant") then
						Mod:_getItems()
						black:remove()
						cutscene:loadMap("arena")
						cutscene:startEncounter("lumia")

						Game.battle.encounter.onBattleEnd = function()
							cutscene:endCutscene()
							return Game.world:loadMap("splash")
						end

						end_cutscene = true
					else
						cutscene:loadMap("homewoods_lumia")
						black:remove()
						end_cutscene = true
						Mod:_getItems()
					end
				end)
			end)
		end

		menu.actions[2] = function()
			menu.can_confirm = false

			if Mod:_readOptionEntry("Instant") then
			    Assets.playSound("eternal lumia laugh", 0.5, 0.5)
			    Assets.playSound("eternal lumia laugh", 0.5)
			    Assets.playSound("eternal lumia laugh", 0.5, 1.3)
			end

			Game.world.music:fade(0, 0.5)
			timer:tween(1, parent, {y = parent.y + 48, alpha = 0}, 'in-sine', function()
				timer:after(1, function()
					if not Mod:_readOptionEntry("Instant") then
						cutscene:loadMap("abandoned_scene")
						black:remove()
						end_cutscene = true
						Mod:_getItems()
					else
						Mod:_getItems()
						black:remove()
						cutscene:loadMap("eternal lumia arena")
						cutscene:startEncounter("eternal lumia")

						cutscene:endCutscene()
						end_cutscene = true
					end
				end)
			end)
		end

		menu.actions[4] = function()
			menu.can_confirm = false

			Game.world.music:fade(0, 0.5)
			timer:tween(1, parent, {y = parent.y + 48, alpha = 0}, 'in-sine', function()
				timer:after(1, function()
					black:remove()
					cutscene:endCutscene()
					Game.world:startCutscene("credits")
				end)
			end)
		end

		do
			local handle

			menu.actions[6] = function()
				local icon = menu.text[6]
				icon.rotation = math.rad(math.random(-8, 8))

				if handle then timer:cancel(handle) end

				handle = timer:tween(0.5, icon, {rotation = math.rad(0)}, 'in-bounce')

				love.system.openURL("https://boosty.to/katebulka")
			end
		end

		menu.actions[3] = function()
			parent.y = parent.y - 128
			parent.alpha = 0
			logo.visible = false

			timer:tween(1, parent, {y = parent.y + 32, alpha = 1}, 'out-sine')

			for k,v in ipairs(menu.text) do
				v:remove()
			end

			menu.text = {}
			menu.max = 0
			menu.actions = {}

			local toRemove = {}
			local totalCounters = {}
			local cursor_x = arrow.x
			local timerHandle

			local categoryText = Text("Category: Items", -16, -48)
			categoryText.inherit_color = true
			categoryText.alpha = 0.75
			table.insert(toRemove, categoryText)

			local helpText = Text("", -26, -96)
			helpText.inherit_color = true
			helpText:setScale(1.05)
			table.insert(toRemove, helpText)

			local controls = [[Press [Left/Right] to change values
Press [Confirm] to save the change
Press [Menu] to change value to default
Press [Cancel] or any other button to revert changes
]]

			local controlsText = Text(controls, -32, 256 + 16)
			controlsText.inherit_color = true
			controlsText:setScale(0.5)
			table.insert(toRemove, controlsText)

			menu:addChild(helpText)
			menu:addChild(categoryText)
			menu:addChild(controlsText)

			local function hover(count, text, category)
				menu.hover[count] = function()
					local counter = menu.text[count].counter

					categoryText:setText("Category: " .. (category or "Items"))
					helpText:setText(text .. counter.default)
				end
			end

			hover(1, "Heals 110 HP. ")
			hover(2, "Heals 50 HP. ")
			hover(3, "Heals 90 HP. ")
			hover(4, "Revives team 100% HP. ")
			hover(5, "No Hit Mode. ", "Other")
			hover(6, "Goes instantly into battles. ", "Other")

			menu.hover[7] = function()
				categoryText:setText("")
				helpText:setText("Go back to the menu")
			end

			local function actionBool(count)
				menu.actions[count] = function()
					local can_confirm = false
					local counter = menu.text[count].counter
					counter.color = {1, 1, 0}

					timer:script(function(wait)
						local origVal = counter.val

						if timerHandle then timer:cancel(timerHandle) end
						timerHandle = timer:tween(0.35, arrow, {x = cursor_x + 400}, 'out-expo')

						while true do
							if Input.pressed("right") or Input.pressed("left") then
								Assets.playSound("noise")

								counter.val = not counter.val
							elseif Input.pressed("menu") then
								Assets.playSound("ui_cancel_small")

								counter.val = counter.real_default
							end

							if Input.pressed("cancel") or (Input.pressed("confirm") and can_confirm) or Input.pressed("down") or Input.pressed("up") then
								if Input.pressed("confirm") then
									Assets.playSound("ui_select")
								else
									counter.val = origVal

									Assets.playSound("ui_cancel_small")
								end

								counter.color = {1, 1, 1}
								counter:setText(tostring(counter.val))
								menu.can_confirm = false

								break
							end

	 						counter:setText(tostring(counter.val))

	 						can_confirm = true
							wait()
						end

						wait()

						if timerHandle then timer:cancel(timerHandle) end
						timerHandle = timer:tween(0.35, arrow, {x = cursor_x}, 'out-sine')

						menu.can_confirm = true
					end)
				end
			end

			local function actionInt(count)
				menu.actions[count] = function()
					local can_confirm = false
					local counter = menu.text[count].counter
					counter.color = {1, 1, 0}

					timer:script(function(wait)
						local origVal = counter.val

						if timerHandle then timer:cancel(timerHandle) end
						timerHandle = timer:tween(0.35, arrow, {x = cursor_x + 400}, 'out-expo')

						while true do
							if Input.pressed("right") then
								Assets.playSound("noise")

								counter.val = counter.val + 1
							elseif Input.pressed("left") then
								Assets.playSound("noise")

								counter.val = counter.val - 1
							elseif Input.pressed("menu") then
								Assets.playSound("ui_cancel_small")

								counter.val = counter.real_default
							end

							counter.val = Utils.clamp(counter.val, 0, 99)

							if Input.pressed("cancel") or (Input.pressed("confirm") and can_confirm) or Input.pressed("down") or Input.pressed("up") then
								if Input.pressed("confirm") then
									Assets.playSound("ui_select")
									menu.can_confirm = false
								else
									counter.val = origVal

									Assets.playSound("ui_cancel_small")
								end

								counter.color = {1, 1, 1}
								counter:setText(tostring(counter.val))

								break
							end

	 						counter:setText(tostring(counter.val))

	 						can_confirm = true
							wait()
						end

						wait()

						if timerHandle then timer:cancel(timerHandle) end
						timerHandle = timer:tween(0.35, arrow, {x = cursor_x}, 'out-sine')

						menu.can_confirm = true
					end)
				end
			end

			actionInt(1)
			actionInt(2)
			actionInt(3)
			actionInt(4)
			actionBool(5)
			actionBool(6)

			menu.actions[7] = function()
				menu.index = 0

				local modOptions = Mod._options

				for num, counter in ipairs(totalCounters) do
					local value = counter.val
					local default = modOptions.default[num]

					if value ~= default then
						Mod._options.values[num] = tostring(value)
					else
						Mod._options.values[num] = "nil"
					end

					print(modOptions.default[num], modOptions.values[num])
				end

				local success, err = Kristal.saveData("options", modOptions)
				print(success, err)

				for k,v in ipairs(toRemove) do
					v:remove()
				end

				parent.y = 0
				parent.alpha = 0
				logo.visible = true

				timer:tween(1, parent, {y = parent.y + 32, alpha = 1}, 'out-sine')

				for k,v in ipairs(menu.text) do
					v:remove()
				end

				menu.text = {}
				menu.max = 0
				menu.actions = {}

				startMenu()
			end

			local function TextWithNumber(text, val, def)
				local val = val or def or 0

				local count = Text(tostring(val), 416, text.y)
				count.inherit_color = true
				count.val = val
				count.default = "(Default: " .. tostring(def or 0) .. ")"
				count.real_default = def or 0
				table.insert(toRemove, count)
				table.insert(totalCounters, count)

				text.counter = count

				menu:addChild(count)
				return text
			end

			local function TextWithBool(text, val, def)
				local val = (val ~= nil and val) or (def ~= nil and def) or false

				local count = Text(tostring(val), 416, text.y)
				count.inherit_color = true
				count.val = val
				count.default = "(Default: " .. tostring((def ~= nil and def) or false) .. ")"
				count.real_default = (def ~= nil and def) or false
				table.insert(toRemove, count)
				table.insert(totalCounters, count)

				text.counter = count

				menu:addChild(count)
				return text
			end

			local modOptions = Mod._options

			local function getInt(num)
				return tonumber(modOptions.values[num])
			end

			local function getBool(num)
				local str = modOptions.values[num]
			    local bool = false

			    if str == "true" then
			        bool = true
			    elseif str == "nil" then
			    	return nil
			    end

			    return bool
			end

			local function getDefault(num)
				return modOptions.default[num]
			end

			local options = {
				TextWithNumber(Text("FuzzyPizza", 0, 0), getInt(1), getDefault(1)),
				TextWithNumber(Text("Koola", 0, 0), getInt(2), getDefault(2)),
				TextWithNumber(Text("Pop!Corn", 0, 0), getInt(3), getDefault(3)),	
				TextWithNumber(Text("ReviveBrite", 0, 0), getInt(4), getDefault(4)),	
				TextWithBool(Text("No ShadowMantle (No Hit)", 0, 0), getBool(5), getDefault(5)),
				TextWithBool(Text("Instant Mode", 0, 0), getBool(6), getDefault(6)),			
				Text("Back", 0, 0),
				-- Text("Credits", 0, 0),	
				-- Text("Quit", 0, 0),			
			}

			local dy = 0

			for k,v in ipairs(options) do
				v.y = dy
				v.x = v.x + 32
				v.inherit_color = true

				if v.counter then
					v.counter.y = v.y
				end

				menu.max = menu.max + 1
				menu:addChild(v)
				table.insert(menu.text, v)
				dy = dy + 32
			end	
		end

		local function boosty()
			local obj = Sprite("other/boosty", 0, 12)
			obj:setScale(2)
			obj.skip = true
			obj:setRotationOrigin(.5)

			return obj
		end

		local options = {
			Text("Encounter Bossfight", 0, 0),
			Text("Secret Bossfight", 0, 0),
			Text("Options", 0, 0),	
			Text("Credits", 0, 0),	
			Text("Quit", 0, 0),		
			boosty(),
		}

		local dy = 0

		for k,v in ipairs(options) do
			v.y = v.y + dy
			v.inherit_color = true

			menu.max = menu.max + 1

			menu:addChild(v)
			table.insert(menu.text, v)
			dy = dy + 32
		end
	end

		startMenu()

		arrow = Sprite("ui/flat_arrow_right", -24, 0)
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

				if menu.hover[menu.index + 1] then menu.hover[menu.index + 1]() end
			elseif Input.pressed("up") then
				Assets.playSound("ui_move")
				menu.index = menu.index - 1
				if menu.index < 0 then menu.index = menu.max - 1 end

				if menu.hover[menu.index + 1] then menu.hover[menu.index + 1]() end
			end

			if Input.pressed("confirm") and menu.can_confirm then
				Assets.playSound("ui_select")

				local action = menu.actions[menu.index + 1]

				if action then action() end
			end

			return end_cutscene
		end)

		cutscene:endCutscene()
	end,
}