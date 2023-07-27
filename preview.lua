local preview = {}

preview.hide_background = true

local modScripts
local modPath = ""

local function require(path)
	return _G.require(modPath .. path)
end

local chapterSelect

local function postInit(mod, button, menu)
	local ChapterSelect = require("chapterselect")
	
	local chapterSelect = ChapterSelect()
end

function preview:init(mod, button, menu)
	if Kristal.Args["mod"] and Kristal.Args["mod"][1] == "funtown" then -- if we load fun town separately from kristal...
		modPath = (mod.path .. "/menu_scripts/")
		postInit(mod, button, menu)
	end
end

function preview:update()
	if chapterSelect then chapterselect:update() end
end

function preview:draw()
	if chapterSelect then chapterselect:draw() end
end

function preview:drawOverlay()

end

return preview