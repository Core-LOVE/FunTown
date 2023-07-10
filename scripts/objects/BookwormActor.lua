local MyObject, super = Class(ActorSprite)

function MyObject:init(actor)
    super:init(self, actor)

	self.body = {}
	
	local dy = -9
	local col = 0.75
	
	for i = 1, 4 do
		local body = BookwormBody(4, dy)
		body.id = "body"
		body.layer = -5
		body.color = {col + 0.5, col + 0.5, col}
		
		self:addChild(body)
		table.insert(self.body, body)
		dy = dy + 9
		col = col - 0.25
	end

    self.head = BookwormHead(-2, -26)
    self.head.id = "head"
    self.head.layer = 1
    self:addChild(self.head)
end

function MyObject:removeBody()
	local last = self.body[1]
	
	if last == nil then return end
	
	last:remove()
	table.remove(self.body, 1)
	
	-- for k,body in ipairs(self.body) do
		-- local timer = Timer()
		
		-- body:addChild(timer)
		-- timer:tween(0.25, body, {y = body.y + 9}, nil, function()
			-- timer:remove()
		-- end)
	-- end
	
	local head = self.head
	local timer = Timer()
	
	head:addChild(timer)
	timer:tween(0.25, head, {y = head.y + 9}, 'elastic', function()
		timer:remove()
	end)
end

return MyObject