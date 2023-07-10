local BattleUI, super = Class('BattleUI')

Utils.hook(BattleUI, 'drawState', function(orig, self)
	local selecting = Game.battle.party[Game.battle.current_selecting].chara
	
	if Game.battle.state == "ENEMYSELECT" or Game.battle.state == "XACTENEMYSELECT" then
        local enemies = Game.battle:getActiveEnemies()

        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#enemies / 3) - 1
        local page_offset = page * 3

        love.graphics.setColor(Game.battle.encounter:getSoulColor())
        love.graphics.draw(self.heart_sprite, 55, 30 + ((Game.battle.current_menu_y - page_offset) * 30))

        local font = Assets.getFont("main")
        love.graphics.setFont(font)

        local draw_mercy = Game:getConfig("mercyBar")
        local draw_percents = Game:getConfig("enemyBarPercentages")

        love.graphics.setColor(1, 1, 1, 1)

        if draw_mercy then
            if Game.battle.state == "ENEMYSELECT" then
                love.graphics.print("HP", 424, 39, 0, 1, 0.5)
            end
            love.graphics.print("MERCY", 524, 39, 0, 1, 0.5)
        end

        for index = page_offset+1, math.min(page_offset+3, #enemies) + 1 do
            local y_off = (index - page_offset - 1) * 30

			if index == math.min(page_offset+3, #enemies) + 1 then
				love.graphics.setColor(selecting:getXActColor())
                love.graphics.print("K-Magic", 80, 50 + y_off)
				break
			end
			
            local enemy = enemies[index]
			
            local name_colors = enemy:getNameColors()
            if type(name_colors) ~= "table" then
                name_colors = {name_colors}
            end

            if #name_colors <= 1 then
                love.graphics.setColor(name_colors[1] or enemy.selectable and {1, 1, 1} or {0.5, 0.5, 0.5})
                love.graphics.print(enemy.name, 80, 50 + y_off)
            else
                -- Draw the enemy name to a canvas first
                local canvas = Draw.pushCanvas(font:getWidth(enemy.name), font:getHeight())
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(enemy.name)
                Draw.popCanvas()

                -- Define our gradient
                local color_canvas = Draw.pushCanvas(#name_colors, 1)
                for i = 1, #name_colors do
                    -- Draw a pixel for the color
                    love.graphics.setColor(name_colors[i])
                    love.graphics.rectangle("fill", i-1, 0, 1, 1)
                end
                Draw.popCanvas()

                -- Reset the color
                love.graphics.setColor(1, 1, 1)

                -- Use the dynamic gradient shader for the spare/tired colors
                local shader = Kristal.Shaders["DynGradient"]
                love.graphics.setShader(shader)
                -- Send the gradient colors
                shader:send("colors", color_canvas)
                shader:send("colorSize", {#name_colors, 1})
                -- Draw the canvas from before to apply the gradient over it
                love.graphics.draw(canvas, 80, 50 + y_off)
                -- Disable the shader
                love.graphics.setShader()
            end

            love.graphics.setColor(1, 1, 1)

            local spare_icon = false
            local tired_icon = false
            if enemy.tired and enemy:canSpare() then
                love.graphics.draw(self.sparestar, 80 + font:getWidth(enemy.name) + 20, 60 + y_off)
                love.graphics.draw(self.tiredmark, 80 + font:getWidth(enemy.name) + 40, 60 + y_off)
                spare_icon = true
                tired_icon = true
            elseif enemy.tired then
                love.graphics.draw(self.tiredmark, 80 + font:getWidth(enemy.name) + 40, 60 + y_off)
                tired_icon = true
            elseif enemy.mercy >= 100 then
                love.graphics.draw(self.sparestar, 80 + font:getWidth(enemy.name) + 20, 60 + y_off)
                spare_icon = true
            end

            for i = 1, #enemy.icons do
                if enemy.icons[i] then
                    if (spare_icon and (i == 1)) or (tired_icon and (i == 2)) then
                        -- Skip the custom icons if we're already drawing spare/tired ones
                    else
                        love.graphics.setColor(1, 1, 1, 1)
                        love.graphics.draw(enemy.icons[i], 80 + font:getWidth(enemy.name) + (i * 20), 60 + y_off)
                    end
                end
            end

            if Game.battle.state == "XACTENEMYSELECT" then
                love.graphics.setColor(selecting:getXActColor())
                if Game.battle.selected_xaction.id == 0 then
                    love.graphics.print(enemy:getXAction(Game.battle.party[Game.battle.current_selecting]), 282, 50 + y_off)
                else
                    love.graphics.print(Game.battle.selected_xaction.name, 282, 50 + y_off)
                end
            end

            if Game.battle.state == "ENEMYSELECT" then
                local namewidth = font:getWidth(enemy.name)

                love.graphics.setColor(128/255, 128/255, 128/255, 1)

                if ((80 + namewidth + 60 + (font:getWidth(enemy.comment) / 2)) < 415) then
                    love.graphics.print(enemy.comment, 80 + namewidth + 60, 50 + y_off)
                else
                    love.graphics.print(enemy.comment, 80 + namewidth + 60, 50 + y_off, 0, 0.5, 1)
                end


                local hp_percent = enemy.health / enemy.max_health

                local hp_x = draw_mercy and 420 or 510

                if enemy.selectable then
                    -- Draw the enemy's HP
                    love.graphics.setColor(PALETTE["action_health_bg"])
                    love.graphics.rectangle("fill", hp_x, 55 + y_off, 81, 16)

                    love.graphics.setColor(PALETTE["action_health"])
                    love.graphics.rectangle("fill", hp_x, 55 + y_off, (hp_percent * 81), 16)

                    if draw_percents then
                        love.graphics.setColor(PALETTE["action_health_text"])
                        love.graphics.print(math.ceil(hp_percent * 100) .. "%", hp_x + 4, 55 + y_off, 0, 1, 0.5)
                    end
                end
            end

            if draw_mercy then
                -- Draw the enemy's MERCY
                if enemy.selectable then
                    love.graphics.setColor(PALETTE["battle_mercy_bg"])
                else
                    love.graphics.setColor(127/255, 127/255, 127/255, 1)
                end
                love.graphics.rectangle("fill", 520, 55 + y_off, 81, 16)

                if enemy.disable_mercy then
                    love.graphics.setColor(PALETTE["battle_mercy_text"])
                    love.graphics.setLineWidth(2)
                    love.graphics.line(520, 56 + y_off, 520 + 81, 56 + y_off + 16 - 1)
                    love.graphics.line(520, 56 + y_off + 16 - 1, 520 + 81, 56 + y_off)
                else
                    love.graphics.setColor(1, 1, 0, 1)
                    love.graphics.rectangle("fill", 520, 55 + y_off, ((enemy.mercy / 100) * 81), 16)

                    if draw_percents and enemy.selectable then
                        love.graphics.setColor(PALETTE["battle_mercy_text"])
                        love.graphics.print(math.ceil(enemy.mercy) .. "%", 524, 55 + y_off, 0, 1, 0.5)
                    end
                end
            end
        end

        love.graphics.setColor(1, 1, 1, 1)
        if page < max_page then
            love.graphics.draw(self.arrow_sprite, 20, 120 + (math.sin(Kristal.getTime()*6) * 2))
        end
        if page > 0 then
            love.graphics.draw(self.arrow_sprite, 20, 70 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
        end
		
		return
	end
	
	return orig(self)
end)

return BattleUI