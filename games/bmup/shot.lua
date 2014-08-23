

BmupShot = Entity:subclass("BmupShot")

function BmupShot:initialize(vx, vy, owner, x, y, state)
	Entity.initialize( self, x, y, state ) 
	
	self.graphics = Graphics:new("assets/bmup/shot.png")
	self.graphics.offset = {2,2}
	
	self.speedX = 300
	self.speedY = 300
	
	self.vx = vx
	self.vy = vy
	
	self.owner = owner
	
	self:offsetToHitbox()
end

function BmupShot:doesCollideOn(x, y)

	local hitTable = self:getHitRectangleTable(x, y)

	for i,h in ipairs(hitTable) do
		local mx, my = self.state:screenToMap( h[1], h[2] )
		
		if (self.state.map:tileAt(mx, my) or "#") == "#" then
			return true, "tile"
		end
		
		if my <= 0 then 
			return true, "-y"
		elseif my > self.state.map.height then
			return true, "+y"
		elseif mx <= 0 then
			return true, "-x"
		elseif mx > self.state.map.width then
			return true, "+x"
		end
	end

	return false
end

function BmupShot:collideWith(e)
	
	
	self.remove = true
end