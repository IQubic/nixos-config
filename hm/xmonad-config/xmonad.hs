-- Base
import XMonad
import XMonad.Config.Desktop
import qualified XMonad.StackSet as W
import System.IO (hPutStrLn, Handle)
import System.Exit (exitSuccess)

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WithAll (killAll)

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName

-- Data and Control modules
import Data.Monoid (All)

-- Layouts modifiers
import XMonad.Layout.LimitWindows (increaseLimit, decreaseLimit)
import XMonad.Layout.NoBorders (smartBorders, hasBorder)

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe, safeSpawn)
import XMonad.Util.SpawnOnce

-- Use super as mod
myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "firefox "

-- Make Emacs keybindings easier to type
myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "

myBorderWidth :: Dimension
myBorderWidth = 3

-- Border color of normal windows
myNormColor :: String
myNormColor = "#4c566a"

-- Border color of focused windows
myFocusColor :: String
myFocusColor = "#eceff4"

-- Startup Hook
myStartupHook :: X ()
myStartupHook = do
    spawnOnce "emacs --daemon"
    spawnOnce "xset dpms 300 300 &"
    spawnOnce "picom &"

    setWMName "LG3D"

-- ManageHook rules
myManageHook :: ManageHook
myManageHook = mconcat
     [ isFullscreen --> doFullFloat
     , className =? "dunst"          --> doIgnore  
     , className =? "confirm"        --> doFloat
     , className =? "file_progress"  --> doFloat
     , className =? "dialog"         --> doFloat
     , className =? "download"       --> doFloat
     , className =? "error"          --> doFloat
     , className =? "notification"   --> doFloat
     , className =? "pinentry-gtk-2" --> doFloat
     , className =? "splash"         --> doFloat
     , className =? "toolbar"        --> doFloat
     , (className =? "firefox" <&&> resource =? "Dialog") 
         --> doFloat >> hasBorder False
     ]

-- START_KEYS
myKeys :: [(String, X ())]
myKeys =
    -- KB_GROUP XMonad
    [ ("M-q", safeSpawn "xmonad" ["--restart"]) -- Recompiles xmonad
    , ("M-S-q", io exitSuccess)                   -- Quits xmonad

    -- KB_GROUP Run Prompt
    , ("M-S-<Return>", spawn "dmenu_run -i -p \"Run: \"") -- Dmenu

    -- KB_GROUP Useful programs to have a keybinding for launch
    , ("M-<Return>", spawn myTerminal)
    , ("M-M1-h", spawn (myTerminal ++ " -e htop"))
    , ("M-b", spawn myBrowser)
    , ("M-p", spawn "DiscordCanary")

    -- KB_GROUP Kill windows
    , ("M-S-c", kill1)     -- Kill the currently focused client
    , ("M-S-a", killAll)   -- Kill all windows on current workspace

    -- KB_GROUP Windows navigation
    , ("M-m", windows W.focusMaster)  -- Move focus to the master window
    , ("M-j", windows W.focusDown)    -- Move focus to the next window
    , ("M-k", windows W.focusUp)      -- Move focus to the prev window
    , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
    , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
    , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
    , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
    , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
    , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
    , ("M-S-<Up>", sendMessage $ IncMasterN 1)      -- Increase # of clients master pane
    , ("M-S-<Down>", sendMessage $ IncMasterN (-1)) -- Decrease # of clients master pane
    , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
    , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    -- KB_GROUP Window resizing
    , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
    , ("M-l", sendMessage Expand)                   -- Expand horiz window width

    -- KB_GROUP Emacs
    , ("M-o", spawn myEmacs)

    -- KB_GROUP System
    , ("M-C-l",                   spawn "/home/avi/.config/xmonad/scripts/lock.sh")        
    , ("<XF86MonBrightnessUp>",   spawn "brightnessctl set +10%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
    , ("<XF86AudioLowerVolume>",  spawn "amixer set Master 5%- unmute")
    , ("<XF86AudioRaiseVolume>",  spawn "amixer set Master 5%+ unmute")
    , ("<XF86AudioMute>",         spawn "amixer set Master toggle")

    -- KB_GROUP dunst
    , ("C-<Space>",      spawn "dunstctl close")
    , ("C-S-<Space>",    spawn "dunstctl history-pop")
    , ("M-C-S-<Space>",  spawn "dunstctl close-all")

    -- KB_GROUP Screenshots
    , ("M-a", spawn "flameshot full")
    , ("M-s", spawn "flameshot gui")
    ]

-- handleEventHook
myHandleEventHook :: Event -> X All
myHandleEventHook = swallowEventHook (className =? "Alacritty") (return True)

myXMobarPP :: Handle -> PP
myXMobarPP xmproc = xmobarPP
  { ppOutput = hPutStrLn xmproc
  , ppTitle = xmobarColor "#c7c7c7" "" . shorten 60
  , ppCurrent = xmobarColor "#88c0d0" "" . wrap "[" "]"
  , ppVisible = xmobarColor "#4c566a" "" 
  , ppHidden = xmobarColor "#b48ead" ""
  , ppHiddenNoWindows = const ""
  , ppSep = pad "|"
  , ppOrder  = \(ws:l:_:_) -> [ws, l]
  }

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar"

    let baseConfig = docks $ ewmhFullscreen $ ewmh desktopConfig
    
    xmonad $ baseConfig
      { startupHook        = myStartupHook <> startupHook baseConfig
      , logHook            = dynamicLogWithPP $ myXMobarPP xmproc
      , handleEventHook    = myHandleEventHook <> handleEventHook baseConfig
      , manageHook         = myManageHook <> manageHook baseConfig
      , layoutHook         = avoidStruts $ smartBorders $ layoutHook baseConfig
      , modMask            = myModMask
      , terminal           = myTerminal
      , normalBorderColor  = myNormColor
      , focusedBorderColor = myFocusColor
      , borderWidth        = myBorderWidth
      } `additionalKeysP` myKeys
