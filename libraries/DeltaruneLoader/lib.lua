local lib = {}

function lib:init()
	local os_type = love.system.getOS()
	
	if os_type == "OS X" or os_type == "Windows" then
		DeltaruneLoader.init()
	end
end

return lib