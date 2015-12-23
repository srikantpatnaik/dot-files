import XMonad
import XMonad.Util.EZConfig(additionalKeys)

-- 'Super key + q' will perform the following in the backend
-- xmonad --recompile && xmonad --restart (the restart will keep the window arrangements intact

-- inspired from : http://www.linuxandlife.com/2011/11/how-to-configure-xmonad-arch-linux.html
main = do
xmonad	$ defaultConfig

	{
	modMask = mod4Mask -- Assign Alt(Mod) key Super Key(Windows Key)
        ,borderWidth = 0   -- Ofcourse, size of the red border
        -- ,normalBorderColor = "#abc123"
        -- ,focusedBorderColor = "#456def"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock; xset dpms force off") -- install slock lockscreen
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
