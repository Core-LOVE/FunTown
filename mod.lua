function Mod:init()
	local os_type = love.system.getOS()
	
	if os_type == "OS X" or os_type == "Windows" then
		-- Loads all Deltarune saves from Chapter 2
		DeltaruneLoader.load({chapter = 2})
	end
end