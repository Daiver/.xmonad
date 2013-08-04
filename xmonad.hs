import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W  -- (0a) window stack manipulation
import XMonad.Actions.CycleWS

myTerminal = "lxterminal"

home_dir = "/home/daiver/"
screenshots_dir = home_dir ++ "screenshots/"

myKeys = [ ("M-<Right>",   nextWS)
         , ("M-<Return>",  spawn myTerminal)
         , ("M-S-<Right>", windows W.swapDown)
         , ("M-<Left>",    prevWS)
         , ("M-S-<Left>",  windows W.swapUp)
         , ("M1-<F4>",     kill)
         , ("M-s h",       spawn "xmessage 'hello, xmonad!'")
         , ("<Print>",     spawn $"scrot -e 'mv $f " ++ screenshots_dir ++ ".'") 
         , ("M-g",       spawn "chromium")
         ]

myStartupHook = do
    spawn "feh --bg-max Downloads/474135-1366x768.jpg"

main = xmonad $ defaultConfig
     { terminal    = myTerminal
     , modMask     = mod4Mask
     , borderWidth = 1
     , focusFollowsMouse  = True
     , startupHook = myStartupHook
     }
     `additionalKeysP` myKeys 

