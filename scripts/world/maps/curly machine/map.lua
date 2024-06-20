local MyMap, super = Class(Map)

local function smoke(parent, parent2)
	local spr = Sprite("effects/machine/smoke", 8, 8)
	spr:setOrigin(.5, .5)
	spr:setScale(0.5)
	spr.alpha = 0.5
	spr.physics.speed_y = -4

	parent2:addChild(spr)
	return spr
end

local function gear(parent, x, y, scale)
	local spr = Sprite("other/machine gear", x, y)
	spr:setScale(scale or 2)
	spr:setOrigin(.5)
	spr.graphics.spin = 0.1

	local spr2 = Sprite("other/machine gear center", 0, 0)
	spr2:setRotationOrigin(.5)
	spr2.update = function()
		spr2.rotation = -spr.rotation
	end	
	spr:addChild(spr2)

	parent:addChild(spr)
	return spr, spr2
end

function MyMap:initBG()
	local parent = Object()
	parent.timer = Timer()

	do
		gear(parent, 32, 192)
		gear(parent, 108, 116, 1.5)
		gear(parent, 242, 192, 3)	
	end

	local function animate()
		parent.timer:tween(4, parent, {x = -640}, nil, function()
			parent.x = 0
			animate()
		end)
	end

	-- animate()
	parent:addChild(parent.timer)

	Game.world:spawnObject(parent, -100)
end

function MyMap:initPipes()
	local inverted = false

	local move = 48

	local parent = Object()
	parent.timer = Timer()

	for x = 32, 640 * 2, 80 do
		local y = (480 - 256)

		if inverted then
			y = y + move
		end

		local spr = Sprite("other/pipe", x - 16, y)

		local function runSmoke()
			parent.timer:script(function(wait)
				for i = 1, 3 do
					local s = smoke(parent, spr)

					parent.timer:tween(0.375, s, {alpha = 0, scale_x = 1.25, scale_y = 1.25}, nil, function()
						s:remove()
					end)

					wait(0.15)
				end
			end)
		end

		local function animate(inverted)
			local distance = (inverted and -move) or move

			parent.timer:tween(0.5, spr, {y = spr.y + distance}, 'in-out-sine', function()
				if inverted then runSmoke() end

				parent.timer:after(0.25, function()
					parent.timer:tween(0.5, spr, {y = spr.y - distance}, 'out-sine', function()
						if not inverted then runSmoke() end

						parent.timer:after(0.25, function() 
							animate(inverted) 
						end)
					end)
				end)
			end)
		end

		animate(inverted)
		spr:setScale(2)

		parent:addChild(spr)
		inverted = not inverted
	end

	local function animate()
		parent.timer:tween(4, parent, {x = -640}, nil, function()
			parent.x = 0
			animate()
		end)
	end

	animate()
	parent:addChild(parent.timer)

	Game.world:spawnObject(parent, 99)
end

function MyMap:onEnter()
	super.onEnter(self)

	-- if not Game.battle then
		-- cutscene(self)
	-- end

	self:initBG()
	self:initPipes()
end

return MyMap