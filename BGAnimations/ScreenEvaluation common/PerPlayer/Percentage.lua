local pn = ...

local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
local PercentDP = stats:GetPercentDancePoints()
local percent = FormatPercentScore(PercentDP)
-- Format the Percentage string, removing the % symbol
percent = percent:gsub("%%", "")

return Def.ActorFrame{
	Name="PercentageContainer"..ToEnumShortString(pn),
	OnCommand=function(self)
		self:y( _screen.cy-26 )
		self:x( (pn == PLAYER_1 and -70) or 70 )
	end,
	LoadFont("_big")..{
		Text=percent,
		Name="Percent",
		InitCommand=cmd(valign, 1; horizalign, right; zoom,1.5; y,15 ;diffuse, color("#bdc3c7")),
		OnCommand=cmd(x, 70)
	}
}