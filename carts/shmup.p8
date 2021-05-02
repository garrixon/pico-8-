pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--main

function _init()
	players = {}
	enemies = {}
	pbullets = {}
	ebullets = {}
 
 new_player(64,90)
 
 new_enemy(14,0,24,24)
 new_enemy(24,10,24,24)
 new_enemy(34,20,24,24)
 new_enemy(44,30,24,24)
 new_enemy(54,40,24,24)
 new_enemy(64,50,24,24)
end

function _update60()
 for p in all(players) do
 	p:update()
 end
 for e in all(enemies) do
 	e:update()
 end
	for b in all(pbullets) do
 	b:update()
	 for e in all(enemies) do
	  if b and e and colliding(b, e) then
    del(enemies, e)
    del(pbullets, b)
   end
  end
  if b and b.y < 0 then
   del(pbullets, b)
  end
 end
end

function _draw()
 cls() 
 for p in all(players) do
	 p:draw() 
 end
 for e in all(enemies) do
	 e:draw() 
 end
 for b in all(pbullets) do
	 b:draw() 
 end
 for b in all(ebullets) do
	 b:draw() 
 end
end



-->8
-- objects


-- players
function new_player(_x, _y)

	add(players, {
		x = _x,
		y = _y,
		frate = 20,
		ftime = 0,
	 update = function(self)
	 	if self.ftime > 0 then
	 	 self.ftime -= 1
	 	elseif self.ftime < 0 then
	 	 self.ftime = 0
	 	end
	 	if btn(⬅️) then
				self.x-=1
			end
			if btn(➡️) then
	 		self.x+=1
			end
			if btn(⬆️) then
				self.y-=1
			end
			if btn(⬇️) then
			 self.y+=1
			end	
			if btn(❎) and self.ftime == 0  then
				new_pbullet(self.x+12, self.y)
				self.ftime = self.frate
			end
	 end,
	 draw = function(self)
 		palt(10,true)
			spr(1,self.x,self.y,1.5,3)
			spr(1,self.x+12,self.y,1.5,3,1)
	 end
 })
end


-- enemies
function new_enemy(_x, _y, _w, _h)

	add(enemies, {
		x = _x,
		y = _y,
		w = _w,
		h = _h,
		left = 1,
	 update = function(self)
	 	if self.x > 104 then
				self.left = 1
			elseif self.x < 0 then
	 		self.left = -1
			end
			self.x -= self.left * 1
			
	 end,
	 draw = function(self)
 		palt(10,true)
			spr(1,self.x,self.y,1.5,3,false,1)
			spr(1,self.x+12,self.y,1.5,3,1,1)
	 end
 })
end


-- pbullets
function new_pbullet(_x, _y)

	add(pbullets, {
		x = _x,
		y = _y,
		r = 1,
		c = 10,
		dx = 0,
		dy = -2,
	 update = function(self)
			self.x += self.dx
			self.y += self.dy
			
	 end,
	 draw = function(self)
 		circfill(self.x, self.y,
 		 self.r, self.c)
	 end
 })
end


-- ebullets
function new_ebullet(_x, _y)

	add(ebullets, {
		x = _x,
		y = _y,
		r = 2,
		c = 8,
		dx = 0,
		dy = 2,
	 update = function(self)
			self.x += self.dx
			self.y += self.dy
			
	 end,
	 draw = function(self)
 		circfill(self.x, self.y,
 		 self.r, self.c)
	 end
 })
end
-->8
-- utils

function colliding(_bullet, _enemy)
	return _bullet.x > _enemy.x and
								_bullet.x < _enemy.x + _enemy.w and
								_bullet.y > _enemy.y and
								_bullet.y < _enemy.y + _enemy.h
	
end
-->8
-- updates
-->8
-- draws

__gfx__
00000000aaaaaaaaaaa0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaa05aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00700700aaaaaaaaaa05aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00077000aaaaaaaaa055aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00077000aaaaaaaaa055aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00700700aaaaaaaa055daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaa05ddaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaa055d0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaa05501aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaa05501aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaa050501aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaa0a05550aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaa06055555aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaa060d5d55aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaa06dd5d56aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaa06ddd5d56aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaa0dddd5d77aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aa0dddd5dd66aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000a0dddd5ddd77aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aa0dd5dddd00aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaa0008dd0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaa00d0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaa0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
