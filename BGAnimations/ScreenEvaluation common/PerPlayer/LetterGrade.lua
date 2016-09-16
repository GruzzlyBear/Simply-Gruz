local pn = ...

local playerStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
local grade = playerStats:GetGrade()

return LoadActor(THEME:GetPathG("", "_grades/"..grade..".lua"), playerStats)..{
	InitCommand=cmd(xy, -50, _screen.cy-120),
	OnCommand=function(self)
		self:zoom(0.4)
		if pn == PLAYER_1 then
			self:x( self:GetX() * -1 )
		end
	end
}
