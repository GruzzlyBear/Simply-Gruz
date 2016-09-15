local player = ...
local pn = ToEnumShortString(player)

local mode = ""
if SL.Global.GameMode == "StomperZ" then mode = "StomperZ" end
if SL.Global.GameMode == "ECFA" then mode = "ECFA" end

-- tap note types
-- Iterating through the enum isn't worthwhile because the sequencing is so bizarre...
local TNSNames = {
	THEME:GetString("TapNoteScore" .. mode, "W1"),
	THEME:GetString("TapNoteScore" .. mode, "W2"),
	THEME:GetString("TapNoteScore" .. mode, "W3"),
	THEME:GetString("TapNoteScore" .. mode, "W4"),
	THEME:GetString("TapNoteScore" .. mode, "W5"),
	THEME:GetString("TapNoteScore" .. mode, "Miss")
}

local DiffColors = {
	color("#ecf0f1"),	-- white
	color("#f1c40f"),	-- yellow
	color("#2ecc71"),	-- green
	color("#3498db"),	-- blue
	color("#9b59b6"),	-- purple
	color("#e74c3c")	-- red
}

local RadarCategories = {
	THEME:GetString("ScreenEvaluation", 'Holds'),
	THEME:GetString("ScreenEvaluation", 'Mines'),
	THEME:GetString("ScreenEvaluation", 'Hands'),
	THEME:GetString("ScreenEvaluation", 'Rolls')
}


local t = Def.ActorFrame{
	InitCommand=cmd(xy, 50, _screen.cy-24),
	OnCommand=function(self)
		if player == PLAYER_2 then
			self:x( self:GetX() * -1)
		end
	end
}


--  labels: W1 ---> Miss
for index, label in ipairs(TNSNames) do
	t[#t+1] = LoadFont("_miso")..{
		Text=label:lower(),
		InitCommand=cmd(zoom,0.75; horizalign,right ),
		BeginCommand=function(self)
			self:x( (player == PLAYER_1 and 10) or -28 )
			self:y((index-1)*28 -16)
			self:diffuse( DiffColors[index] )
			local gmods = SL.Global.ActiveModifiers

			-- if Way Offs were turned off
			if gmods.DecentsWayOffs == "Decents Only" and label == THEME:GetString("TapNoteScore", "W5") then
				self:visible(false)

			-- if both Decents and WayOffs were turned off
			elseif gmods.DecentsWayOffs == "Off" and (label == THEME:GetString("TapNoteScore", "W4") or label == THEME:GetString("TapNoteScore", "W5")) then
				self:visible(false)
			end
		end
	}
end

-- labels: holds, mines, hands, rolls
for index, label in ipairs(RadarCategories) do
	t[#t+1] = LoadFont("_miso")..{
		Text=label,
		InitCommand=cmd(NoStroke;zoom,0.75; horizalign,right ),
		BeginCommand=function(self)
			self:x( (player == PLAYER_1 and -160) or 90 )
			self:y((index-1)*28 + 41)
		end
	}
end

return t