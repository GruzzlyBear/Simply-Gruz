return Def.ActorFrame{

	-- Song Completion Meter
	Def.ActorFrame{
		Name="SongMeter",
		InitCommand=cmd(x,SCREEN_CENTER_X; y,4; diffusealpha,0),
		OnCommand=cmd(decelerate,0.2; diffusealpha,1),

		Def.SongMeterDisplay {
			StreamWidth=208,
			Stream=Def.Quad{ 
				InitCommand=cmd(zoomy,8; diffuse,color("#111111"))
			}
		},

		-- Border( 200, 22, 2 ),
	},
	
	LoadFont("_miso")..{
		Name="SongGroup",
		InitCommand=cmd(zoom,0.6; shadowlength,0.6; maxwidth, 330; xy, SCREEN_WIDTH-208, 10;horizalign,left ),
		OnCommand=function(self)
			local song2 = GAMESTATE:GetCurrentSong()
			self:settext( song2 and song2:GetGroupName() )
		end
	},
	
	-- Song Title
	LoadFont("_big")..{
		Name="SongTitle",
		InitCommand=cmd(zoom,0.6; shadowlength,0.6; maxwidth, 330; xy, SCREEN_WIDTH-208, 26;horizalign,left ),
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			self:settext( song and song:GetDisplayMainTitle() )
		end
	},
	
	LoadFont("_miso")..{
		InitCommand=cmd(zoom,0.6; shadowlength,0.6; maxwidth, 330; xy, SCREEN_WIDTH-208, 44;horizalign,left ),
		OnCommand=function(self)
			local song2 = GAMESTATE:GetCurrentSong()
			self:settext( song2 and song2:GetDisplaySubTitle() )
		end
	}
}