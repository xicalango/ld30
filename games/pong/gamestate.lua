-- Paddle Game - #LD30 -- by <weldale@gmail.com>

require("games/pong/pongEntity")

local Ball = require("games/pong/ball")
local Paddle, PlayerPaddle, CpuPaddle = unpack(require("games/pong/paddle"))

local countDownTime = 1

PongGameState = GameState:subclass("PongGameState")

function PongGameState:initialize()

	self.boundingBox = {{4, 4}, {634, 474}}
	
	self.midX = (self.boundingBox[2][1] + self.boundingBox[1][1])/2

	self.reset = false

	
	self.scoreFont = love.graphics.newFont( 48 )
end

function PongGameState:onActivation(reset)
	if self.reset or reset then
		self.ball = Ball:new(320,240, self)
		
		self.ball.vx = 1
		self.ball.vy = 1
		
		self.playerPaddle = PlayerPaddle:new(40,240, self)
		self.cpuPaddle = CpuPaddle:new(600,240, self)
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

	love.graphics.line( 0, self.boundingBox[1][2], 640, self.boundingBox[1][2] )
	love.graphics.line( 0, self.boundingBox[2][2], 640, self.boundingBox[2][2] )
	
	love.graphics.setFont( self.scoreFont )
	love.graphics.print( self.score[1], self.midX - 60, 10 )
	love.graphics.print( self.score[2], self.midX + 30, 10 )
	
	for i = 1, self.boundingBox[2][2]/20 do
		love.graphics.rectangle( "fill", self.midX - 2, (i * 20) - 2, 4, 4)
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
	self.ball:reset()
	
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
