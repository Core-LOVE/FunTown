local MyMap, super = Class(Map)

function MyMap:onEnter()
	super.onEnter(self)
	Game:removePartyMember("ralsei")
	Game:addPartyMember("ralsei")
	Game:setBorder("homewoods")
end

return MyMap