-- Paddle Game - #LD30 -- by <weldale@gmail.com>

require("games/jnr/map")
require("games/jnr/player")

JNRGameState = GameState:subclass("JNRGameState")

function JNRGameState:initialize()
	self.tileset = Tileset:new(10, 10)
end

function JNRGameState:onActivation()
	self.map = JNRMap:new(64, 48)
	self.map:renderRoom(1,1,62,46)
	
	self.gravity = 10
	
	self.player = JNRPlayer( 100, 100, self )
	
	table.insert(self.map.objects, self.player)
end

function JNRGameState:keypressed(key)
	self.player:keypressed(key)
end

function JNRGameState:keyreleased(key)
	self.player:keyreleased(key)
end


function JNRGameState:screenToMap( sx, sy )
	return math.floor(sx / self.tileset.tileWidth) + 1, math.floor(sy / self.tileset.tileHeight) + 1
end

function JNRGameState:mapToScreen( mx, my )
	return math.floor((mx-1) * self.tileset.tileWidth), math.floor((my-1) * self.tileset.tileHeight)
end

