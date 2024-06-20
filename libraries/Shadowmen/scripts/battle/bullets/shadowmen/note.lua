local id = "shadowmen/note"
local MyBullet, super = Class(Bullet, id)

local count = 0.04

function MyBullet:init(x, y)
    super:init(self, x, y)

    self:setSprite("bullets/" .. id, 4 / 60, true)
	self:setScale(2)
	
    self:setHitbox(2, 2, 9, 9)
	self.t = 0
	
	if Kristal.getLibConfig("shadowmen", "play_sfx") then
		Assets.playSound("shadowmen_note", 4)
	end
	
	self.count = count
end

function MyBullet:update()
	super:update(self)
	
	local curve = self.curve
	
	if not curve then return end
	
	self.count = (self.count - 0.00025 * DTMULT)
	
	if self.count < 0 then
		self:remove()
		return
	end
	
	self.t = (self.t + self.count * DTMULT)
	if self.t > 1 then
		self.t = 1
	end
	
	local ex,ey = curve:evaluate(self.t)
	
	self.x = ex
	self.y = ey - 6
	
	local future = self.t + self.count
	
	if future > 1 then future = 1 end
    
	local nx, ny = curve:evaluate(future)
	
	self.rotation = Utils.angle(ex, ey, nx, ny) + math.rad(180)
end

return MyBullet