--V3
return Def.ActorFrame {
	
	--Load Song Background
	Def.Sprite {
		CurrentSongChangedMessageCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;sleep,0.32;queuecommand,"ModifySongBackground";diffusealpha,0.2);
		ModifySongBackgroundCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():GetBackgroundPath() then
					self:visible(true);
					self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath());
					self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
				else
					self:visible(false);
				end;
			else
				self:visible(false);
			end;
		end;	
	};
};