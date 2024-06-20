local RibbonTrail, super = Class(Object)

function RibbonTrail:init(x, y)
	super.init(self, x, y)
	
	self.points = {}
	
	self.timer = 0
	self.interval = 0.5
	
	self.instant = true
	
	self.maxLifetime = 1
	self.lifetime = self.maxLifetime
	
	self.width = 16
end

function RibbonTrail:update()
	self.timer = self.timer + 1
	
	local parent = self.parent
	
	if parent then
		self.x = parent.x
		self.y = parent.y
	end
	
	if self.instant then
		local w = (self.width / #self.points)
		
		if w >= 1 then
			table.insert(self.points, 1, {
				self.x, 
				self.y, 
			})
		end
	else
		if self.timer > self.interval then
			local w = (self.width / #self.points)
			
			if w >= 1 then
				table.insert(self.points, 1, {
					self.x, 
					self.y, 
				})
			end
			
			self.timer = 0
		end
	end
	
	self.points[1] = {
		self.x, 
		self.y, 
	}
	
	self.lifetime = self.lifetime - 1
	
	if self.lifetime < 0 then
		self.lifetime = self.maxLifetime
		self.points[#self.points] = nil
	end
end

function RibbonTrail:draw()
	super.draw(self)
	
	love.graphics.push()
	love.graphics.origin()

	local points = self.points
	
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)

	for k = 1, #points do
		local point1 = points[k]
		local point2 = points[k + 1]
		
		if point2 then
			local x1, y1 = point1[1], point1[2]
			local x2, y2 = point2[1], point2[2]
			
			local w = (self.width / k)
			
			if w < 1 then
				w = 1
			end
			
			love.graphics.setLineWidth(w)
			love.graphics.line(x1, y1, x2, y2)
		end
	end
	
	love.graphics.pop()
end

return RibbonTrail