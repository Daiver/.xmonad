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
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.IM
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Circle
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Fullscreen

myTerminal = "lxterminal"

home_dir = "/home/daiver/"
screenshots_dir = home_dir ++ "screenshots/"
backgrounds_dir = home_dir ++ "backgrounds/"

set_rnd_bg_com = "python " ++ backgrounds_dir ++ "set_random_bg.py"

myLayouts = ( avoidStruts $ smartBorders $ 
              Tall 1 (3/100) (1/2) |||
              StackTile 1 (3/100) (1/2) ||| 
              ResizableTall 1 (3/100) (1/2) [] 
              ||| Grid
            ) |||
            noBorders Full


myKeys = [ ("M-<Right>",   nextWS)
         , ("M-S-q",       spawn "xmonad --recompile && xmonad --restart")
         , ("M-<Return>",  spawn myTerminal)
         , ("M-S-<Right>", windows W.swapDown)
         , ("M-<Left>",    prevWS)
         , ("M-S-<Left>",  windows W.swapUp)
         , ("M1-<F4>",     kill)
         , ("M-s h",       spawn "xmessage 'hello, xmonad!'")
         , ("<Print>",     spawn $ "scrot -e 'mv $f " ++ screenshots_dir ++ ".'") 
         , ("M-v",         spawn $ set_rnd_bg_com)
         , ("M-g",         spawn "google-chrome")
         --, ("M-g",         spawn "chromium")
         ]

myStartupHook = do
    --spawn "feh --bg-max Downloads/507321-1366x768.jpg"
    --spawn "feh --bg-max Downloads/344327-1366x768.jpg "
    --spawn "feh --bg-max Downloads/507321-1366x768.jpg"
    --spawn "feh --bg-max Downloads/VjHxOSpOyjw.jpg"
    spawn set_rnd_bg_com
    spawn "setxkbmap 'us,ru' ',winkeys' 'grp:alt_shift_toggle'"
    spawn "nm-applet"
    --spawn "killall xmobar"

--main = xmonad $ 
myLog = dynamicLogString xmobarPP {
  ppCurrent         = xmobarColor "green" "" . wrap "[" "]",
  ppTitle           = xmobarColor "lightblue" "" . wrap "[" "]",
  ppHidden          = xmobarColor "yellow" "",
  ppHiddenNoWindows = xmobarColor "darkgray" "",
  ppLayout          = xmobarColor "orange" "" }


--myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

myWorkspaces = ["1","2","3","4","5","6","7","8","9", "10", "11", "12"]

myConfig = defaultConfig
     { 
           terminal           = myTerminal
         , modMask            = mod4Mask
         , borderWidth        = 1
         , focusFollowsMouse  = True
         , startupHook        = myStartupHook
         , workspaces         = myWorkspaces
         , layoutHook         = myLayouts
         --, manageHook         = manageHook defaultConfig <+> manageDocks
         --, logHook            = myLog >>= xmonadPropLog
     }
     `additionalKeysP` myKeys 


main = do
    --xmproc <- spawnPipe "/usr/bin/xmobar /home/daiver/.xmonad/xmobarrc "
    --spawn "trayer --edge top --align left --margin 0  --widthtype pixel --width 1363 --heighttype pixel --height 20 --tint 0x0 --alpha 0 --transparent true"
    xmonad =<< xmobar myConfig
