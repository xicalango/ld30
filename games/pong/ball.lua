-- Paddle Game - #LD30 -- by <weldale@gmail.com>

local Ball = PongEntity:subclass("Ball")

function Ball:initialize(x, y, state)
	PongEntity.initialize(self, x, y, state)
	
	self.graphics = Graphics:new("assets/pong/ball.png")
	self.graphics.offset = {5, 5}
	
	self.speedX = 100
	self.speedY = 100
	
	self:offsetToHitbox()
end

function Ball:doesCollideOn(x, y)
	
	if self.vx < 0 then
		if self:collidesWith(self.state.playerPaddle) then
			return true, self.state.playerPaddle
		elseif self.x < self.state.playerPaddle.x then
			return true, "-x"
		end
	elseif self.vx > 0 then
		if self:collidesWith(self.state.cpuPaddle) then
			return true, self.state.cpuPaddle
		elseif self.x > self.state.cpuPaddle.x then
			return true, "+x"
		end
	end
	
	return PongEntity.doesCollideOn(self, x, y)
end

function Ball:collideWith(e)
	if e == "-x" then
		self.state:pointFor(2)
		return
	elseif e == "+x" then
		self.state:pointFor(1)
		return
	elseif e == "-y" or e == "+y" then
		self.vy = -self.vy
		return
	end

	self.vx = -self.vx
	
	self.speedX = self.speedX + 10
	self.speedY = self.speedY + 10
	
end

return Ball

