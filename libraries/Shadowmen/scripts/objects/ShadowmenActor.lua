local MyObject, super = Class(ActorSprite)

function MyObject:init(actor)
    super:init(self, actor)
	
	local gun = Sprite("npcs/shadowmen/gun", -22, 24)
	gun.visible = false
	gun.layer = self.layer - 4
	gun.rotation_origin_x = 0.5
	gun.rotation_origin_y = 0.5
	self.draw_children_below = self.layer
	
	self.gun = gun
	self:addChild(gun)
	
	local socks = Sprite("npcs/shadowmen/socks", -64, 0)
	-- socks.visible = true
	socks.layer = self.layer - 4
	socks.rotation_origin_x = 0.5
	socks.rotation_origin_y = 0.5
	socks.hit = 0
	
	-- Utils.hook(socks, "update", function(orig, obj)
		-- orig(obj)
		-- obj:setFrame(self.frame)
	-- end)
	
	self.socks = socks
	self:addChild(socks)
end

-- function MyObject:update()
	-- super:update(self)
	
	-- self.socks.anim_routine = self.anim_routine
-- end

return MyObject