-- Base
import XMonad
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

-- Layouts
import XMonad.Layout.PerWorkspace
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Renamed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.Simplest
import XMonad.Layout.NoBorders (smartBorders, noBorders, hasBorder)

-- Prompt
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Shell

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.WorkspaceCompare
import XMonad.Util.ExtensibleState qualified as XS
import XMonad.Util.Run (spawnPipe, safeSpawn)
import XMonad.Util.SpawnOnce
import XMonad.Util.Hacks (javaHack, fixSteamFlicker)

-- Data and Control modules
import Data.Monoid (All)

-- Theme
import Catppuccin

-- Use super as mod
myModMask :: KeyMask
myModMask = mod4Mask

-- Set _WM_ClASS if needed
myTerminal :: Maybe String -> String
myTerminal Nothing  = "alacritty"
myTerminal (Just s) = "alacritty --class \"Alacritty\",\"" ++ s ++ "\""

myBrowser :: String
myBrowser = "firefox"

-- Make Emacs keybindings easier to type
myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs'"

-- My XPrompt Config
myXPConfig :: XPConfig
myXPConfig = def { font = "xft:Hack:size=12"
                 , bgColor = catBase
                 , fgColor = catText
                 , promptBorderWidth = 0
                 , position = Top
                 , height = 34
                 , alwaysHighlight = True
                 , searchPredicate = fuzzyMatch
                 , sorter = fuzzySort
                 }

-- Startup Hook
myStartupHook :: X ()
myStartupHook = do
    -- Hack to make Java programs work properly
    setWMName "LG3D"

    spawn "polybar main"

-- Layouts are dumb when it comes to type signatures
myLayoutHook = onWorkspace "1" tabs $
               toggleLayouts (Full ||| Simplest) (tall ||| Mirror tall ||| tabs)
  where
    tall = Tall 1 (3/100) (1/2)
    tabs = named "Tabbed" $ tabbed shrinkText myTabConfig
    myTabConfig = def
      { activeColor = catSapphire
      , inactiveColor = catBase
      , urgentColor = catRed
      , activeBorderColor = catBase
      , inactiveBorderColor = catBase
      , urgentBorderColor = catRed
      , activeTextColor = catBase
      , inactiveTextColor = catFlamingo
      , urgentTextColor = catBase
      }

-- ManageHook Rules
myManageHook :: ManageHook
myManageHook = mconcat
     [ namedScratchpadManageHook scratchpads
     , isFullscreen --> doFullFloat
     , className =? "dunst"                  --> doIgnore
     , appName   =? "xdg-desktop-portal-gtk" --> centerFloat (1/2) (3/4) >> hasBorder False
     , appName   =? "emote"                  --> hasBorder False
     , className =? "confirm"                --> doFloat
     , className =? "file_progress"          --> doFloat
     , className =? "dialog"                 --> doFloat
     , className =? "download"               --> doFloat
     , className =? "error"                  --> doFloat
     , className =? "notification"           --> doFloat
     , className =? "pinentry-gtk-2"         --> doFloat
     , className =? "splash"                 --> doFloat
     , className =? "toolbar"                --> doFloat
     , (className =? "firefox" <&&> appName =? "Dialog")
           --> doFloat >> hasBorder False
     ]
     where
       centerFloat w h = customFloating $ W.RationalRect ((1-w)/2) ((1-h)/2) w h


-- Named Scratchpads
scratchpads :: [NamedScratchpad]
scratchpads = [ NS "terminal"
                   (myTerminal $ Just "scratchTerm")
                   (appName =? "scratchTerm")
                   (topFloat (9/10) (5/8))
              , NS "emacs"
                   (myEmacs ++ " --frame-parameters='(quote (name . \"scratchmacs\"))'")
                   (appName =? "scratchmacs")
                   (centerFloat (3/4) (3/4))
              ]
  where
    centerFloat w h = customFloating $ W.RationalRect ((1-w)/2) ((1-h)/2) w h
    topFloat w h = customFloating $ W.RationalRect ((1-w)/2) 0 w h

-- Keymap
myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
    [ ("M-q", safeSpawn "xmonad" ["--restart"]) -- Recompiles xmonad
    , ("M-S-q", io exitSuccess)                 -- Quits xmonad

    -- Run Prompt
    , ("M-S-<Return>", shellPrompt myXPConfig) -- Program launcher

    -- Useful programs to have a keybinding for launch
    , ("M-<Return>", spawn $ myTerminal Nothing)
    , ("M-b", spawn myBrowser)
    , ("M-p", spawn "Discord")

    -- Kill Windows
    , ("M-S-c", kill1)     -- Kill the currently focused client
    , ("M-S-a", killAll)   -- Kill all windows on current workspace

    -- Window Navigation
    , ("M-m", windows W.focusMaster)  -- Move focus to the master window
    , ("M-j", windows W.focusDown)    -- Move focus to the next window
    , ("M-k", windows W.focusUp)      -- Move focus to the prev window
    , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
    , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
    , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
    , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
    , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
    , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- Increase/Decrease Windows in The Master Pane or The Stack
    , ("M-C-k", sendMessage $ IncMasterN   1)  -- Increase # of clients master pane
    , ("M-C-j", sendMessage $ IncMasterN (-1)) -- Decrease # of clients master pane

    -- Window Resizing
    , ("M-h", sendMessage Shrink)       -- Shrink horiz window width
    , ("M-l", sendMessage Expand)       -- Expand horiz window width
    , ("M-f", sendMessage ToggleLayout) -- Move to full layout

    -- Emacs
    , ("M-o", spawn myEmacs)
    , ("M-i", spawn "doom +everywhere")

    -- Scratchpads
    , ("M-w", namedScratchpadAction scratchpads "terminal")
    , ("M-e", namedScratchpadAction scratchpads "emacs")

    -- System
    , ("M-C-l",                   unGrab >> spawn "i3lock-color --color=833993")
    , ("<XF86MonBrightnessUp>",   spawn "light -A 10")
    , ("<XF86MonBrightnessDown>", spawn "light -U 10")
    , ("<XF86AudioRaiseVolume>",  spawn "pamixer -i 5")
    , ("<XF86AudioLowerVolume>",  spawn "pamixer -d 5")
    , ("<XF86AudioMute>",         spawn "pamixer -t")

    -- Dunst
    , ("C-<Space>",     spawn "dunstctl close")
    , ("C-S-<Space>",   spawn "dunstctl history-pop")

    -- Screenshots
    , ("M-a", spawn "flameshot full")
    , ("M-s", unGrab >> spawn "flameshot gui")
    ] ++ -- More Window Navigation
    [ ("M-"++mod++"<"++dk++">", sendMessage $ msg d)
    | (dk, d) <- [("U",U), ("R",R), ("D",D), ("L",L)]
    , (mod, msg) <- [("", Go), ("S-", Move), ("C-S-", Swap)]
    ]

-- HandleEventHook Rules
myHandleEventHook :: Event -> X All
myHandleEventHook = swallowEventHook (className =? "Alacritty") (return True)

-- Tell polybar the current layout
-- NOTE: Only works on single headed systems
logLayoutToPolybar :: X ()
logLayoutToPolybar = withWindowSet $ \winset -> do
  let ld = description . W.layout . W.workspace . W.current $ winset
  spawn $ "polybar-msg action \"#layout.send." ++ ld ++ "\""

main :: IO ()
main = do
    let myFilter = pure $ filterOutWs [scratchpadWorkspaceTag]
    xmonad $ javaHack
           $ docks
           $ addEwmhWorkspaceSort myFilter
           $ ewmhFullscreen
           $ ewmh def
           { startupHook        = myStartupHook
           , handleEventHook    = myHandleEventHook <> fixSteamFlicker
           , logHook            = logLayoutToPolybar
           , manageHook         = myManageHook
           , layoutHook         = avoidStruts $ smartnBorders $ windowNavigation $ myLayoutHook
           , modMask            = myModMask
           , terminal           = myTerminal Nothing
           , normalBorderColor  = catBase
           , focusedBorderColor = catSapphire
           , borderWidth        = 3
           } `additionalKeysP` myKeys
