local function break_button(btn)
	local t = {}
	local ox, oy = 339, 335
		
	for x = 0, 15, 15 do
		for y = 0, 16, 16 do
			local spr = Sprite(btn.texture, ox, oy)
			spr.cutout_left = x
			spr.cutout_top = y
			spr.cutout_right = (x == 0 and 15) or 0
			spr.cutout_bottom = (y == 0 and 16) or 0
			
			spr.physics.speed_x = (x == 0 and -4) or 4
			spr.physics.speed_y = (y == 0 and -8) or -4
			spr.physics.gravity = 0.5
			
			spr:setLayer(BATTLE_LAYERS.top)
			
			Game.battle:addChild(spr)
			table.insert(t, spr)
		end
	end
	
	btn:remove()
	return t
end

return {
	no_mercy = function(cutscene, enemy)
		local battle_ui = Game.battle.battle_ui
		local kris = cutscene:getCharacter('kris')
		local rect = Rectangle(-64, -64, SCREEN_WIDTH + 64, SCREEN_HEIGHT + 64)
		rect.alpha = 0
		
		Game.battle:addChild(rect)
		rect:setLayer(BATTLE_LAYERS.top - 1)
		
		battle_ui:clearEncounterText()
		
		local kris_after = AfterImage(kris, 0.5)
		kris:addChild(kris_after)
		
		Assets.playSound('tensionhorn')
		cutscene:setAnimation(kris, 'sword_jump_settle')
		
		cutscene:wait(0.4)
		
		local kris_after = AfterImage(kris, 0.5)
		kris:addChild(kris_after)
		
		cutscene:slideTo(kris, 352, kris.y, 0.5, 'out-sine')
		cutscene:wait(0.5)
		
		cutscene:setAnimation(kris, 'fall_sword')
		-- Game.fader:setLayer(BATTLE_LAYERS.top + 1)
		kris:setLayer(BATTLE_LAYERS.top)
		
		local kris_after = AfterImage(kris, 0.5)
		kris:addChild(kris_after)
			
		Assets.playSound('bigcut')	
		cutscene:slideTo(kris, kris.x, kris.y + 480, 1)
		
		cutscene:wait(0.1)
		cutscene:shakeCamera(6)
		
		local kris_after = AfterImage(kris, 0.5)
		kris:addChild(kris_after)
		
		local echo = 1
		Assets.playSound('scytheburst')
		echo = echo - 0.2
		
		local ui = Game.battle.battle_ui.action_boxes[1]
		local pieces
		
		for i, btn in ipairs(ui.buttons) do
			if btn.type == 'spare' then
				pieces = break_button(btn)
				
				table.remove(ui.buttons, i)
				break
			end
		end
		
		local t = Timer()
		
		t:tween(2, kris_after, {scale_x = 8, scale_y = 8})
		
		t:tween(0.5, rect, {alpha = 1})
		t:every(0.1, function()
			if echo > 0 then
				Assets.playSound('scytheburst', echo * .5, echo * 1.5)
				echo = echo - 0.2
			end
			
			local kris_after = AfterImage(kris, 0.5)
			kris:addChild(kris_after)
		end)
		
		-- for _, piece in ipairs(pieces) do
			-- t:tween(0.25, piece, {color = {0, 0, 0}})	
		-- end
		
		Game.battle:addChild(t)
		
		cutscene:wait(2.5)
		
		cutscene:fadeOut(1)
		cutscene:wait(5)
	end,
}