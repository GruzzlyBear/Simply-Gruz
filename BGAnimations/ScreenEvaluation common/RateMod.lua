return Def.ActorFrame{

	--quad behind the ratemod, if there is one


	--the ratemod, if there is one
	LoadFont("_miso")..{
		InitCommand=cmd(xy,SCREEN_WIDTH-70, 63; shadowlength,1; zoom, 1;diffuse, color("#7f8c8d"); halign,1),
		OnCommand=function(self)
			-- what was the MusicRate for this song?
			local MusicRate = SL.Global.ActiveModifiers.MusicRate

			-- Store the MusicRate for later retrieval on ScreenEvaluationSummary
			SL.Global.Stages.MusicRate[SL.Global.Stages.PlayedThisGame + 1] = MusicRate

			local bpm = GetDisplayBPMs()
			self:settext(("%g"):format(MusicRate) .. " Rate")
				
		end
	}
}