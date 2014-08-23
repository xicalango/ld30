-- Paddle Game - #LD30 -- by <weldale@gmail.com>

local Paddle = PongEntity:subclass("Paddle")

function Paddle:initialize(x, y, state)
	PongEntity.initialize(self, x, y, state)
	
	self.graphics = Graphics:new("assets/pong/paddle.png")
	self.graphics.offset = {16, 64}
	
	self:offsetToHitbox()
	
	self.speedY = 200
end

local PlayerPaddle = Paddle:subclass("PlayerPaddle")

function PlayerPaddle:initialize(x, y, state)
	Paddle.initialize(self, x, y, state)
	
	self.number = 0
end

function PlayerPaddle:keypressed(key)
	if key == keyconfig.player[self.number].up then 
		self.vy = -1
		return true
	end
	if key == keyconfig.player[self.number].down then 
		self.vy = 1
		return true
	end

	return false
end

function PlayerPaddle:keyreleased( key )
	if key == keyconfig.player[self.number].up then 
		self.vy = 0
		return true
	end
	if key == keyconfig.player[self.number].down then 
		self.vy = 0
		return true
	end

	return false
end

local CpuPaddle = Paddle:subclass("CpuPaddle")

function CpuPaddle:initialize(x, y, state)
	Paddle.initialize(self, x, y, state)
	
	self.delta = 10
	
	self.speedY = 150
end

function CpuPaddle:update(dt)
	Entity.update(self,dt)
	
	if self.state.ball.x < 160 then
		self.vy = 0
		return
	end
	
	if self.y - self.state.ball.y > self.delta then
		self.vy = -1
	elseif self.y - self.state.ball.y < self.delta then
		self.vy = 1
	else
		self.vy = 0
	end
	
end

return {Paddle, PlayerPaddle, CpuPaddle}


