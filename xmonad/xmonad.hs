{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-} -- unused

import XMonad
import XMonad.StackSet (tag, stack)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS
import XMonad.Util.WorkspaceCompare (getSortByIndex)
import XMonad.StackSet (greedyView, shift)
import XMonad.Layout.LayoutModifier
import System.IO

-- Layout extensions
-- import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed

import qualified Data.Map as M
import Data.Maybe
import Control.Applicative (liftA2)

main = xmonad =<< xmobar' (ewmh ethansConfig)

-------------------------- Layout -------------------------------------
myLayout = smartBorders $ myTall ||| myMirror ||| myTabbed

newtype MyTall a = MyTall (Tall a) deriving (Show, Read)

instance LayoutClass MyTall a where
  pureLayout (MyTall t) = pureLayout t
  pureMessage (MyTall t) x = MyTall <$> pureMessage t x
  description (MyTall t) = "高 " ++ (show . tallNMaster) t

myTall = MyTall $ Tall 1 (3/100) (1/2)
myMirror = Mirror myTall
myTabbed = tabbedBottom shrinkText tabTheme
tabTheme = def { activeColor = "#ffa300" }

-------------------------- Custom xmobar settings ----------------------
toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b)

xmobar' :: LayoutClass l Window
  => XConfig l -> IO (XConfig (ModifiedLayout AvoidStruts l))
xmobar' conf = statusBar "xmobar" xmobarPP' toggleStrutsKey conf

layoutRename :: String -> String
layoutRename name = xmobarColor "#ffa300" "" renamed
  where renamed = case name of
                    "Tabbed Bottom Simplest" -> "滿"
                    _ -> name

xmobarPP' :: PP
xmobarPP' = def { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
                  , ppTitle = xmobarColor "green" "" . shorten 100
                  , ppVisible = wrap "(" ")"
                  , ppSep = " : "
                  , ppLayout = layoutRename
                  , ppUrgent = xmobarColor "red" "yellow"
                  }

--------------------------- Keybindings ------------------------------
followShift :: Direction1D -> WSType -> X ()
followShift dir t = doTo dir t getSortByIndex $ windows . liftA2 (.) greedyView shift

-- non-empty non-hidden WS
nonEHWS :: WSType
nonEHWS = WSIs $ return $ liftA2 (&&) ((/= "NSP") . tag) (isJust . stack)
-- (\x -> (/= "NSP") (tag x) && (isJust . stack) x)

localKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [ ((modm, xK_space), spawn "rofi -show-icons -show combi")
  , ((mod4Mask, xK_w), spawn "rofi -show-icons -show window")
  , ((mod4Mask, xK_Tab), moveTo Next nonEHWS)
  , ((mod4Mask .|. shiftMask, xK_Tab), moveTo Prev nonEHWS)
  , ((mod4Mask, xK_l), followShift Next nonEHWS)
  , ((mod4Mask, xK_h), followShift Prev nonEHWS)
  , ((mod4Mask .|. shiftMask, xK_Return), shiftTo Next EmptyWS)
  , ((mod4Mask, xK_Return), followShift Next EmptyWS)
  , ((mod4Mask, xK_space), scratchpadSpawnActionTerminal "urxvtc")
  -- Override default for switching layouts
  , ((modm, xK_BackSpace), sendMessage NextLayout)]

myKeys = \cfg -> localKeys cfg `M.union` (keys def) cfg

-- manageHook
myManageHook = composeAll [ scratchpadManageHookDefault ]
-- [ className =? "Firefox" --> doShift "二" ]


ethansConfig = def {
		terminal			= "alacritty",
		borderWidth			= 2,
 		workspaces			= ["壹","二","三","四","五","六","七","八","九"],
		focusedBorderColor              = "#ffa300",
		normalBorderColor               = "#000000",
		keys				= myKeys,
		modMask				= mod1Mask,
		-- hooks, layouts
		layoutHook			= myLayout,
		manageHook			= myManageHook <+> manageHook defaultConfig,
		startupHook			= setWMName "LG3D"
} `removeKeys` [(mod1Mask, xK_p), (mod1Mask .|. shiftMask, xK_p)]
