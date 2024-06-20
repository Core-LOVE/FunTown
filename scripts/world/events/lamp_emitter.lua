local MyEvent, super = Class(Event)

local distance = 42

function MyEvent:animateLight(t, circ, mult)
	local rad = circ.width
	local alpha = circ.alpha
	local wait = 1
	local mult = mult or .75

	t:tween(wait, circ, {width = rad * mult, height = rad * mult, alpha = alpha * .75}, 'in-out-sine', function()
		t:tween(wait, circ, {width = rad, height = rad, alpha = alpha}, 'in-out-sine', function()
			self:animateLight(t, circ, mult)
		end)
	end)
end

function MyEvent:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

    local circ1 = Ellipse(20, 20, 50, 50)
    circ1:setColor(75 / 255, 1, 183 / 255)
    circ1.alpha = 0.15

    local circ2 = Ellipse(20, 20, 25, 25)
    circ2:setColor(75 / 255, 1, 183 / 255)
    circ2.alpha = 0.15

	local t = Timer()
	
	t:every(0.32, function()
		local part = Sprite("effects/homewoods_lamp_particle", 20, 20)
		part:setScale(math.random(1, 2))
		local live = math.random(2, 3) + .5

		t:tween(live, part, {
			x = part.x + math.random(-distance, distance),
			y = part.y + math.random(-distance, distance),
			alpha = 0,
			rotation = math.rad(math.random(0, 360))
		}, 'out-sine', function()
			part:remove()
		end)

		self:addChild(part)
	end)
	
	self.timer = t
	self:addChild(t)
	self:addChild(circ1)
	self:addChild(circ2)

	self:animateLight(t, circ1, 0.69)
	self:animateLight(t, circ2)
end

return MyEvent