local brightness = 0.2
local t = Def.ActorFrame{}

t[#t+1] = LoadSongBackground()..{
	BeginCommand=function(self)
		self:scaletocover(0,0,SCREEN_WIDTH,SCREEN_BOTTOM)
		self:diffusealpha(brightness);
		
	end;
}


return t
