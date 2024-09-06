local MyMap, super = Class(Map)

function MyMap:load()
    Game.fader:fadeIn(nil, {alpha = 1, speed = 0.5})
end

return MyMap