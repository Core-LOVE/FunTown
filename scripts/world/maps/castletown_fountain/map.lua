local MyMap, super = Class(Map)

local function cutscene(self)
	Game.world.fader.alpha = 1
	
	Game.world:startCutscene("knight/prebattle", self):after(function()
		
	end)
end

function MyMap:onEnter()
	super.onEnter(self)
	
	Game:removePartyMember("susie")
	Game:removePartyMember("ralsei")
	
    for _,follower in ipairs(Game.world.followers) do
        if follower.returning then
            follower:remove()
        end
    end
	
	-- if not Game.battle then
		-- cutscene(self)
	-- end
end

return MyMap