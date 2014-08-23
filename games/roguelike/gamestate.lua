-- Paddle Game - #LD30 -- by <weldale@gmail.com>

require("games/roguelike/map")
require("games/roguelike/tileset")

RoguelikeGameState = GameState:subclass("RoguelikeGameState")

function RoguelikeGameState:onActivation(reset)
	self.tileset = RoguelikeTileset:new()
	self.map = RoguelikeMap:new(80,60,self.tileset)
end

function RoguelikeGameState:draw()
	self.map:draw()
end