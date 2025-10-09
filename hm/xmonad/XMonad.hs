{- LANGUAGE UnicodeSyntax -}

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
import XMonad.Actions.PhysicalScreens

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.Rescreen
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
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
import XMonad.Util.NamedWindows
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
    , ("M-p", spawn "discord")

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
    , ("M-z", namedScratchpadAction scratchpads "terminal")
    , ("M-x", namedScratchpadAction scratchpads "emacs")

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
    ] ++ -- Better physical screen management
    [ (mods ++ [key], f sc)
    | (key, sc) <- zip "wer" [0..]
    , (mods, f) <- [("M-", viewScreen def), ("M-S-", sendToScreen def)]]

-- Greedy View a given physical screen
greedyViewScreen :: ScreenComparator -> PhysicalScreen -> X ()
greedyViewScreen sc p =
  do i <- getScreen sc p
     whenJust i $ \s -> do
       w <- screenWorkspace s
       whenJust w $ windows . W.greedyView

-- HandleEventHook Rules
myHandleEventHook :: Event -> X All
myHandleEventHook = swallowEventHook (className =? "Alacritty") (return True)

-- Spawn bars on screens
barSpawner :: ScreenId -> X StatusBarConfig
barSpawner sid
  sid == 0  = spawnBar "_XMONAD_LOG_1" "xmobar -x 0 ~/.config/xmobar/xmobarrc_main"
  sid == 1  = spawnBar "_XMONAD_LOG_2" "xmobar -x 1 ~/.config/xmobar/xmobarrc_other"
    where
      spawnBar prop cmd = statusBarGeneric cmd (xmonadPropLog' prop =<< mkLogString sid)

-- Build an output specific to the current screen
mkLogString :: ScreenId -> X String
mkLogString sid = do
  workspaces <- formatWorkspaces
  layout <- formatLayout
  title <- formatTitle
  pure $ intercalate "   " $ filter notNull
  [ formatWorkspaces
  , formatLayout
  , formatTitle
  ]
  where
   formatWorkspaces = withScreen sid $ \screen -> do
     -- Doing it this way because the workspace on this screen might not be focused
     currentWS <- W.tag $ W.workspace screen -- Get workspace on this screen
     -- Get all workspaces, visible workspace tags, hidden workspace tags
     (allWSs, visibleWSs, hiddenWSs) <- withWindowSet $ \s ->
       pure (W.workspaces s, map W.tag (current s : visible s), W.tag $ W.hidden s)
     pure $ intercalate " " $ filter notNulling $ do
       -- Filter out scratchpads
       ws <- filter (\W.Workspace { W.tag = tag } -> tag != scratchpadWorkspaceTag) allWSs
       let tag = W.tag ws
       -- Format workspace based on its state
       pure $ if tag == currentWS then showWS catSapphire tag      -- Visible on this screen
              else if tag `elem` visibleWs then showWS catText tag -- Visible on other screen
              else case W.stack ws of                              -- Hidden
                Just _  -> showWS catOverlay1 tag                  -- Hidden with windows
                Nothing -> ""                                      -- Hidden no windows
   formatLayout sid = (`withScreen` sid) $ Just . description . W.layout . W.workspace
   formatTitle sid = withScreen sid $ \screen ->
     case W.stack $ W.workspace screen of -- Check if any windows are being displayed
       Just s  -> Just $ shorten 40 $ show $ getName $ W.focus s
       Nothing -> Nothing
   -- Get info about a given screen
   withScreen :: ScreenId -> (WindowScreen -> Maybe String) -> X String
   withScreen n f = do
     ss <- withWindowSet $ return . W.screens
     case find ((== n) . W.screen ss of
       Just s  -> fromMaybe "" (f s)
       Nothing -> ""
   -- Show a workspace with a given fg color
   -- and a default bg color
   showWS fg = xmobarColor fg "" . renameWS
   renameWS "1" = xmobarFont 1 "\xf03a6"
   renameWS "2" = xmobarFont 1 "\xf03a9"
   renameWS "3" = xmobarFont 1 "\xf03ac"
   renameWS "4" = xmobarFont 1 "\xf03ae"
   renameWS "5" = xmobarFont 1 "\xf03b0"
   renameWS "6" = xmobarFont 1 "\xf03b5"
   renameWS "7" = xmobarFont 1 "\xf03b8"
   renameWS "8" = xmobarFont 1 "\xf03bb"
   renameWS "9" = xmobarFont 1 "\xf03be"

xmobarPP :: X PP
xmobarPP = pure $ filterOutWsPP [scratchpadWorkspaceTag]
  def { ppCurrent          = showWS catSapphire
      , ppVisible          = showWS catText
      , ppHidden           = showWS catOverlay1
      , ppHiddenNoWindows  = const ""
      , ppVisibleNoWindows = Nothing
      , ppUrgent           = showWS catRed
      , ppWsSep            = " "
      , ppSep              = "   "
      , ppTitle            = shorten 40
      }
  where
    -- Show a workspace with a given fg color
    -- and a default bg color
    showWS fg = xmobarColor fg "" . renameWS
    renameWS "1" = xmobarFont 1 "\xf03a6"
    renameWS "2" = xmobarFont 1 "\xf03a9"
    renameWS "3" = xmobarFont 1 "\xf03ac"
    renameWS "4" = xmobarFont 1 "\xf03ae"
    renameWS "5" = xmobarFont 1 "\xf03b0"
    renameWS "6" = xmobarFont 1 "\xf03b5"
    renameWS "7" = xmobarFont 1 "\xf03b8"
    renameWS "8" = xmobarFont 1 "\xf03bb"
    renameWS "9" = xmobarFont 1 "\xf03be"

main :: IO ()
main = do
    xmonad $ javaHack
           $ addRandrChangeHook (spawn "autorandr --change")
           $ dynamicSBs barSpawner
           $ docks
           $ ewmhFullscreen
           $ ewmh
           def { startupHook        = myStartupHook
               , handleEventHook    = myHandleEventHook <> fixSteamFlicker
               , manageHook         = myManageHook
               , layoutHook         = avoidStruts $ smartBorders $ windowNavigation $ myLayoutHook
               , modMask            = myModMask
               , terminal           = myTerminal Nothing
               , normalBorderColor  = catBase
               , focusedBorderColor = catSapphire
               , borderWidth        = 3
               } `additionalKeysP` myKeys
