tell application "Finder"
	tell disk "TerminalColoreopard"
		open
		tell container window
			set current view to icon view
			set toolbar visible to false
			set statusbar visible to false
			set the bounds to {30, 50, 480 + 30, 300 + 70}
		end tell

		set opts to the icon view options of container window
		tell opts
			set icon size to 64
			set arrangement to not arranged
			set label position to bottom
			set text size to 10
		end tell
		-- set background picture of opts to file ".background:background.png"
		set position of item "SIMBL.pkg" to {105, 120}
		set position of item "TerminalColoreopard.bundle" to {105, 220}
		update without registering applications

		-- give the finder some time to write the .DS_Store file
		delay 3
		close
	end tell
end tell
