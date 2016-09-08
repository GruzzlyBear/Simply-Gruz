local player = ...

return Def.ActorFrame{
	
	-- colored background for player's chart's difficulty meter
	Def.Quad{
		InitCommand=function(self)
			self:zoomto(15, 15)
			self:horizalign(right)
			self:xy(203, 57 )
		
			if player == PLAYER_2 then
				self:x( _screen.w-WideScale(27,84) )
			end
		end,
		OnCommand=function(self)
			local currentSteps = GAMESTATE:GetCurrentSteps(player)
			if currentSteps then
				local currentDifficulty = currentSteps:GetDifficulty()
				self:diffuse(DifficultyColor(currentDifficulty))
			end
		end
	},

	-- player's chart's difficulty meter
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
			local meter = steps:GetMeter()

			if meter then
				self:settext(meter)
			end
		end
	}
}