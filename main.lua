-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)

local composer = require('composer')
local backgroundMusic = audio.loadStream( "background.mp3" )

audio.play( backgroundMusic, { channel=1, loops=-1 } )
composer.recycleOnSceneChange = true
composer.gotoScene( "scenes.menu" )