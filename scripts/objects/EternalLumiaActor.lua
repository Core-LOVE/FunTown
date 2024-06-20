local MyObject, super = Class(ActorSprite)
local id = "npcs/eternal_lumia/"

function MyObject:initCamera(actor)
	local obj = Sprite(id .. "camera_base", actor.width - 26, actor.height - 18)
	obj.id = "camera"
	
	self:addChild(obj)
	self.parts[obj.id] = obj
	
	local rot = Sprite(id .. "camera_rot", 18, -6)
	rot.id = "reel"
	rot:setScale(.75)
	rot:setOrigin(.5, .5)
	rot.graphics.spin = 0.1
	self.parts[rot.id] = rot
	obj:addChild(rot)
	
	local handle = Sprite(id .. "camera_handle_1", 32 + 5, 8)
	handle.id = "handle"
	handle:setOrigin(.5, .5)
	self.parts[handle.id] = handle
	obj:addChild(handle)
	
	local handle_b = Sprite(id .. "camera_handle_2", 5, 8)
	handle_b.id = "handle_b"
	handle_b:setOrigin(.5, .5)
	
	Utils.hook(handle_b, 'update', function(orig, _)
		orig(handle_b)
		
		local part = self.parts.reel
		
		if not part then return end
		
		handle_b.scale_y = math.sin(part.rotation * .5)
	end)
	
	self.parts[handle_b.id] = handle_b
	handle:addChild(handle_b)
end

function MyObject:initBody(actor)
	local obj = Sprite(id .. "body", 2, 23)
	obj.id = "body"
	
	self:addChild(obj)
	self.parts[obj.id] = obj
	
	local heart = Sprite(id .. "heart", 4, 2)
	heart:setOrigin(.5, .5)
	heart:setScale(.9, 1)
	heart.id = "heart"
	heart.draw_children_below = 0
	self.parts[heart.id] = heart
	
	local heart_b = Sprite(id .. "heart_b", 2, 0)
	heart_b.layer = -1
	heart_b.update = function()
		heart_b.scale_x = math.abs(heart.scale_x - 1) + 1
		
		if heart.scale_x > 1 then
			heart_b.scale_x = 0.96
		end
	end
	heart:addChild(heart_b)
	
	obj:addChild(heart)
	heart:setLayer(self.layer + 1)
	
	-- head stuff
	local head = Sprite(id .. "head", -28, -56)
	head.id = "head"
	head:play(0.1)
	
	Utils.hook(head, 'update', function(orig, self)
		orig(self)
		
		self.x = (self.init_x + (heart.scale_x * 6)) - 6
	end)
	
	self.parts[head.id] = head
	
	obj:addChild(head)
	head:setLayer(self.layer + 2)
	
	local headFrames = Sprite(id .. "headFrames", 42, 6)
	headFrames:play(0.2)
	headFrames.id = "headFrames"
	self.parts[headFrames.id] = headFrames
	
	head:addChild(headFrames)
end

function MyObject:heartAnimation()
	self.timer:tween(.75, self.parts.heart, {scale_x = 1.1}, 'in-out-sine', function()
		self.timer:tween(.75, self.parts.heart, {scale_x = 0.75}, 'in-out-sine', function()
			self:heartAnimation()
		end)
	end)
end

function MyObject:reelSpin()
	local part = self.parts.reel
	
	part.graphics.spin = 0.32
	
	self.timer:tween(1, part.graphics, {spin = 0.1}, 'out-circ', function()
		self:reelSpin()
	end)
end

function MyObject:bodyEffect()
	local part = self.parts.body
	
	local curve = love.math.newBezierCurve{
		4, -8,
		0, 28,
		8, 20,
		16, 18,
		32, 12,
		34, 20,
		36, 28,
		36, 32,
	}
	local derivative = curve:getDerivative()
	
	self.timer:every(.4, function()
		local t = 0
		local spr = Sprite(id .. "body_effect_1", 6, 2)
		spr:setOrigin(.5, .5)
		spr:setScale(1.64)
		spr.alpa = 1.25
		
		Utils.hook(spr, 'update', function(orig, self)
			orig(self)
			
			t = t + 0.032
			
			if t > 1 then
				self:remove()
				return
			end
			
			local ex,ey = curve:evaluate(t)
			local dx,dy = derivative:evaluate(t)
			
			self.x, self.y = ex + 3, ey + 2
			self.rotation = math.atan2(dy,dx)+math.pi * .5
			self:setScale(spr.scale_y - 0.025)
			self.alpha = self.alpha - 0.032
		end)
		
		part:addChild(spr)
	end)
	
	self.timer:every(.2, function()
		local t = 0
		local spr = Sprite(id .. "body_effect_2", 6, 2)
		spr:setOrigin(.5, .5)
		spr:setScale(1.5)
		spr.alpa = 1
		
		Utils.hook(spr, 'update', function(orig, self)
			orig(self)
			
			t = t + 0.0321
			
			if t > 1 then
				self:remove()
				return
			end
			
			local ex,ey = curve:evaluate(t)
			local dx,dy = derivative:evaluate(t)
			
			self.x, self.y = ex + 4, ey + 2
			self.rotation = math.atan2(dy,dx)+math.pi * .5
			self:setScale(spr.scale_y - 0.032)
			self.alpha = self.alpha - 0.032
		end)
		
		part:addChild(spr)
	end)
end

function MyObject:bodyAnimation()
	local part = self.parts.body
	local wait = .5
	local offset = 2
	local style = 'in-out-sine'
	
	self.timer:tween(wait, part, {scale_y = 1.025, y = part.y + offset}, style, function()
		self.timer:tween(wait, part, {scale_y = 0.96, y = part.y - offset}, style, function()
			self:bodyAnimation()
		end)
	end)
end

function MyObject:setHeadAnimation(name, speed, loop, f)
	local head = self.parts.head

	if name == nil then
		head:setSprite(id .. "head")
		head:play(0.1)
		
		return
	end
	
	head:setSprite(id .. "head/" .. name)
	head:play(speed or 0.1, loop, f)
end

function MyObject:init(actor)
    super:init(self, actor)
	
	self.parts = {}
	self:initCamera(actor)
	self:initBody(actor)
	
	self.timer = Timer()
	
	self:heartAnimation()
	self:reelSpin()
	self:bodyEffect()
	self:bodyAnimation()
	
	self:addChild(self.timer)
end

return MyObject