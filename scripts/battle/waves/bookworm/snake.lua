local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.arena_height = 128
	self.arena_width = 192
	
	self.time = 8
end

function MyWave:spawnApple()
	local arena = Game.battle.arena
	
	if arena == nil then return end
	
	local w, h = self.arena_width, self.arena_height
	
	local x = arena.x + math.random(-w, w)
	local y = arena.y + math.random(-h, h)
	
	local apple = self:spawnBullet("bookworm/apple", x, y)
	
	apple.x = math.floor(apple.x / 32) * 32
	apple.y = math.floor(apple.y / 32) * 32
	
	return apple
end

function MyWave:onStart()
	self:spawnApple()
	
	local arena = Game.battle.arena
	
	local body = self:spawnBullet("bookworm/snake", arena.x, arena.y + self.arena_height)
end

return MyWave