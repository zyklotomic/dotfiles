import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import System.IO
-- import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders 
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Tabbed
import XMonad.Hooks.SetWMName
-- import XMonad.Layout.BinarySpacePartition

import qualified Data.Map as M

main = xmonad =<< xmobar (ewmh ethansConfig)

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myWorkspaces = ["壹","二","三","四","五","六","七","八","九","十"]
-- ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
myBorderWidth = 2
myFocusedBorderColor = "#ffa300"
myNormalBorderColor = "#000000"
myTerminal = "urxvtc" 
-- layouts
-- myLayout = smartBorders $ layoutHook def ||| simpleTabbed
myLayout = smartBorders $ layoutHook def

-- keybindings
myModMask = mod1Mask
-- super_key = mod4Mask
localKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
	[ ((modm, xK_space), spawn "rofi -show combi")
	-- For legacy dmenu run, muscle memory
	, ((modm, xK_p), spawn "rofi -show run")
	-- Override default for switching layouts
	, ((modm, xK_BackSpace), sendMessage NextLayout) ]

myKeys = \cfg -> localKeys cfg `M.union` (keys def) cfg

-- manageHook
myManageHook = composeAll []
-- [ className =? "Firefox" --> doShift "二" ]

ethansConfig = def {
		terminal			= myTerminal,
		borderWidth			= myBorderWidth, 
 		workspaces			= myWorkspaces,
		focusedBorderColor  = myFocusedBorderColor,
		normalBorderColor   = myNormalBorderColor,
		keys				= myKeys, 
		modMask				= myModMask,
		-- hooks, layouts
		layoutHook			= myLayout,
		manageHook			= myManageHook <+> manageHook defaultConfig,
		startupHook			= setWMName "LG3D"
	}
