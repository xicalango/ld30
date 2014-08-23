-- Paddle Game - #LD30 -- by <weldale@gmail.com>

Map = class("Map")

function Map:initialize( width, height )
	self.width = width
	self.height = height
	
	self.map = {}
	
	self.objects = {}
	self.addObjects = {}
	
	for y = 1, self.height do
		local line = {}
		
		for x = 1, self.width do
			line[x] = ""
		end
		
		self.map[y] = line
	end
	
end

function Map:checkOutOfBounds(x, y)
	return x <= 0 or y <= 0 or x > self.width or y > self.height
end

function Map:tileAt(x, y)
	if self:checkOutOfBounds(x,y) then
		return nil
	end
		
	return self.map[y][x]
end

function Map:setTileAt(x, y, t)
	if self:checkOutOfBounds(x,y) then
		return
	end

	
	self.map[y][x] = t
end

function Map:update(dt)
	for i,o in ipairs(self.objects) do
		o:update(dt)
		
		if o.remove then
			o.state = nil
			table.remove(self.objects, i)
		end
		
	end
	
	if #self.addObjects > 0 then
		for i,o in ipairs(self.addObjects) do
			table.insert(self.objects, o)
		end
		self.addObjects = {}
	end
end

function Map:addObject(o)
	table.insert(self.addObjects, o)
end

function Map:draw(tileset)
	
	for y = 1, self.height do
		for x = 1, self.width do
			if self:shouldDraw(x, y) then
				tileset:draw( x-1, y-1, self.map[y][x] )
			end
		end
	end
	
	love.graphics.reset()
	
	for i,o in ipairs(self.objects) do
		o:draw()
	end
	
end

function Map:shouldDraw(x,y)
	return true
end
