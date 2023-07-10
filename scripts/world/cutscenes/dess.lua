return function(cutscene, event, player, facing)
    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
    local dess = cutscene:getCharacter("dess")
	
	cutscene:text("* Uhm...[wait:8] Hi, I guess??", "what", dess)
	cutscene:text("* My name is December Holiday![wait:8] You can also call me[wait:4] Dess!", "smile", dess)
	cutscene:text("* ...", "smile", dess)
	cutscene:text("* Damn,[wait:4] I'm really starting to look crazy,[wait:4] isn't it?", "sad", dess)
	cutscene:text("* Azzy told me cameras are very useful sometimes.", "neutral", dess)
	cutscene:text([[* "Otherworld creatures talk via electronic stuff"]], "another_smile", dess)
	cutscene:text("* Hahaha![wait:8] Haha...", "smile", dess)
	cutscene:text("* Ha...", "another_smile", dess)
	cutscene:text("* Welp,[wait:4] here I am![wait:6] In this...[wait:6] Weird place.", "another_smile", dess)
	cutscene:text("* ... Hoping that my voice and music will be heard.", "another_sad", dess)
	
	dess:setAnimation('sit')
end