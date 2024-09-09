local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end

local credits = {}

credits[1] = [[



DELTARUNE: Fun Town
(Lumia)


by KateBulka
]]

credits[2] = [[



[color:999999]SFX:[color:reset]
Nintendo
OpenGameArt (VishwaJai, bonebrah, p0ss)
sfxr.me
bigsoundbank (Joseph SARDIN)
Freesound (PatrickLieberkind)
KateBulka
]]

credits[3] = [[





[color:999999]Code:[color:reset]
KateBulka
skarph (Green Shield's proper collisions)
]]

credits[4] = [[




Engine (Kristal) by

Kristal Team
]]

credits[5] = [[





[color:999999]Sprites:[color:reset]
Razor X
Basty
]]

credits[6] = [[





[color:999999]Sprites:[color:reset]
TNTVale (Video's Thumbnail)
riverstar.89 (Train's Sprite)
KateBulka
]]

credits[7] = [[




[color:999999]Music:[color:reset]
R.V. Pine
(Lumia, Shenanigans!)
DruidPC 
(GRAND ILLUSIONS, Realization/Credits)
KateBulka 
(GRAND ILLUSIONS, Dark Room)
]]

credits[8] = [[




[color:999999]Testing:[color:reset]
KateBulka
Razor X

]]

credits[9] = [[




[color:999999]Special Thanks:[color:reset]
SMBX2 Community
Love2D Community
Kristal Community
Wandering Makers
]]

credits[10] = [[




[color:999999]Special Thanks:[color:reset]
Andromedia
Mylazt
Nanareli
skroy
]]

credits[11] = [[




[color:999999]Special Thanks:[color:reset]
Greenlight
MrDoubleA
MonkeyMan
RottenBerry
]]

credits[12] = [[





[color:999999]Original Deltarune:[color:reset]
Toby Fox and his team
]]

credits[13] = [[







Thanks for playing! :3
]]

if Mod.VIDEO_MODE then
    credits[13] = [[







Thanks for watching! :3
]]

end

return function(cutscene)
	hide()

    do
        local text = Text("Press [Confirm] to skip...", 6, 6)
        text:setScale(.5)
        text.layer = black.layer + 1
        text.alpha = 0

        Game.world:addChild(text)
        Game.world.timer:tween(1, text, {alpha = 1}, nil, function()
            Game.world.timer:after(3, function()
                Game.world.timer:tween(1.5, text, {alpha = 0}, nil, function()
                    text:remove()
                end)
            end)
        end)
    end
    
    cutscene:wait(1)

    local text

    local sfx = Assets.playSound("realization")

    local handle = Game.world.timer:script(function(wait)
        while true do
            if Input.down("confirm") then
                sfx:stop()

                cutscene:endCutscene()
                cutscene:loadMap("splash")

                break
            end

            wait()
        end
    end)

    for k,credit in ipairs(credits) do
        if text then text:remove() end

        text = Text(credit, 0, 0, nil, nil, {
            align = "center"
        })
        text.layer = black.layer + 1

        Game.world:addChild(text)

        if k == 13 then
            text.alpha = 0
            text:fadeTo(1, 2)
        end

        if k == 6 then
            cutscene:wait(2)   
            text:fadeOutAndRemove(2)  
            cutscene:wait(2.5)
        else
            cutscene:wait(4)
        end
    end

    cutscene:wait(1)

    text:fadeOutAndRemove(3)

    cutscene:wait(5)

    Game.world.timer:cancel(handle)
    cutscene:endCutscene()
    cutscene:loadMap("splash")
end