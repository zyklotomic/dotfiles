import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Gaps
import System.IO
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

main = do
xmproc <- spawnPipe "xmobar"	
xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
     	, layoutHook = avoidStruts $  spacing 8 $ 
	smartBorders $  gaps [(R,16),(L,16),(U,5),(D,5)] $ 
	layoutHook defaultConfig 
     
	, logHook = dynamicLogWithPP xmobarPP 
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#657b83" "" . shorten 100
                       -- , ppLayout = const "" disables Layout Info
			}	

	, terminal	= "xfce4-terminal"
	, borderWidth	= 5
	, focusedBorderColor = "#FFA400"
	}

