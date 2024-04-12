local composer = require("composer")
local relayout = require("relayout")


-- -----------------------------------------------------------------------------------
-- Set variables
-- -----------------------------------------------------------------------------------

-- Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- Scene
local scene = composer.newScene()

-- Groups
local grpMain
local grpWorld
local grpHud


-- Initialize the game

--variables
local pipes = {}
local backgrounds = {}
local score = 0
local bird


--pipes

local function addPipe()

    local distanceBetween = math.random(120, 200)
    local yPosition = math.random(150, _H - 150)

    local pTop = display.newImageRect(grpWorld, "pipe.png", 50, 600)
    pTop.x = _W + 50
    pTop.y = yPosition - (distanceBetween / 2) - 300
    pTop.type = "pipe"
    pTop.xScale = -1
    pTop.rotation = -180
    pipes[#pipes+1] = pTop

    local pBottom = display.newImageRect(grpWorld, "pipe.png", 50, 600)
    pBottom.x = _W + 50
    pBottom.y = yPosition + (distanceBetween / 2) + 300
    pBottom.type = "pipe"
    pipes[#pipes+1] = pBottom

    local pSensor = display.newRect(grpWorld, _W + 80, _CY, 5, _H)
    pSensor.fill = { 0, 1, 0 }
    pSensor.type = "sensor"
    pSensor.alpha = 0
    pipes[#pipes+1] = pSensor
end


local function update()
    bird.velocity = bird.velocity - bird.gravity
    bird.y = bird.y - bird.velocity
    
end




--shake 

local function shake( event ) 
    if event.isShake then
        bird.velocity = 10
    end

    return true
end




local composer = require( "composer" )
 
local scene = composer.newScene()



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
  print("scene:create - menu")

  -- Create main group and insert to scene
  grpMain = display.newGroup()

  self.view:insert(grpMain)

  grpWorld = display.newGroup()
  grpMain:insert(grpWorld)

  grpHud = display.newGroup()
  grpMain:insert(grpHud)

  -- Background objects

  local b1 = display.newImageRect(grpWorld, "background.jpg", _W, _H)
    b1.x = _CX
    b1.y = _CY
    backgrounds[#backgrounds+1] = b1

    local b2 = display.newImageRect(grpWorld, "background.jpg", _W, _H)
    b2.x = _CX + _W
    b2.y = _CY
    backgrounds[#backgrounds+1] = b2

    local b3 = display.newImageRect(grpWorld, "background.jpg", _W, _H)
    b3.x = _CX + (_W * 2)
    b3.y = _CY
    backgrounds[#backgrounds+1] = b3
  grpMain:insert(b1)
  grpMain:insert(b2)
  grpMain:insert(b3)

  -- bird

  bird = display.newImageRect(grpWorld, "bird.png", 35, 30)
  bird.x = 100
  bird.y = _CY
  bird.velocity = 0
  bird.crashed = false
  bird.gravity = 0.4

  grpMain:insert(bird)

  Runtime:addEventListener( "accelerometer", shake )
  Runtime:addEventListener( "enterFrame", update )


  --
end



-- show()
function scene:show( event )
  if ( event.phase == "will" ) then
  elseif ( event.phase == "did" ) then
  end
end



-- hide()
function scene:hide( event )
  if ( event.phase == "will" ) then
  elseif ( event.phase == "did" ) then
  end
end



-- destroy()
function scene:destroy(event)
  if event.phase == "will" then
    Runtime:removeEventListener("enterFrame", update)
    Runtime:removeEventListener("accelerometer", shake)
  end
end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

-- made by becca 


 

 
