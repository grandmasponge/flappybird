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
local scorelbl
local bird
local canAddPipe = 0


--pipes

local function addPipe()

    print("addPipe")

    local distanceBetween = math.random(120, 200)
    local yPosition = math.random(150, _H - 150)

    local pTop = display.newRect(_W + 50, yPosition - (distanceBetween / 2) - 300, 50, 600)
    pTop.fill = { 0, 1, 0 }
    pTop.type = "pipe"
    pipes[#pipes+1] = pTop

    local pBottom = display.newRect(_W + 50, yPosition + (distanceBetween / 2) + 300, 50, 600)
    pBottom.fill = { 0, 1, 0 }
    pBottom.type = "pipe"
    pipes[#pipes+1] = pBottom

    local pSensor = display.newRect(_W + 80, _CY, 5, _H)
    pSensor.fill = { 0, 1, 0 }
    pSensor.type = "sensor"
    pSensor.alpha = 0
    pipes[#pipes+1] = pSensor

end


local function update()
    if bird.crashed == false  then
        for i = #backgrounds, 1, -1 do
            local b = backgrounds[i]
            b:translate( -2, 0 )

            if b.x < -(_W / 2) then
                b.x = b.x + (_W * 3)
            end
        end

        if bird.y < 0 or bird.y > _H then
            bird.crashed = true
        end

        if canAddPipe > 100 then
            addPipe()
        
            canAddPipe = 0
        end
        canAddPipe = canAddPipe + 1

        bird.velocity = bird.velocity - bird.gravity
        bird.y = bird.y - bird.velocity

    end 
    if bird.crashed == true then
        composer.gotoScene("scenes.gameover")
    end
end

--collision

local function checkCollision(obj1, obj2)

    local left  = (obj1.contentBounds.xMin) <= obj2.contentBounds.xMin and (obj1.contentBounds.xMax) >= obj2.contentBounds.xMin
    local right = (obj1.contentBounds.xMin) >= obj2.contentBounds.xMin and (obj1.contentBounds.xMin) <= obj2.contentBounds.xMax
    local up    = (obj1.contentBounds.yMin) <= obj2.contentBounds.yMin and (obj1.contentBounds.yMax) >= obj2.contentBounds.yMin
    local down  = (obj1.contentBounds.yMin) >= obj2.contentBounds.yMin and (obj1.contentBounds.yMin) <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
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

local function birdCollisions()
    
end

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

  --hud

  scorelbl = display.newText("0p", _CX, 180, "PressStart2P-Regular.ttf", 40)
  grpMain:insert(scorelbl)

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


 

 
