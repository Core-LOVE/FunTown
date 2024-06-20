local Lib = {}

local function removeChild(self, stage)
	for k,child in ipairs(stage) do
		if self == child then
			table.remove(stage, k)
			break
		end
	end
end

_G.Transstaging = function(self)
	Utils.hook(self, "update", function(orig, self)
		orig(self)
		
		self._in_battle = self._in_battle or false
		
		if Game.battle and not self._in_battle then
			removeChild(self, Game.world)
			Game.battle:addChild(self)
			self:setLayer(self.layer)
			
			self._in_battle = true
		elseif not Game.battle and self._in_battle then
			removeChild(self, Game.battle)
			Game.world:addChild(self)
			self:setLayer(self.layer)
			
			self._in_battle = false
		end
	end)
end

return Lib