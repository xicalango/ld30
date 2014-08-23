-- Paddle Game - #LD30 -- by <weldale@gmail.com>

Entity = class("Entity")

function Entity:initialize(x, y, state)
	self.x = x or 0
	self.y = y or 0
	
	self.state = state
	
	self.graphics = nil
	
	self.hitbox = { left = 0, right = 0, top = 0, bottom = 0 }
	
	self.vx = 0
	self.vy = 0
	
	self.ay = 0
	
	self.speedX = 10
	self.speedY = 10
	
	self.remove = false
	
end

function Entity:offsetToHitbox(o)
	o = o or 0
	self.hitbox.left = self.graphics.offset[1] + o
	self.hitbox.right = self.graphics.offset[1] + o
	self.hitbox.top = self.graphics.offset[2] + o 
	self.hitbox.bottom = self.graphics.offset[2] + o
end

function Entity:getHitRectangle(x, y)
	x = x or self.x
	y = y or self.y
	return 
		x - self.hitbox.left, 
		y - self.hitbox.top, 
		x + self.hitbox.right, 
		y + self.hitbox.bottom
end

function Entity:collidesWith(entity)

	local or1x, or1y, or2x, or2y = self:getHitRectangle()
	local er1x, er1y, er2x, er2y = entity:getHitRectangle()

	return intersectRect( or1x, or1y, or2x, or2y, er1x, er1y, er2x, er2y )

end


function Entity:update(dt)

	if self.ay ~= 0 then
		self.vy = self.vy + self.ay * dt
	end
	
	if self.vx ~= 0 or self.vy ~= 0 then
		
		local oldX, oldY = self.x, self.y
		
		local newX = self.x + (self.vx * self.speedX * dt)
		local newY = self.y + (self.vy * self.speedY * dt)
		
		local collides, e = self:doesCollideOn(newX, newY)
		
		if collides then
			if not self:doesCollideOn(newX, oldY) then
				self.x = newX
			elseif not self:doesCollideOn(oldX, newY) then
				self.y = newY
			end
		else
			self.x = newX
			self.y = newY
		end
				
		if collides then
			self:collideWith(e)
		end
			
		
	end
	
end

function Entity:collideWith(e)
end

function Entity:doesCollideOn( newX, newY )
	return true
end

function Entity:draw()
	if self.graphics then
		self.graphics:draw(self.x, self.y)
	end
end

function Entity:keypressed(key)
	return false
end

function Entity:keyreleased(key)
	return false
end
