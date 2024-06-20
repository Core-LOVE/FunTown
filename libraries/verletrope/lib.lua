local Lib = {}

local verlet = {}

local function constrain(rope)
	for i = 1,#rope.segments-1 do
		local a = rope.segments[i]
		local b = rope.segments[i+1]
		
		if not a.fixed or not b.fixed then
			
			local dv = (a.position - b.position)
			local dist = dv.length
			local err = math.abs(dist - rope.segmentLength)
			local delta = vector.zero2
			
			if dist > rope.segmentLength then
				delta = err/dist * dv
			elseif dist < rope.segmentLength and not rope.allowShorter then
				delta = -err/dist * dv
			end
			
			if not a.fixed then
				if not b.fixed then
					a.position = a.position - delta * 0.5
					b.position = b.position + delta * 0.5
				else
					a.position = a.position - delta
				end
			else
				b.position = b.position + delta
			end
			
			if rope.constraints then
				rope:constraints(a,b)
			end
		end
	end
	
			
	if rope.constraints then
		rope:constraints(rope.segments[#rope.segments], nil)
	end
end

local function updateRope(rope)
	local sleep = true
	for _,v in ipairs(rope.segments) do
		if not v.fixed then
			local vel = v.position-v.oldpos
			v.oldpos = v.position
			vel = vel + vector.down2*rope.gravity
			
			local v2 = 0
			for _,w in ipairs(rope.forceFunctions) do
				v2 = v2 + w(v.position, vel)
			end
			vel = vel+v2
			
			v.position = v.position + vel
		end
	end
	
	for i = 1,rope.iterations do
		constrain(rope)
	end
end

local function addForce(rope, func)
	table.insert(rope.forceFunctions, func)
end

local function resetForces(rope)
	local c = #rope.forceFunctions
	for i = 1,c do
		rope.forceFunctions[i] = nil
	end
end


local function makeSegment(pos)
	local t = {position = pos, oldpos = pos, fixed = false}
	return t
end

local function makeRope(startPos, endPos, segments, iterations, gravity, allowShorter)
	local v = startPos
	local d = (endPos-startPos)/segments
	
	local r = {startPos = startPos, endPos = endPos, segmentLength = d.length, segments = {}, iterations = iterations or 10, gravity = gravity or Defines.npc_grav, allowShorter = allowShorter, forceFunctions = {}}
	
	r.update = updateRope
	r.addForceFunction = addForce
	r.resetForceFunctions = resetForces
	r.addForceFunc = addForce
	r.resetForceFuncs = resetForces
	
	for i=1,segments do
		table.insert(r.segments, makeSegment(v))
		v = v + d
	end
	
	r.segments[1].fixed = true
	
	return r
end

local function constrainCloth(cloth)
	for k,rope in ipairs(cloth.strands) do
		for i = 1,#rope.segments-1 do
			local a = rope.segments[i]
			local b = rope.segments[i+1]
			
			local c
			if k < #cloth.strands then
				c = cloth.strands[k+1].segments[i]
			end
			
			if not a.fixed or not b.fixed then
				
				local dv = (a.position - b.position)
				local dist = dv.length
				local err = math.abs(dist - rope.segmentLength)
				local delta = vector.zero2
				
				if dist > rope.segmentLength then
					delta = err/dist * dv
				elseif dist < rope.segmentLength and not cloth.allowCompress then
					delta = -err/dist * dv
				end
				
				if not a.fixed then
					if not b.fixed then
						a.position = a.position - delta * 0.5
						b.position = b.position + delta * 0.5
					else
						a.position = a.position - delta
					end
				else
					b.position = b.position + delta
				end
			end
			
			if c ~= nil and (not a.fixed or not c.fixed) then
				local dv = (a.position - c.position)
				local dist = dv.length
				local err = math.abs(dist - rope.segmentLength)
				local delta = vector.zero2
				
				if dist > rope.segmentLength then
					delta = err/dist * dv
				elseif dist < rope.segmentLength and not cloth.allowCompress then
					delta = -err/dist * dv
				end
				
				if not a.fixed then
					if not c.fixed then
						a.position = a.position - delta * 0.5
						c.position = c.position + delta * 0.5
					else
						a.position = a.position - delta
					end
				else
					c.position = c.position + delta
				end
			end
			
			if not a.fixed or not b.fixed or (c ~= nil and not c.fixed) then
				if cloth.constraints then
					cloth:constraints(a,b,c)
				end
			end
		end
		
		local a = rope.segments[#rope.segments]
		
		local c
		if k < #cloth.strands then
			c = cloth.strands[k+1].segments[#rope.segments]
		end
		
		if c ~= nil and (not a.fixed or not c.fixed) then
			local dv = (a.position - c.position)
			local dist = dv.length
			local err = math.abs(dist - rope.segmentLength)
			local delta = vector.zero2
			
			if dist > rope.segmentLength then
				delta = err/dist * dv
			elseif dist < rope.segmentLength and not cloth.allowCompress then
				delta = -err/dist * dv
			end
			
			if not a.fixed then
				if not c.fixed then
					a.position = a.position - delta * 0.5
					c.position = c.position + delta * 0.5
				else
					a.position = a.position - delta
				end
			else
				c.position = c.position + delta
			end
		end
		
		
		if rope.constraints then
			local c 
			if k < #cloth.strands then
				c = cloth.strands[k+1].segments[#rope.segments]
			end
			rope:constraints(a, nil, c)
		end
	end
	
			
end

local function updateCloth(cloth)
	local sleep = true
	for _,rope in ipairs(cloth.strands) do
		for _,v in ipairs(rope.segments) do
			if not v.fixed then
				local vel = v.position-v.oldpos
				v.oldpos = v.position
				vel = vel + vector.down2*cloth.gravity
				
				local v2 = 0
				for _,w in ipairs(cloth.forceFunctions) do
					v2 = v2 + w(v.position, vel)
				end
				vel = vel+v2
				
				v.position = v.position + vel
			end
		end
	end
		
	for i = 1,cloth.iterations do
		constrainCloth(cloth)
	end
end

local function makeCloth(topLeft, topRight, bottomLeft, bottomRight, divisions, iterations, gravity, allowCompress)
	local c = {strands = {}, iterations = iterations or 10, gravity = gravity or Defines.npc_grav, allowCompress = allowCompress, forceFunctions = {}}
	for i = 1,divisions do
		local startPos = math.lerp(topLeft,topRight,(i-1)/(divisions-1))
		local endPos = math.lerp(bottomLeft,bottomRight,(i-1)/(divisions-1))
		local v = startPos
		local d = (endPos-startPos)/divisions
		
		local r = {startPos = startPos, endPos = endPos, segmentLength = d.length, segments = {}}
		
		for i=1,divisions do
			table.insert(r.segments, makeSegment(v))
			v = v + d
		end
		
		r.segments[1].fixed = true
		
		table.insert(c.strands, r)
	end
		
	c.update = updateCloth
	c.addForceFunction = addForce
	c.resetForceFunctions = resetForces
	c.addForceFunc = addForce
	c.resetForceFuncs = resetForces
	
	return c
end



verlet.Rope = makeRope
verlet.Cloth = makeCloth

_G.Verlet = verlet

return Lib