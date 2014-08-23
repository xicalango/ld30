
BmupWeapons = {
	pistol = {
			shootCoolDown = 0.5,
			reloadTime = 1,
			bulletsInMagazine = 6
		},
	mg = {
			shootCoolDown = 0.3,
			reloadTime = 3,
			bulletsInMagazine = 50
		},
	uzi = {
			shootCoolDown = 0.2,
			reloadTime = 1.5,
			bulletsInMagazine = 30
		}
		
}

BmupWeapon = class("BmupWeapon")

function BmupWeapon:initialize( t, state )
	self.type = t
	self.state = state
	
	self.bullets = t.bulletsInMagazine
	self.reload = 0
	self.coolDown = 0
end

function BmupWeapon:update(dt)
	if self.bullets <= 0 then
		self.reload = self.reload - dt
		
		if self.reload <= 0 then
			self.bullets = self.type.bulletsInMagazine
		end
	elseif self.coolDown > 0 then
		self.coolDown = self.coolDown - dt
	end
end

function BmupWeapon:shot(e, dir)
	if self.bullets > 0 then

		if self.coolDown <= 0 then
			
			e.state:shoot(e.x, e.y, dir, e)
			
			self.bullets = self.bullets - 1
			
			if self.bullets <= 0 then
				self.reload = self.type.reloadTime
			end
			
			self.coolDown = self.type.shootCoolDown
		end
	end
end