local HasSavedScreenShot = { P1=false, P2=false }

return Def.Sprite{
	Name="ScreenshotSprite",
	InitCommand=cmd(draworder, 200),
	CodeMessageCommand=function(self, params)
		if params.Name == "Screenshot" and not HasSavedScreenShot[ToEnumShortString(params.PlayerNumber)] then

			-- (re)set these upon attempting to take a screenshot since we can potentially
			-- reuse this same sprite for two screenshot animations (one for each player)
			self:Center()
			self:zoomto(_screen.w, _screen.h)
			local MusicRate = SL.Global.ActiveModifiers.MusicRate
			local songtitle = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayMainTitle()) or GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
			local songtitlealpha = songtitle:gsub('%?','')
			local group = (GAMESTATE:GetCurrentSong():GetGroupName())
			local rate = (("%g"):format(MusicRate))

			-- organize Screenshots take using Simply Love into directories, like...
			-- ./Screenshots/Simply_Love/2015/06-June/2015-06-05_121708.png
			local prefix = "SimplyGruz/" .. "/"
			prefix = prefix .. group .. "/" .. songtitlealpha .. "/" .. rate .. "/"

			local success, path = SaveScreenshot(params.PlayerNumber, false, true, prefix)
			if success and path then

				-- only allow each player to save a screenshot once!
				HasSavedScreenShot[ToEnumShortString(params.PlayerNumber)] = true
				self:Load(path)

				if PROFILEMAN:IsPersistentProfile(params.PlayerNumber) then
					SM("Screenshot saved to " .. ToEnumShortString(params.PlayerNumber) .. "'s Profile.")	
					self:zoom(0)
				else
					SM("Screenshot saved to Machine Profile.")
					-- tween directly down
					self:zoom(0)
				end
			end
		end
	end
}