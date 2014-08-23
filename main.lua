-- Paddle Game - #LD30 -- by <weldale@gmail.com>

class = require("lib/middleclass")

require("lib/slam")

require("lib/gamestate")
require("lib/graphics")

require("lib/util")

require("entity")

require("games/pong/gamestate")

keyconfig = require("keyconfig")

global = {
	takeScreenshot = false,
	fullscreen = false
}

function love.load()

	--love.graphics.setLineStyle("rough")

	gameStateManager = GameStateManager:new()
	
	gameStateManager:registerState(PongGameState)
	
	gameStateManager:changeState(PongGameState, true)
	
end


function love.draw()
	gameStateManager:draw()
	
	if global.takeScreenshot then
		global.takeScreenshot = false
		local screenshot = love.graphics.newScreenshot()
		screenshot:encode( "pg_" .. love.timer.getMicroTime() .. ".png" )
	end
end

function love.update(dt)
	gameStateManager:update(dt)
end

function love.keypressed(key)
	if key == "f12" then
		global.takeScreenshot = true
  	elseif key == "f5" then
    	if love.window.setFullscreen(not fullscreen, "desktop") then
			fullscreen = not fullscreen
		end
	end

	gameStateManager:keypressed(key)
end

function love.keyreleased(key)
	gameStateManager:keyreleased(key)
end
