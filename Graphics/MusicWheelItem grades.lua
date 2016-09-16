return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(xy,-123,0;zoomto,3,31),
		SetGradeCommand=function(self,params)
			if params.Grade then
				self:diffuse(color("#bdc3c7"))
				self:diffusealpha(0.5)
			else
				self:diffusealpha(0)
			end
		end
	},
	LoadFont("_big") .. {
        InitCommand=cmd(xy,160,-1;zoom,0.5;maxwidth,WideScale((640*(20/854)),20)/0.25; halign,1),
        SetGradeCommand=function(self,params)
			local sGrade = params.Grade or 'Grade_None'
			self:valign(0.5)
			self:settext(THEME:GetString("Grade",ToEnumShortString(sGrade)) or "")
			self:diffuse(0.5,0.5,0.5,1)
        end
	}
}
