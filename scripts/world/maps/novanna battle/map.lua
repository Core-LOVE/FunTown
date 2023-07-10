local MyMap, super = Class(Map)

function MyMap:initCharacters()
	local chars = {'kris', 'susie'}
	
	for k, character in ipairs(chars) do
		local character = Game.world:getCharacter(character)
		
		local transport = Sprite("other/ballon_bottom", -character.width * .5, character.height - 16)
		character:addChild(transport)
	end
end

function MyMap:onEnter()
	super.onEnter(self)
	self:initCharacters()
end

return MyMap