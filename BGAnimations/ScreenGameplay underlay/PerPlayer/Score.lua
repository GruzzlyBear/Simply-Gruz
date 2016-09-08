local player = ...

if SL[ ToEnumShortString(player) ].ActiveModifiers.HideScore then
	return false
else

	return Def.BitmapText{
		Font="_big",
		Text="0.00",

		Name=ToEnumShortString(player).."Score",
		InitCommand=function(self)
			self:y(40)
			self:valign(1)
			self:zoom(1.3)
			if player == PLAYER_1 then
				self:horizalign(right)
				self:x( 205 )
			elseif player == PLAYER_2 then
				self:x( _screen.cx + _screen.w/2.85 )
			end
		end,
		JudgmentMessageCommand=function(self) self:queuecommand("RedrawScore") end,
		RedrawScoreCommand=function(self)
			local dp = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
			local percent = FormatPercentScore( dp ):sub(1,-2)
			self:settext(percent)
		end
	}
end