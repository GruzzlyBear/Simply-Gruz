return Def.ActorFrame{

	-- Song Completion Meter
	Def.ActorFrame{
		Name="SongMeter",
		InitCommand=cmd(x,SCREEN_WIDTH-110; y,54; diffusealpha,0),
		OnCommand=cmd(decelerate,0.2; diffusealpha,1),

		Def.SongMeterDisplay {
			StreamWidth=195,
			Stream=Def.Quad{ 
				InitCommand=cmd(zoomy,18; diffuse,color("#bdc3c7"))
			}
		},

		-- Border( 200, 22, 2 ),
	},

	-- Song Title
	LoadFont("_miso")..{
		Name="SongTitle",
		InitCommand=cmd(zoom,0.8; shadowlength,0.6; maxwidth, 230; xy, SCREEN_WIDTH-110, 54 ),
		CurrentSongChangedMessageCommand=cmd(playcommand, "Update"),
		UpdateCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			self:settext( song and song:GetDisplayMainTitle() )
		end
	}
}