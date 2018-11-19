import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Gaps
import System.IO
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

main = xmonad =<< xmobar ethansConfig

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- myWorkspaces = ["一","二","三","四","五","六","七","八","九","十"] 
myBorderWidth = 3
myFocusedBorderColor = "#ffa300"
myTerminal = "urxvtc"

-- xmobar stuff
myBar = "xmobar"

-- layouts
myLayout = smartBorders $ layoutHook def


ethansConfig = def {
		terminal			= myTerminal,
		borderWidth			= myBorderWidth, 
-- 		workspaces			= myWorkspaces,
		focusedBorderColor  = myFocusedBorderColor,
		
		-- hooks, layouts
		layoutHook			= myLayout
	}
