import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W  -- (0a) window stack manipulation
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.StackTile

myTerminal = "lxterminal"

home_dir = "/home/daiver/"
screenshots_dir = home_dir ++ "screenshots/"

myLayouts = ( avoidStruts $ smartBorders $ 
              Tall 1 (3/100) (1/2) |||
              StackTile 1 (3/100) (1/2) ||| 
              simpleTabbed ) |||
            noBorders Full


myKeys = [ ("M-<Right>",   nextWS)
         , ("M-<Return>",  spawn myTerminal)
         , ("M-S-<Right>", windows W.swapDown)
         , ("M-<Left>",    prevWS)
         , ("M-S-<Left>",  windows W.swapUp)
         , ("M1-<F4>",     kill)
         , ("M-s h",       spawn "xmessage 'hello, xmonad!'")
         , ("<Print>",     spawn $"scrot -e 'mv $f " ++ screenshots_dir ++ ".'") 
         , ("M-g",         spawn "chromium")
         ]

myStartupHook = do
    spawn "feh --bg-max Downloads/507321-1366x768.jpg"
    spawn "setxkbmap 'us,ru' ',winkeys' 'grp:alt_shift_toggle'"
    --spawn "killall xmobar"

--main = xmonad $ 
myLog = dynamicLogString xmobarPP {
  ppCurrent         = xmobarColor "green" "" . wrap "[" "]",
  ppTitle           = xmobarColor "lightblue" "" . wrap "[" "]",
  ppHidden          = xmobarColor "yellow" "",
  ppHiddenNoWindows = xmobarColor "darkgray" "",
  ppLayout          = xmobarColor "orange" "" }

myBar = "xmobar"

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

myConfig = defaultConfig
     { terminal    = myTerminal
     , modMask     = mod4Mask
     , borderWidth = 1
     , focusFollowsMouse  = True
     , startupHook = myStartupHook
     , layoutHook = myLayouts
     , manageHook = manageHook defaultConfig <+> manageDocks
     , logHook    = myLog >>= xmonadPropLog
     }
     `additionalKeysP` myKeys 


main = do
    --xmproc <- spawnPipe "/usr/bin/xmobar /home/daiver/.xmonad/xmobarrc "
    --spawn "trayer --edge top --align left --margin 0  --widthtype pixel --width 1363 --heighttype pixel --height 20 --tint 0x0 --alpha 0 --transparent true"
    xmonad =<< xmobar myConfig
