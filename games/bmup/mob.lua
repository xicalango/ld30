

BmupMob = Entity:subclass("BmupMob")

function BmupMob:initialize(x, y, state, level)
	Entity.initialize( self, x, y, state ) 
	
	self.graphics = Graphics:new("assets/pong/ball.png")
	self.graphics.offset = {10,10}
	
	self.speedX = 200
	self.speedY = 200
	
	self.level = level
	
	if level == 1 then
		self.weapon = BmupWeapon( BmupWeapons["pistol"] )
	elseif level == 2 then
		self.weapon = BmupWeapon( BmupWeapons["pistol"] )
	elseif level == 3 then
		self.weapon = BmupWeapon( BmupWeapons["uzi"] )
	end
	
	self.dx = 0
	self.dy = 0
	
	self.shootDir = nil
	
	self:offsetToHitbox()
end

function BmupMob:doesCollideOn(x, y)

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

function BmupMob:update(dt)

	

	
	Entity.update(self, dt)
end


