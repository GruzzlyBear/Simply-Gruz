local player = ...

return Def.ActorFrame{
	-- player's chart's difficulty meter
	LoadFont("_extrabold")..{
		InitCommand=function(self)
			self:diffuse(Color.White)
			self:zoom( 1 )
			self:horizalign(right)
			self:xy( 205, 56)

			if player == PLAYER_2 then
				self:x( _screen.w-WideScale(27,84) )
			end
		end,
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Begin"),
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(player)
			local difficulty = steps:GetDifficulty();
			local meter = steps:GetMeter()

			if meter then
				self:settext(meter)
			end
		end
	},
	LoadFont("Common normal")..{
		InitCommand=function(self)
			self:diffuse(Color.White)
			self:zoom( 1 )
			self:horizalign(right)
			self:xy( 180, 56)

			if player == PLAYER_2 then
				self:x( _screen.w-WideScale(27,84) )
			end
		end,
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Begin"),
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(player)
			local difficulty = steps:GetDifficulty();
			difficulty = ToEnumShortString(difficulty)
			if difficulty then
				self:settext(difficulty)
			end
		end
	}
}