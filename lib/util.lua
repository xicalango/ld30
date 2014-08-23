function intersectRect( r1x1, r1y1, r1x2, r1y2, r2x1, r2y1, r2x2, r2y2 )
	return not ( 
		r1x2 < r2x1 or 
		r2x2 < r1x1 or
		r2y1 > r1y2 or
		r1y1 > r2y2)
end

function signum( x )
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end