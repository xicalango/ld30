-- Paddle Game - #LD30 -- by <weldale@gmail.com>

PongEntity = Entity:subclass("PongEntity")

function PongEntity:initialize(x, y, state)
	Entity.initialize(self, x, y, state)
	
	self.speedY = 150
end

function PongEntity:doesCollideOn(x, y)	
	local r1x,r1y,r2x,r2y = self:getHitRectangle(x, y)
	
	if r1x < self.state.boundingBox[1][1] then 
		return true, "-x"
	elseif r1y < self.state.boundingBox[1][2] then
		return true, "-y"
	elseif r2x > self.state.boundingBox[2][1] then
		return true, "+x"
	elseif r2y > self.state.boundingBox[2][2] then
		return true, "+y"
	end
	
	return false		
end
