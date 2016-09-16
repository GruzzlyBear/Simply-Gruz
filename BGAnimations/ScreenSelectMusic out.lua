return Def.ActorFrame{
	InitCommand=cmd(draworder, 200),
	
	Def.Quad{
		InitCommand=cmd(diffuse,Color.Black; FullScreen; diffusealpha,0 ),
		OffCommand=cmd(cropbottom,1; fadebottom,.5; linear,0; cropbottom,-0.5; diffusealpha,1)
	},

	LoadFont("_big")..{
		Text="Press Enter for Player Options",
		InitCommand=cmd(Center; zoom,0.75 ),
		OnCommand=cmd(visible, false),
		ShowPressStartForOptionsCommand=cmd(visible,true;),
		ShowEnteringOptionsCommand=cmd(linear,0; diffusealpha,0; queuecommand, "NewText"),
		NewTextCommand=cmd(hibernate,0; settext,THEME:GetString("ScreenSelectMusic", "Entering Options..."); linear,0; diffusealpha,1; hurrytweening,0; sleep,0.5)
	},
}