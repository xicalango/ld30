

JNRPlayer = Entity:subclass("JNRPlayer")

function JNRPlayer:initialize( x, y, state )
	Entity.initialize( self, x, y, state )
	
	self.ay = state.gravity
	
	self.graphics = Graphics:new("assets/pong/ball.png")
	self.graphics.offset = {10, 10}
	
	self.gotoLeft = false
	self.gotoRight = false
	self.jump = false
	self.fullHeight = false
	
	self.inAir = false
	
	self.dvx = 0
	self.dvy = 0
	
	self.speedX = 100
	self.speedY = 100
	
	self.accX = 4
	
	self:offsetToHitbox()
end

function JNRPlayer:doesCollideOn(x, y)
	local mx, my = self.state:screenToMap( x, y )
	if self.state.map:isWall(mx, my) then
		return true, "tile"
	end

	
	
	if my <= 0 or my >= self.state.map.height  then 
		return true, "y"
	else
		return false
	end
end

function JNRPlayer:collideWith(e)
	if e == "y" or e == "tile") and self.inAir then	
		self.inAir = false
		self.fullHeight = false
	end
end

function JNRPlayer:update(dt)
	if self.gotoRight then
		if self.vx < 1 then
			self.vx = self.vx + dt * self.accX
			if self.vx >= 1 then
				self.vx = 1
			end
		end
	elseif self.gotoLeft then
		if self.vx > -1 then
			self.vx = self.vx -dt * self.accX
			if self.vx <= -1 then
				self.vx = -1
			end
		end
	elseif not (self.gotoLeft or self.gotoRight) then
		if math.abs(self.vx) > 0.1 then
			self.vx = self.vx + dt * signum(-self.vx) * self.accX
		else
			self.vx = 0
		end
	end
	
	if self.jump and not self.inAir then
		self.inAir = true
		self.jump = false
		self.fullHeight = false
	end
	
	if self.inAir then
		if not self.fullHeight then
			if self.vy > -1 then
				self.ay = -self.state.gravity
			end
			
			if self.vy <= -1 then
				self.vy = -1
				self.fullHeight = true
			end
		else
			self.ay = self.state.gravity
		end
	end
	
	Entity.update( self, dt)
	
end

function JNRPlayer:isObstacleInDir( dx, dy )
	local mx, my = self.state:screenToMap( self.x, self.y )
	
	print(self.x, self.y, mx, my, mx + dx, my + dy, self.state.map:isWall( mx + dx, my + dy ))
	
	return self.state.map:isWall( mx + dx, my + dy )
end

function JNRPlayer:draw()
	Entity.draw(self)
	
	love.graphics.print( self.x .. "," .. self.y .. "," .. self.vx .. "," .. self.vy .. "," , 10, 10 )
	love.graphics.print( math.abs(self.vx - self.dvx) , 10, 25 )
	love.graphics.print( tostring(self.jump) .. "," .. tostring(self.inAir) .. "," .. tostring(self.fullHeight), 10, 40 )
end

function JNRPlayer:keypressed(key)
	if key == keyconfig.player[0].left then
		self.gotoLeft = true
	elseif key == keyconfig.player[0].right then
		self.gotoRight = true
	elseif key == keyconfig.player[0].jump then
		self.jump = true
	end
end

function JNRPlayer:keyreleased(key)
	if key == keyconfig.player[0].left then
		self.gotoLeft = false
	elseif key == keyconfig.player[0].right then
		self.gotoRight = false
	elseif key == keyconfig.player[0].jump then
		self.jump = false
	end
end
