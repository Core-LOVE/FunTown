local id = "bookworm/snake"
local MyBullet, super = Class(Bullet, id)

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id)
	
    self:setHitbox(0, 0, 8, 8)
	
	self.timer = Timer()
	self:addChild(self.timer)
	
	self.destroy_on_hit = false
	
	self.body = {}
	
	self.layer = self.layer + 10
end

function MyBullet:createBody(dx, dy)
	local dx, dy = dx or self.x, dy or self.y
	local body = self.wave:spawnBullet("bookworm/snake_body", dx, dy)
	
	table.insert(self.body, body)
	return body
end

local speed = 0.2

local function moveBody(self, dx, dy, id)
	local id = id or 1
	local body = self.body[id]
	
	if body == nil then 
		if id <= #self.body then
			moveBody(self, dx, dy, id + 1)
		end
		
		return 
	end
	
	body.timer:tween(speed, body, {x = body.x + dx, y = body.y + dy}, nil, function()
		moveBody(self, dx, dy, id + 1)
	end)
end

function MyBullet:moveToApple(apple)
	local apple = apple
	
	if apple == nil then
		for _, obj in ipairs(self.wave.bullets) do
			if obj.name == "Apple" then
				apple = obj
				break
			end
		end
	end
	
	local x, y = self.x, self.y
	local ox, oy = apple.x, apple.y
	local dx, dy = 0, 0
	
	if ox > x then dx = 32 elseif ox < x then dx = -32 end
	if oy > y then dy = 32 elseif oy < y then dy = -32 end
	
	if math.abs(ox - x) < math.abs(oy - y) then
		dx = 0
	else
		dy = 0
	end

	self.timer:tween(speed, self, {x = x + dx, y = y + dy}, nil, function()
		local new_apple

		if self:collidesWith(apple) then
			Assets.playSound("bookworm_collect")
			
			apple:remove("collision")
			new_apple = self.wave:spawnApple()
			
			do
				local lastBody = self.body[#self.body]
				lastBody.needsNew = true
				
				local newBody = self:createBody(lastBody.x, lastBody.y)
				newBody.timer = lastBody.timer
			end
		end

		moveBody(self, dx, dy)
		
		self:moveToApple(new_apple)
	end)
end

function MyBullet:update()
	super:update(self)
	
	if self._start == nil then
		self:createBody()
		
		self._start = true
		self:moveToApple()
	end	
end

function MyBullet:remove()
	for k,obj in ipairs(self.body) do
		obj:remove()
	end
	
	super:remove(self)
end

return MyBullet