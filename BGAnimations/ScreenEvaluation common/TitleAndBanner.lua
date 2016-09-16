return Def.ActorFrame{

	-- quad behind the song/course title text

	-- song/course title text
	LoadFont("_big")..{
		InitCommand=cmd(xy,SCREEN_WIDTH-70,40; maxwidth, 294 ;diffuse, color("#bdc3c7");halign,1;zoom,1),
		OnCommand=function(self)
			local songtitle = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayMainTitle()) or GAMESTATE:GetCurrentSong():GetDisplayMainTitle()

			if songtitle then
				self:settext(songtitle)
			end
		end
	},

	--fallback banner
	LoadActor( THEME:GetPathB("ScreenSelectMusic", "overlay/colored_banners/banner" .. SL.Global.ActiveColorIndex .. " (doubleres).png"))..{
		OnCommand=cmd(xy, _screen.cx+155, 128; zoom, 0.7; setsize,472,148;)
	},

	--song or course banner, if there is one
	Def.Banner{
		Name="Banner",
		InitCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				self:LoadFromCourse( GAMESTATE:GetCurrentCourse() )
			else
				self:LoadFromSong( GAMESTATE:GetCurrentSong() )
			end
		end,
		OnCommand=cmd(xy, _screen.cx+155, 128; setsize,472,148; zoom, 0.7 )
	}
}