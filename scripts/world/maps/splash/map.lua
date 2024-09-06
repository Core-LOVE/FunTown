local MyMap, super = Class(Map)

local warning_text = {"DON'T FORGET", [[


This is a fan game, and it's not officially associated with Toby Fox and Deltarune. It doesn't have a goal to be "canon" or something.
This fan game contains flashing lights and screen shakees, so it may make it unsuitable for people with photosensitive epilepsy or other photosensitive conditions.]],
[[











Support Toby Fox's works!
deltarune.com / undertale.com]]}

function MyMap:stateActivate(state)
	if state == "INTRO" then
		local timer = Timer()
		local splash = Sprite("other/katebulka", (640 - 588) / 2, (-182 / 4))
		splash.alpha = 0
		splash:addChild(timer)

		timer:tween(1.5, splash, {y = splash.y + 182, alpha = 1}, 'in-out-sine')

		timer:after(3, function()
			timer:tween(1, splash, {y = splash.y + (182 / 2), alpha = 0}, 'in-sine', function()
				self:stateActivate("warning")
			end)
		end)

		Game.world:spawnObject(splash)

		Assets.playSound("katebulka")
	elseif state == "warning" then
		Assets.playSound("dont_forget_warning")		
	end

	self.state = state
end

function MyMap:onEnter()
	super.onEnter(self)
	Game:setBorder("simple")

	if Mod.flags.splash then
		Game.world:startCutscene("splash", "splash")
	else
		Game.world:startCutscene("splash", "menu")
	end

	Mod.flags.splash = false

	-- Game.world:startCutscene("splash", "menu")

	-- self.state = "warning"
	-- self:stateActivate(self.state)
end

function MyMap:draw()
	super.draw(self)

	if self.state == "warning" then
		local color = COLORS.red

		for k,text in ipairs(warning_text) do
			love.graphics.setColor(color)
			love.graphics.printf(text, 12, 24, SCREEN_WIDTH - 24, "center")
			love.graphics.setColor(COLORS.white)

			if color == COLORS.red then
				color = COLORS.white
			elseif color == COLORS.white then
				color = COLORS.yellow
			end
		end
	end
end

return MyMap