local MyMap, super = Class(Map)

function MyMap:onEnter()
	super.onEnter(self)
	Game:removePartyMember("ralsei")
	Game:addPartyMember("ralsei")
	Game:setBorder("homewoods")

    Game.fader:fadeIn(nil, {alpha = 1, speed = 0.5})
end

return MyMap