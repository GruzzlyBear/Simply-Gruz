return Def.ActorFrame{
	LoadFont("_big") .. {
        InitCommand=cmd(xy,150,-1;zoom,0.5;maxwidth,WideScale(WideScale((640*(20/854)),20)/0.5),
        SetGradeCommand=function(self,params)
			local sGrade = params.Grade or 'Grade_None'
			self:valign(0.5)
			self:settext(THEME:GetString("Grade",ToEnumShortString(sGrade)) or "")
			self:diffuse(0.5,0.5,0.5,1)
        end
	}
}
