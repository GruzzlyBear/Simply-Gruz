return Def.Quad{
	Name="Footer",
	InitCommand=function(self)
		self:draworder(90)
		self:zoomto(_screen.w, 32):vertalign(bottom):y(32)
		self:diffuse(0,0,0,1)
	end
}