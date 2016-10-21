local t = Def.ActorFrame{
	ChangeStepsMessageCommand=function(self, params)
		self:playcommand("StepsHaveChanged", {Direction=params.Direction, Player=params.Player})
	end;
	--I'ma call it the fuck you people with fucking huge cdtitles script, With Love - Jousway
	--Update, Added a BAD NPS system	
	--NPS Calculator/Display
	LoadFont("_big") .. {
		Name="P1NPS";
		InitCommand=cmd(x,SCREEN_CENTER_X-80;y,45;zoom,0.75;halign,1;shadowlength,1;diffuse,color("#bdc3c7");strokecolor,color("Outline"));
	};
	--CDTitle Resizer/Container
	Def.ActorFrame{
		Name="CDTContainer";
		OnCommand=cmd(x,SCREEN_CENTER_X-40;y,40;zoomy,0;sleep,0.5;decelerate,0.25;zoomy,1);
		OffCommand=cmd(bouncebegin,0.15;zoomx,0);
		-- LoadActor(THEME:GetPathG("CDTitle", "Con")) .. {
			-- InitCommand=cmd(diffuse,Color("Orange"));
		-- };
		Def.Sprite {
			Name="CDTitle";
			InitCommand=cmd(y,0;x,0);
			--OnCommand=cmd(draworder,106;shadowlength,1;zoom,0.75;diffusealpha,1;zoom,0;bounceend,0.35;zoom,0.75;spin;effectmagnitude,0,180,0);
		};
	};
};

-- Each file contains the code for a particular screen element.
-- I've made this table ordered so that I can specificy
-- a desired draworder later below.

local files = {
	-- make the MusicWheel appear to cascade down
	"./MusicWheelAnimation.lua",
	-- Apply player modifiers from profile
	"./PlayerModifiers.lua",
	-- Graphical Banner
	"./Banner.lua",
	-- Song Artist, BPM, Duration (Referred to in other themes as "PaneDisplay")
	"./SongDescription.lua",
	-- Difficulty Blocks
	"./StepsDisplayList/Grid.lua",
	-- a folder of Lua files to be loaded twice (once for each player)
	"./PerPlayer",
	"../searchbar"

}

local function Update(self)
	local song = GAMESTATE:GetCurrentSong();
	
	--cdtitle
	local cdtitle = self:GetChild("CDTContainer"):GetChild("CDTitle");
	local height = cdtitle:GetHeight();
	local width = cdtitle:GetWidth();
	
	if song then
		if song:HasCDTitle() then
			cdtitle:visible(true);
			cdtitle:Load(song:GetCDTitlePath());
		else
			cdtitle:visible(false);
		end;
	else
		cdtitle:visible(false);
	end;
	
	if height >= 40 and width >= 40 then
		if height*(40/40) >= width then
		cdtitle:zoom(40/height);
		else
		cdtitle:zoom(40/width);
		end;
	elseif height >= 40 then
		cdtitle:zoom(40/height);
	elseif width >= 40 then
		cdtitle:zoom(40/width);
	else 
		cdtitle:zoom(1);
	end;
	
	--nps
	local P1NPS = self:GetChild("P1NPS");
	local P2NPS = self:GetChild("P2NPS");
		
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		if song then
			local ChartLenghtInSec = song:GetStepsSeconds();
			local Getp1Radar = GAMESTATE:GetCurrentSteps(PLAYER_1):GetRadarValues(PLAYER_1);
			local P1Taps = Getp1Radar:GetValue('RadarCategory_TapsAndHolds')+Getp1Radar:GetValue('RadarCategory_Jumps')+Getp1Radar:GetValue('RadarCategory_Hands');
			P1NPS:settext(string.format("%0.2f",P1Taps/ChartLenghtInSec));
		else
			P1NPS:settext("0");
		end;		
		P2NPS:x(SCREEN_CENTER_X-40);
	else
		P2NPS:x(SCREEN_CENTER_X-62);
	end;
	
	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
		if song then
			local ChartLenghtInSec = song:GetStepsSeconds();
			local Getp2Radar = GAMESTATE:GetCurrentSteps(PLAYER_2):GetRadarValues(PLAYER_2);
			local P2Taps = Getp2Radar:GetValue('RadarCategory_TapsAndHolds')+Getp2Radar:GetValue('RadarCategory_Jumps')+Getp2Radar:GetValue('RadarCategory_Hands');
			P2NPS:settext(string.format("%0.0f",P2Taps/ChartLenghtInSec));
		else
			P2NPS:settext("0");
		end;
	end;
end;

for index, file in ipairs(files) do
	t[#t+1] = LoadActor(file)..{
		InitCommand=cmd(draworder, index)
	}
end

t.InitCommand=cmd(SetUpdateFunction,Update);
return t
