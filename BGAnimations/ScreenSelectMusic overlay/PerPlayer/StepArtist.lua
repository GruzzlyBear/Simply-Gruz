local player = ...
local pn = ToEnumShortString(player)
local p = PlayerNumber:Reverse()[player]

return Def.ActorFrame{
	Name="StepArtistAF_" .. pn,
	InitCommand=cmd(draworder,1),

	-- song and course changes
	OnCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentSongChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentCourseChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),

	PlayerJoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:queuecommand("Appear" .. pn)
		end
	end,

	InitCommand=function(self)
		self:visible( false ):halign( p )

		if player == PLAYER_1 then

			self:y(_screen.cy + 44)
			self:x( _screen.cx - (IsUsingWideScreen() and 356 or 346))

		elseif player == PLAYER_2 then

			self:y(_screen.cy + 97)
			self:x( _screen.cx - 210)
		end

		if GAMESTATE:IsHumanPlayer(player) then
			self:queuecommand("Appear" .. pn)
		end
	end,

	-- depending on the value of pn, this will either become
	-- an AppearP1Command or an AppearP2Command when the screen initializes
	["Appear" .. pn .. "Command"]=cmd(visible, true; ease, 0.5, 275; addy, scale(p,0,1,-1,1) * 30),

	-- colored background quad
	Def.Quad{
		Name="BackgroundQuad",
		InitCommand=cmd(zoomto, 175, _screen.h/28; x, 113; diffuse, Color.Black ),
		StepsHaveChangedCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(player)
			if steps then
				local difficulty = steps:GetDifficulty()
			end
		end
	},

	--STEPS label
	Def.BitmapText{
		Font="_miso",
		OnCommand=cmd(diffuse, color("#7f8c8d"); horizalign, left; x, 37; settext, "STEPS"; zoom, 0.7)
	},

	--stepartist text
	Def.BitmapText{
		Font="Common Normal",
		InitCommand=cmd(diffuse,color("#bdc3c7"); horizalign, left; x, 75; maxwidth, 115),
		StepsHaveChangedCommand=function(self)

			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			if song == nil and course == nil then
				self:visible( false )
				return
			else
				self:visible( true )
			end

			local steps = GAMESTATE:GetCurrentSteps(player)

			if steps then
				local stepartist = steps:GetAuthorCredit()
				self:settext(stepartist ~= nil and stepartist or "")
			else
				self:settext("")
			end
		end
	}
}