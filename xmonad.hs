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
     	, layoutHook = avoidStruts $  spacing 2 $ 
	smartBorders $  gaps [(R,10),(L,10),(U,4),(D,4)] $ 
	layoutHook defaultConfig 
     
	, logHook = dynamicLogWithPP xmobarPP 
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#657b83" "" . shorten 100
                       -- , ppLayout = const "" disables Layout Info
			}	

	, terminal	= "termite"
	, borderWidth	= 4
	, focusedBorderColor = "#D79921"
	}
