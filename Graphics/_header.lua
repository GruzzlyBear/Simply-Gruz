return Def.ActorFrame{
	Name="Header",

	Def.Quad{
		InitCommand=cmd(zoomto, _screen.w, 32; vertalign, top; diffuse,0,0,0,1; x, _screen.cx),
	},

	Def.BitmapText{
		Name="HeaderText",
		Font="Common normal",
		Text=ScreenString("HeaderText"),
		InitCommand=cmd(diffusealpha,0; zoom,1; horizalign, left; xy, 10, 14 ),
		OnCommand=cmd(sleep, 0.1; decelerate,0.33; diffusealpha,1),
		OffCommand=cmd(accelerate,0.33; diffusealpha,0)
	}
}