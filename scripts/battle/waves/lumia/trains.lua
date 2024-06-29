local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = 7.5
    self.enemies = self:getAttackers()
end

function MyWave:makeTrain(direction)
	Assets.playSound("choo_choo", 0.5)

	local move_y = 24

	local dx = 160 + 8
	local dy = 96
	local tracks = 3

	if (direction == 1) then
		tracks = 4
		dy = dy - (move_y * .5)
		move_y = 29
	end

	for track = 1, tracks do
		local old_dx = dx

		-- for i = 0, 8 do
		local spr = Sprite("battle/lumia/rail", dx, dy - move_y)
		spr:setScale(2)
		spr.alpha = 0
		spr.layer = BATTLE_LAYERS.arena + 1

		dx = (dx + 32)

		self.timer:tween(0.5, spr, {alpha = 0.25, y = spr.y + move_y}, 'out-sine', function()
			local train_x = 0

			if (direction == 1) then
				train_x = 256 - 32
			end

			local is_smoking = true
			local actually_smoking = (track == 1)

			for a = 1, (track == 1 and 4) or 3 do
				local bullet = self:spawnBullet("lumia/train", (is_smoking and "train_head") or "train_body", spr.x + train_x, spr.y + 6, actually_smoking)
				bullet:setScaleOrigin(.5)
				bullet.alpha = 0.25
				bullet.physics.speed_x = -1 * direction
				bullet.physics.friction = -0.2

				if (direction == 1) then
					bullet:setScale(-2, 2)
				end

				self.timer:tween(0.25, bullet, {alpha = 1})
				self.timer:after(1.2, function()
					self.timer:tween(0.5, bullet.physics, {friction = 0}, 'in-sine')

					self.timer:tween(0.5, bullet, {alpha = 0}, nil, function()
						bullet:remove()
					end)
				end)

				train_x = (train_x + (32 * direction))
				is_smoking = false
				actually_smoking = false
			end
		end)

		self.timer:after(0.5 + 1.2, function()
			self.timer:tween(0.25, spr, {alpha = 0}, nil, function()
				spr:remove()
			end)
		end)

		Game.battle:addChild(spr)
		table.insert(self._delete, spr)
		-- end

		dx = old_dx
		dy = dy + 48
	end
end

function MyWave:onStart()
	self._delete = {}
	self:makeTrain(-1)

	local direction = 1

	self.timer:every(0.5 + 1, function()
		self:makeTrain(direction)

		direction = -direction
	end)
end

function MyWave:onEnd(death)
	for k,v in ipairs(self._delete) do
		if v then
			v:remove()
		end
	end
end

return MyWave