function TextBannerAfterSet(self)

	local Title = self:GetChild("Title");
	local Subtitle = self:GetChild("Subtitle");	
	
	if Subtitle:GetText() ~= "" then
		( cmd(zoom,0.85; y,-6; x, -110; maxwidth, WideScale(270,400); diffuse, color("#bdc3c7")))(Title);
		( cmd(zoom,0.6;  y, 6; x, -110; maxwidth, WideScale(400,400); diffuse, color("#7f8c8d")))(Subtitle);
	else                      
		( cmd(zoom,0.85; y, 0; x, -110; maxwidth, WideScale(270,400); diffuse, color("#bdc3c7")))(Title);
	end
	
end