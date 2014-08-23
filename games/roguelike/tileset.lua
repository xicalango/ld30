-- Paddle Game - #LD30 -- by <weldale@gmail.com>

RoguelikeTileset = class("RoguelikeTileset")


function RoguelikeTileset:initialize()
	self.tileWidth = 8
	self.tileHeight = 8
end

function RoguelikeTileset:draw( x, y, tile )
	
	if tile == "#" then
		love.graphics.setColor( 255, 255, 255 )
	elseif tile == "." then
		love.graphics.setColor( 255, 255, 255, 128 )
	else
		love.graphics.setColor( 0, 0, 0 )
	end
	
	love.graphics.rectangle( "fill", x * self.tileWidth, y * self.tileHeight, self.tileWidth, self.tileHeight )
end
