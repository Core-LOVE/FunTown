local MyWave, super = Class(Wave)

function MyWave:init()
	super:init(self)
	
	self.arena_width = 128
	self.arena_height = self.arena_width
	self.charges = {}
	self:setLayer(BATTLE_LAYERS.below_bullets)

	self.time = 7.5
end

function MyWave:spawnCharge(charge, x, y)
	local charge = Sprite("battle/eternal lumia/" .. charge, x, y)
	charge:setOrigin(.5)
	charge:setScale(0)
	charge:setLayer(BATTLE_LAYERS.ui + 1)
	charge.alpha = 0.75

	self.timer:tween(0.5, charge, {scale_x = 2, scale_y = 2}, 'out-expo')
	self:addChild(charge)

	return charge
end

do
	local function distance(x,y,xx,yy)
	    return math.sqrt(((x-xx)^2)+(y-yy)^2)
	end

	function MyWave:findPath(x, y, xx, yy)
		local cur = 0
		local dist = distance(x, y, xx, yy)
		local step = dist / 4

		if math.random() > 0.5 then
			step = dist / 6
		end

		local split = true

		local lines = {}
		local entries = {}

		local dx, dy = x, y
		local sign_x, sign_y = Utils.sign(xx - x), Utils.sign(yy - y)
		local stop = false

		while (cur < dist) do
			if split and math.random() > 0.25 then
				lines[#lines + 1] = dx
				lines[#lines + 1] = dy

				dx = dx + (step * sign_x)

				if (sign_x == 1 and dx > xx) or (sign_x == -1 and dx < xx) then
					dx = xx
					stop = true
				end

				lines[#lines + 1] = dx
				lines[#lines + 1] = dy
			else
				lines[#lines + 1] = dx
				lines[#lines + 1] = dy

				dy = dy + (step * sign_y)

				if (sign_y == 1 and dy > yy) or (sign_y == -1 and dy < yy) then
					dy = yy
					stop = true
				end

				lines[#lines + 1] = dx
				lines[#lines + 1] = dy
			end

			entries[#entries + 1] = {width = 0}

			split = not split
			cur = cur + step

			if stop then
				break
			end
		end

		lines[#lines + 1] = dx
		lines[#lines + 1] = dy

		dx = xx
		dy = yy

		lines[#lines + 1] = dx
		lines[#lines + 1] = dy

		entries[#entries + 1] = {width = 0}

		return lines, entries, step
	end
end

local old_px, old_py = 0, 0
local old_nx, old_ny = 0, 0

function MyWave:spawnCharges()
	local arena = Game.battle.arena

	local px, py = arena:getTopLeft()
	local nx, ny = 0, 0
	local is_horizontal = false
	local side = 1

	do
		local off = 26
		local off_d = off + off

		local x, y, xx, yy = arena:getLeft(), arena:getTop(), arena:getRight(), arena:getBottom()

		if math.random() > 0.5 then
			is_horizontal = true

			while px == old_px do
				px = Utils.pick{x, xx}
			end
			old_px = px

			py = math.random(y + off, yy - off_d)

			if px == xx then
				side = -1
			end
		else
			while py == old_py do
				py = Utils.pick{y, yy}
			end
			old_py = py

			px = math.random(x + off, xx - off_d)

			if py == yy then
				side = -1
			end
		end
	end

	do
		local off = 16
		local off_d = off + off
		local w, h = SCREEN_WIDTH - off_d, (SCREEN_HEIGHT - 155) - off_d

		if is_horizontal then
			nx = (px >= arena:getRight() and w) or off

			while math.abs(ny - py) < off_d do
				ny = math.random(off, h)
			end
		else
			ny = (py >= arena:getBottom() and h) or off

			while math.abs(nx - px) < off_d do
				nx = math.random(off, w)
			end
		end
	end

	local positive = self:spawnCharge("positive", px, py)
	local negative = self:spawnCharge("negative", nx, ny)
	local lines, entries, speed = self:findPath(nx, ny, px, py)

	self.timer:script(function(wait)
		local i = 1
		local delay = 0.075

		while true do
			if not entries[i] then
				break
			end

			self.timer:tween(delay, entries[i], {width = 4})
			wait(delay / 2)

			i = i + 1
		end
	end)

	self.timer:after(0.25, function()
		local bolt = self:spawnBullet("eternal lumia/bolt", nx, ny)
   	 	bolt:setHitbox(6, 3, 20, 10)
		bolt.physics.speed = 0
		bolt:setScale(1.5)

		local moving = true

		self.timer:after(#entries / 11, function()
			self:spawnCharges()
		end)

		self.timer:script(function(wait)
			while (moving) do
				local sprite = Sprite("effects/eternal lumia/clear_bolt", bolt.x, bolt.y)
				sprite.alpha = 0.5
				sprite:setOrigin(.5)
				sprite.rotation = bolt.rotation

				Game.battle.timer:tween(0.25, sprite, {alpha = 0, scale_x = 0, scale_y = 0}, nil, function()
					sprite:remove()
				end)

				Game.battle:addChild(sprite)
				wait(0.025)
			end
		end)

		self.timer:script(function(wait)
			local i = 1
			local seg = 1
			local delay = 0.2

			while true do
				if not entries[i] then
					break
				end

				local x, y, xx, yy = lines[seg], lines[seg + 1], lines[seg + 2], lines[seg + 3]

				self.timer:tween(0.05, bolt, {rotation = Utils.angle(x, y, xx, yy)})

				self.timer:tween(delay, bolt, {x = xx, y = yy}, 'out-sine')

				wait(delay)

				i = i + 1
				seg = seg + 4
			end

			local rot = math.rad(0)

			if is_horizontal and side == -1 then
				rot = math.rad(-180)
			elseif not is_horizontal then
				rot = math.rad(90)

				if side == -1 then
					rot = math.rad(-90)
				end
			end

			moving = false

			self.timer:tween(0.05, bolt, {rotation = rot})
			bolt.physics.speed = 6

			self.timer:tween(0.32, positive, {scale_x = 0, scale_y = 0}, 'out-expo')
			self.timer:tween(0.32, negative, {scale_x = 0, scale_y = 0}, 'out-expo')

			self.timer:script(function(wait)
				local i = 1
				local delay = 0.32 / #entries

				while true do
					if not entries[i] then
						break
					end

					self.timer:tween(delay, entries[i], {width = 0})
					wait(delay / 2)

					i = i + 1
				end

				for k,v in ipairs(self.charges) do
					if v.lines == lines then
						table.remove(self.charges, k)
					end
				end
			end)
		end)
	end)

	table.insert(self.charges, {positive = positive, negative = negative, lines = lines, entries = entries, is_horizontal = is_horizontal, side = side})
end

function MyWave:onStart()
	self:spawnCharges()
end

function MyWave:draw()
	for k,charge in ipairs(self.charges) do
		love.graphics.push('all')
		love.graphics.setColor(1, 1, 1, 0.25)

		local i = 1

		for seg = 1, #charge.lines, 4 do
			local x, y = charge.lines[seg], charge.lines[seg + 1]
			local xx, yy = charge.lines[seg + 2], charge.lines[seg + 3]

			local entry = charge.entries[i]

			love.graphics.setLineWidth(entry.width)
			love.graphics.line(x, y, xx, yy)

			i = i + 1
		end

		love.graphics.pop()
	end

	super.draw(self)
end

return MyWave