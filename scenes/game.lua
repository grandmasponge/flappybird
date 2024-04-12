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
local canAddPipe = 0
local score = 0
local bird
local scorelbl


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

--collision

local function checkCollision(obj1, obj2)
    local left  = (obj1.contentBounds.xMin) <= obj2.contentBounds.xMin and (obj1.contentBounds.xMax) >= obj2.contentBounds.xMin
    local right = (obj1.contentBounds.xMin) >= obj2.contentBounds.xMin and (obj1.contentBounds.xMin) <= obj2.contentBounds.xMax
    local up    = (obj1.contentBounds.yMin) <= obj2.contentBounds.yMin and (obj1.contentBounds.yMax) >= obj2.contentBounds.yMin
    local down  = (obj1.contentBounds.yMin) >= obj2.contentBounds.yMin and (obj1.contentBounds.yMin) <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end


local function update()

  print(pipes)

  if bird.crashed == false then
      for i = #backgrounds, 1, -1 do
          local b = backgrounds[i]
          b:translate( -2, 0 )

          if b.x < -(_W / 2) then
              b.x = b.x + (_W * 3)
          end
      end

      for i = #pipes, 1, -1 do
          local object = pipes[i]
          print(object.type)
          object:translate( -2, 0 )

          if object.x < -100 then
              local child = table.remove(pipes, i)

              if child ~= nil then
                  child:removeSelf()
                  child = nil
              end
          end

            if object.type == "sensor" then
                if checkCollision(bird, object) then
                    print("score")
                    score = score + 1
                    scorelbl.text = score .. "p"
                end
            end

            if object.type == "pipe" then
                if checkCollision(bird, object) then
                    print("dead")

                    bird.crashed = true

                    composer.gotoScene("scenes.gameover")
                end
            end

         
      end

      --

      bird.velocity = bird.velocity - bird.gravity
      bird.y = bird.y - bird.velocity

      if bird.y > _H or bird.y < 0 then
          print("dead")

          bird.crashed = true

          

          audio.play(sndCrash)

          
          composer.gotoScene("scenes.gameover")
         
      end

      --

      if canAddPipe > 100 then
          addPipe()
      
          canAddPipe = 0
      end

      canAddPipe = canAddPipe + 1
  end
end


--shake 

local function shake( event ) 

    if event.isShake then
        bird.velocity = 10
    end

    return true
end




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
  print("scene:create - game")

  -- Create main group and insert to scene
  grpMain = display.newGroup()

  self.view:insert(grpMain)

  grpWorld = display.newGroup()
  grpMain:insert(grpWorld)

  grpHud = display.newGroup()
  grpMain:insert(grpHud)

  -- Insert objects to grpMain here

  --
  -- Backgrounds

  local b1 = display.newImageRect(grpWorld, "background.png", _W, _H)
  b1.x = _CX
  b1.y = _CY
  backgrounds[#backgrounds+1] = b1

  local b2 = display.newImageRect(grpWorld, "background.png", _W, _H)
  b2.x = _CX + _W
  b2.y = _CY
  backgrounds[#backgrounds+1] = b2

  local b3 = display.newImageRect(grpWorld, "background.png", _W, _H)
  b3.x = _CX + (_W * 2)
  b3.y = _CY
  backgrounds[#backgrounds+1] = b3

  --
  -- Bird

  bird = display.newImageRect( grpWorld, "bird.png", 25, 20 )
  bird.x = 100
  bird.y = _CY
  bird.velocity = 0
  bird.crashed = false
  bird.gravity = 0.6

  --
  -- Score label

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


 

 
