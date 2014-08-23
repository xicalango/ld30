-- Paddle Game - #LD30 -- by <weldale@gmail.com>

require("games/bmup/weapons")
require("games/bmup/player")
require("games/bmup/shot")

BmupGameState = GameState:subclass("BmupGameState")

function BmupGameState:initialize()
	self.tileset = Tileset:new(10, 10)
end

function BmupGameState:onActivation()
	self.map = Map:new(64,48)
	
	for i = 1, self.map.width do
		self.map:setTileAt(i, 1, "#")
		self.map:setTileAt(i, self.map.height, "#")
	end
	
	for i = 1, self.map.height do
		self.map:setTileAt(1, i, "#")
		self.map:setTileAt(self.map.width, i, "#")
	end
	
	self.player = BmupPlayer:new( 100, 100, self)
	table.insert(self.map.objects, self.player)
end

function BmupGameState:update(dt)
	self.map:update(dt)
end

function BmupGameState:draw()
	self.map:draw(self.tileset)
end

function BmupGameState:keypressed(key)
	for i,o in ipairs(self.map.objects) do
		o:keypressed(key)
	end
end

function BmupGameState:keyreleased(key)
	for i,o in ipairs(self.map.objects) do
		o:keyreleased(key)
	end
end

function BmupGameState:screenToMap( sx, sy )
	return math.floor(sx / self.tileset.tileWidth) + 1, math.floor(sy / self.tileset.tileHeight) + 1
end

function BmupGameState:mapToScreen( mx, my )
	return math.floor((mx-1) * self.tileset.tileWidth), math.floor((my-1) * self.tileset.tileHeight)
end

function BmupGameState:shoot(x, y, dir, owner)
	local vx = 0
	local vy = 0
	
	if dir == "left" then
		vx = -1 
	elseif dir == "right" then
		vx = 1 
	elseif dir == "up" then
		vy = -1 
	elseif dir == "down" then
		vy = 1 
	end
	
	self.map:addObject( BmupShot:new( vx, vy, owner, x, y, self ) )
	
	
end

