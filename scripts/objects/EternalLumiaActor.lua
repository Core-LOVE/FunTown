local MyObject, super = Class(ActorSprite)
local id = "npcs/eternal_lumia/"

function MyObject:initLamp(actor)
	local obj = Sprite(id .. "lamp", actor.width - 26, actor.height - 18)
	obj:play(0.1)
	obj.id = "lamp"
	
	self:addChild(obj)
	self.parts[obj.id] = obj
end

function MyObject:initBody(actor)
	local obj = Sprite(id .. "body", actor.width - 26, actor.height - 18)
	obj:play(0.1)
	obj.id = "body"
	
	self:addChild(obj)
	self.parts[obj.id] = obj
end

function MyObject:init(actor)
    super:init(self, actor)
	
	self.parts = {}
	self:initLamp(actor)
	self:initBody(actor)
end

return MyObject