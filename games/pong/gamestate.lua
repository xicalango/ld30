-- Paddle Game - #LD30 -- by <weldale@gmail.com>

require("games/pong/pongEntity")

local Ball = require("games/pong/ball")
local Paddle, PlayerPaddle, CpuPaddle = unpack(require("games/pong/paddle"))

local countDownTime = 1

PongGameState = GameState:subclass("PongGameState")

function PongGameState:initialize()

	self.boundingBox = {{2, 2}, {317, 237}}

	self.reset = false

	
	self.scoreFont = love.graphics.newFont( 48 )
end

function PongGameState:onActivation(reset)
	if self.reset or reset then
		self.ball = Ball:new(160,120, self)
		
		self.ball.vx = 1
		self.ball.vy = 1
		
		self.playerPaddle = PlayerPaddle:new(20,120, self)
		self.cpuPaddle = CpuPaddle:new(300,120, self)
		self.objects = {
			self.ball,
			self.playerPaddle,
			self.cpuPaddle
		}
			
		self.score = {0,0}
		
		self.beginTimer = countDownTime
		self.running = false
	end
end


function PongGameState:draw()

	love.graphics.setLineWidth(3)

	love.graphics.rectangle( "line", -1, 2, 322, 237 )
	
	love.graphics.setFont( self.scoreFont )
	love.graphics.print( self.score[1], 110, 10 )
	love.graphics.print( self.score[2], 170, 10 )
	
	for i = 1, 12 do
		love.graphics.rectangle( "fill", 154, (i * 20) - 5, 5, 5)
	end

	for i, obj in pairs(self.objects) do
		obj:draw()
	end

	
	
end

function PongGameState:update(dt)

	if self.running then

		for i, obj in pairs(self.objects) do
			obj:update(dt)
		end

	else
		self.beginTimer = self.beginTimer - dt
		if self.beginTimer <= 0 then
			self.running = true
		end
	end
		
end

function PongGameState:pointFor(i)
	self.ball.x = 160
	self.ball.y = 120
	
	self.ball.speedX = 100
	self.ball.speedY = 100
	
	self.beginTimer = countDownTime
	self.running = false
	
	self.score[i] = self.score[i]  + 1
	
	self.ball.vx = -self.ball.vx
end

function PongGameState:keypressed(key)
	self.playerPaddle:keypressed(key)
end

function PongGameState:keyreleased(key)
	self.playerPaddle:keyreleased(key)
end
