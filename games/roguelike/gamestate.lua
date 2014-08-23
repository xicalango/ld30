-- Paddle Game - #LD30 -- by <weldale@gmail.com>

require("games/roguelike/map")
require("games/roguelike/tileset")

RoguelikeGameState = GameState:subclass("RoguelikeGameState")

function RoguelikeGameState:onActivation(reset)
	self.tileset = RoguelikeTileset:new()
	self.map = RoguelikeMap:new(80,60)
end

function RoguelikeGameState:draw()
	self.map:draw(self.tileset)
	
	for i,o in ipairs(self.map.objects) do
		if self.map:isVisible( unpack(o) ) then
			love.graphics.setColor( 0, 255, 0 )
			love.graphics.rectangle( "fill", o[1], o[2], 8, 8 )
		end
	end
	
end