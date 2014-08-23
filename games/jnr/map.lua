

JNRMap = Map:subclass("JNRMap")

function JNRMap:isWall(x, y)
	local t = self:tileAt(x, y) or "#"
	return t == "#"
end

function JNRMap:renderRoom(xx, yy, ww, hh)
	for x = xx, xx + ww do
		self:setTileAt( x, yy, "#" )
		self:setTileAt( x, yy + hh, "#" )
	end
	
	for y = yy, yy + hh do
		self:setTileAt( xx, y, "#" )
		self:setTileAt( xx + ww, y, "#" )
	end

	--[[
	for y = self.y + 1, self.y + self.h - 1 do
		for x = self.x + 1, self.x + self.w - 1 do
			map:setTileAt( x, y, " " )
		end
	end
	--]]
	
end
