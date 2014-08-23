-- Paddle Game - #LD30 -- by <weldale@gmail.com>



local Room = class("Room")

function Room:initialize( x, y, w, h )
	self.x = x
	self.y = y
	self.w = w
	self.h = h
end

function Room:getMidpoint()
	return self.x + math.floor(self.w / 2), self.y + math.floor(self.h / 2)
end

function Room:getBoundingBox()
	return self.x, self.y, self.x + self.w, self.y + self.h
end

function Room:validate(map)
	local sx1,sy1,sx2,sy2 = self:getBoundingBox()
	
	return map:checkOutOfBounds(sx1,sy1) or map:checkOutOfBounds(sx2, sy2) or self:collidesWith(map.rooms)
end

function Room:collidesWith(rooms)
	for i,r in ipairs(rooms) do
		local sx1,sy1,sx2,sy2 = self:getBoundingBox()
		local rx1,ry1,rx2,ry2 = r:getBoundingBox()
		
		if intersectRect( sx1, sy1, sx2, sy2, rx1, ry1, rx2, ry2 ) then
			return true
		end
	end
	
	return false
end

function Room:render(map)
	for x = self.x, self.x + self.w do
		map:setTileAt( x, self.y, "#" )
		map:setTileAt( x, self.y + self.h, "#" )
	end
	
	for y = self.y, self.y + self.h do
		map:setTileAt( self.x, y, "#" )
		map:setTileAt( self.x + self.w, y, "#" )
	end

	for y = self.y + 1, self.y + self.h - 1 do
		for x = self.x + 1, self.x + self.w - 1 do
			map:setTileAt( x, y, " " )
		end
	end
	
end

RoguelikeMap = Map:subclass("RoguelikeMap")

function RoguelikeMap:initialize( width, height )
	Map.initialize( self, width, height )
	self.width = width
	self.height = height
	
	self:generate()
	
end

function RoguelikeMap:generate()
	self.shadowMap = {}
	
	for y = 1, self.height do
		
		local shadowMapLine = {}
		
		for x = 1, self.width do
			shadowMapLine[x] = 0
		end
		
		self.shadowMap[y] = shadowMapLine
		
	end
	
	self.rooms = {}
	
	local numRooms = love.math.random( 8, 12 )
	
	for i = 1, numRooms do
		local colission = true
		local maxNumTries = 100
		local newRoom
		
		while colission and maxNumTries > 0 do
			newRoom = self:createRoom()
			colission = newRoom:validate(self)
			maxNumTries = maxNumTries - 1
		end
		
		if maxNumTries > 0 then
			table.insert( self.rooms, newRoom )
		end
		
	end
	
	for i,r in ipairs(self.rooms) do
		r:render(self)
	end
	
	for i = 1, #self.rooms - 1 do
		local r1 = self.rooms[i]
		local r2 = self.rooms[i+1]
		
		local r1x, r1y = r1:getMidpoint()
		local r2x, r2y = r2:getMidpoint()
		
		local dir
		
		if r1x < r2x then
			dir = 1
		else
			dir = -1
		end
		
		for xx = r1x, r2x, dir do
			if not (self:tileAt(xx, r1y) == "#" or self:tileAt(xx, r1y) == " ") then
				self:setTileAt( xx, r1y, "." )
			end
		end
		
		if r1y < r2y then
			dir = 1
		else
			dir = -1
		end
		
		for yy = r1y, r2y, dir do
			if not (self:tileAt(r2x, yy) == "#" or self:tileAt(r2x, yy) == " ") then
				self:setTileAt( r2x, yy, "." )
			end
		end
		
	end
	
	self.startPosition = {self.rooms[1]:getMidpoint()}
	
	self.objects[1] = self.startPosition
	
	self:revealAt(unpack(self.startPosition))
	
end

function RoguelikeMap:isVisible( x, y )
	if self:checkOutOfBounds(x,y) then
		return false
	end
	
	return self.shadowMap[y][x] == 1
end

function RoguelikeMap:revealAt(x, y)
	for yy = y-1, y+1 do
		for xx = x-1, x+1 do
			if not self:checkOutOfBounds(xx,yy) then
				self.shadowMap[y][x] = 1
			end
		end
	end
end

function RoguelikeMap:createRoom()
	local x = love.math.random( self.width )
	local y = love.math.random( self.height )
	
	local width = love.math.random( 5, 16 )
	local height = love.math.random( 5, 16 )
	
	return Room:new(x,y,width,height)
end

function RoguelikeMap:shouldDraw(x,y)
	return self:isVisible(x,y)
end
