local SlideArea, super = Class(SlideArea)

function SlideArea:init(x, y, w, h, properties)
    super:init(self, x, y, w, h, properties)
	
	self.slide_texture = properties["dust"]
end

function SlideArea:onCollide(chara)
    if (chara.last_y or chara.y) < self.y + self.height and chara.is_player then
        if chara.state ~= "SLIDE" then
            if self:checkAgainstWall(chara) then return end

            Assets.stopAndPlaySound("noise")
        end

        chara:setState("SLIDE", false, self.lock_movement)

        chara.current_slide_area = self
		
		if self.slide_texture then
			chara.slide_texture = self.slide_texture
		end
    end
end

return SlideArea