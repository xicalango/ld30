

BmupPlayer = Entity:subclass("BmupPlayer")

function BmupPlayer:initialize(x, y, state)
	Entity.initialize( self, x, y, state ) 
	
	self.graphics = Graphics:new("assets/pong/ball.png")
	self.graphics.offset = {10,10}
	
	self.speedX = 200
	self.speedY = 200
	
	self.weapon = BmupWeapon( BmupWeapons["pistol"] )
	
	self.goto = {
		left = false,
		right = false,
		up = false,
		down = false
	}
	
	self.shootDir = nil
	
	self:offsetToHitbox()
end

function BmupPlayer:doesCollideOn(x, y)

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

function BmupPlayer:update(dt)

	self.weapon:update(dt)
	
	if self.shootDir then
		self.weapon:shot( self, self.shootDir )
	end
	
	self.vx = 0
	self.vy = 0
	
	if self.goto.up then
		self.vy = -1
	elseif self.goto.down then
		self.vy = 1
	end
	
	if self.goto.left then
		self.vx = -1
	elseif self.goto.right then
		self.vx = 1
	end
	
	Entity.update(self, dt)
end

function BmupPlayer:keypressed( key )
	if key == keyconfig.player[0].up then 
		self.goto.up = true
		return true
	end
	if key == keyconfig.player[0].down then 
		self.goto.down = true
		return true
	end
	if key == keyconfig.player[0].left then 
		self.goto.left = true
		return true
	end
	if key == keyconfig.player[0].right then 
		self.goto.right = true
		return true
	end
	
	if key == keyconfig.player[0].shup then 
		self.shootDir = "up"
		return true
	end
	if key == keyconfig.player[0].shdown then 
		self.shootDir = "down"
		return true
	end
	if key == keyconfig.player[0].shleft then 
		self.shootDir = "left"
		return true
	end
	if key == keyconfig.player[0].shright then 
		self.shootDir = "right"
		return true
	end

	return false
end

function BmupPlayer:keyreleased( key )
	if key == keyconfig.player[0].up then 
		self.goto.up = false
		return true
	end
	if key == keyconfig.player[0].down then 
		self.goto.down = false
		return true
	end
	if key == keyconfig.player[0].left then 
		self.goto.left = false
		return true
	end
	if key == keyconfig.player[0].right then 
		self.goto.right = false
		return true
	end
	
	
	if key == keyconfig.player[0].shup then 
		self.shootDir = nil
		return true
	end
	if key == keyconfig.player[0].shdown then 
		self.shootDir = nil
		return true
	end
	if key == keyconfig.player[0].shleft then 
		self.shootDir = nil
		return true
	end
	if key == keyconfig.player[0].shright then 
		self.shootDir = nil
		return true
	end

	return false
end

