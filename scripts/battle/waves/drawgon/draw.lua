local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = 2
    self.enemy = self:getAttackers()[1]
end

local function update(self, wait)
	local enemy = self.enemy
	local soul = Game.battle.soul
	
	while true do
		if soul.x < enemy.x then
			enemy.physics.speed_x = enemy.physics.speed_x - 0.5
		else
			enemy.physics.speed_x = enemy.physics.speed_x + 0.5
		end
		
		enemy.physics.speed_x = Utils.clamp(enemy.physics.speed_x, -9, 9)
		wait()
	end
end

local function spawnPencil(self)
	Assets.playSound("drawgon_fire", 1, 6)

	local enemy = self.enemy
	local bullet = self:spawnBullet("drawgon/pencil", enemy.x, enemy.y - 40)
end

local function attack(self, wait)
	local enemy = self.enemy

	while true do
		wait(0.5)
		enemy:setAnimation('angry')
		wait(0.22)
		spawnPencil(self)
		wait(0.22)
		enemy:setAnimation('idle')	
		wait()
	end
end

function MyWave:onStart()
	local enemy = self.enemy
	enemy:setAnimation('idle')	
	
	self.orig_pos = {enemy.x, enemy.y}
    self.timer:tween(0.6, enemy, {y = enemy.y - 160}, 'out-circ', function()
		self.timer:script(function(wait)
			update(self, wait)
		end)
		
		self.timer:script(function(wait)
			attack(self, wait)
		end)
	end)
end

function MyWave:onEnd(death)
	local enemy = self.enemy
	local orig_pos = self.orig_pos
	local timer = Timer()
	
	enemy.physics.speed_x = 0
	enemy:setAnimation('idle')	
	
	enemy:addChild(timer)
    timer:tween(0.6, enemy, {x = orig_pos[1], y = orig_pos[2]}, 'out-circ', function()
		timer:remove()
	end)
end

return MyWave