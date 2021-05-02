pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
--main
function _init()
 players = {}
 bullets = {}
 new_player(64, 64)

end

function _update()
 for p in all(players) do
  p:update()
 end
 for b in all(bullets) do
  if b then
   b:update()
  end
 end
end

function _draw()
	cls()
	map()
 for b in all(bullets) do
  b:draw()
 end
 for p in all(players) do
  p:draw()
 end

end
-->8
--util

function obj_col(o1, o2)

 return o1.x < o2.x + o2.w and
        o1.x + o1.w > o2.x and
        o1.y < o2.y + o2.h and
        o1.y + o1.w > o2.y

end


function map_col(o, f)
 
 return fget(mget(o.x/8, o.y/8), f) or
 							fget(mget(o.x/8, (o.y+o.h)/8), f) or
 							fget(mget((o.x+o.w)/8, o.y/8), f) or
 							fget(mget((o.x+o.w)/8, (o.y+o.h)/8), f)
 							
end
-->8
-- player

function new_player(_x, _y)

 add(players, {
  x = _x,
  y = _y,
  w = 5,
  h = 5,
  b_delay = 0,
  b_dmax = 10,
  update = function(self)
   -- bullet delay
   self.b_delay -= 1
   if self.b_delay < 0 then
    self.b_delay = 0
   end
   
   -- movement
   if btn(⬅️) then
		  self.x -= 1
		  if map_col(self, 0) then
		   self.x += 1
		  end	  
		 end
		 
		 if btn(⬆️) then
		  self.y -= 1
		  if map_col(self, 0) then
		   self.y += 1
		  end
		 end
		 
		 if btn(➡️) then
		  self.x += 1
		  if map_col(self, 0) then
		   self.x -= 1
		  end
		 end
		 
		 if btn(⬇️) then
		  self.y += 1
		  if map_col(self, 0) then
		   self.y -= 1
		  end
		 end
   
   -- bullets
			if btn(❎) and self.b_delay == 0 then
			 new_bullet(self.x + (self.w/2), self.y + (self.h/2), 3, 0, 2)
			 self.b_delay = self.b_dmax
   end 
   
  end,
  draw = function(self)
   spr(65,self.x,self.y)  
  
  end
 })
 


end
-->8
--enemy
-->8
--bullet
-- player

function new_bullet(_x, _y, 
																			_dx, _dy, _r)

 add(bullets, {
  x = _x,
  y = _y,
  w = _r,
  h = _r,
  dx = _dx,
  dy = _dy,
  r = _r,
  update = function(self)
   self.x += self.dx
   self.y += self.dy
   if map_col(self, 0) then
     del(bullets, self)
   end
  end,
  draw = function(self)
   circfill(self.x,self.y,self.r,10)  
  
  end
 })
 


end
__gfx__
00000000000000000666666606066066000660065555555506066066000660060000000000000000000000000000000000000000000000000000000000000000
00000000555555056066666660700706607007065555555560700706607007060000000000000000000000000000000000000000000000000000000000000000
00700700555555056606666600666600607777065555555500666600607777060000000000000000000000000000000000000000000000000000000000000000
00077000555555056660666600600600606006065555555500600600606006060000000000000000000000000000000000000000000000000000000000000000
00077000000000006660066600555500606666065555555500555500606666060000000000000000000000000000000000000000000000000000000000000000
00700700505555556606606600500500605005065555555500500500605005060000000000000000000000000000000000000000000000000000000000000000
00000000505555556066660660555506605005065555555560555506605005060000000000000000000000000000000000000000000000000000000000000000
00000000505555550666666006000060060660605555555506000060060660600000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777000080008000999900000aaaa0000bbbb00000cccc00ee0ee00004440000000000000000000000000000000000000000000000000000000000000000000
7777770008888800999994000aaaaa900bbbbb3000ccc100eeeeeee004ffff000000000000000000000000000000000000000000000000000000000000000000
717177008888820091919400aa1a1aa90b1b1b300ccccc00ee1e1ee00ff1f1000000000000000000000000000000000000000000000000000000000000000000
717177008181820091919400aa1a1aa90b1b1b30cc1c1cc0ee1e1e200fffff000000000000000000000000000000000000000000000000000000000000000000
7717700081818200999994000aaaaa900bbbbb30cc1c1ccc0eeeee00677717600000000000000000000000000000000000000000000000000000000000000000
07770000888882000444400000999900bbbbbbb3ccccccc100eee000f677160f0000000000000000000000000000000000000000000000000000000000000000
07770000022220000000000000000000000000000ccccc1000020000044444000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000040004000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001000204000204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020202020202020202020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020201010101020202020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020201020201010202020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020101020202020201010102020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020102020202020101020101020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020102020202020102020201020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020102020202020102020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020202020202020202020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020202020203020201020201020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020101010101010101020201020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020202020202020202020101020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010102020101010102020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020202020202020202020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020202020202020202020202020100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000