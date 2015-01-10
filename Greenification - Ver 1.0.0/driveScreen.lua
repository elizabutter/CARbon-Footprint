local composer = require( "composer" )

local scene = composer.newScene()

local save5Achieve = "CgkI-_Shl70OEAIQAg"
local save10Achieve = "CgkI-_Shl70OEAIQAw"
local save20Achieve = "CgkI-_Shl70OEAIQBA"

local drive25Achieve = "CgkI-_Shl70OEAIQBQ"
local drive50Achieve = "CgkI-_Shl70OEAIQBg"


-- "scene:create()"
function scene:create( event )

  local sceneGroup = self.view





    local startDriveButton = display.newCircle( 100, 100, 256 )
    startDriveButton.x = _W*0.5
    startDriveButton.y = _H*0.5
    sceneGroup:insert(startDriveButton)


    local function goToDriveScreen (event)
      if event.phase == "began" then
        gameNetwork.show("leaderboards")
      end
    end

    startDriveButton:addEventListener( "touch", goToDriveScreen )



  local moneySavedText = display.newText( "0", 0, 0, native.systemFont, 100 )
  moneySavedText.x = _W*0.5
  moneySavedText.y = _H*0.5-500
  moneySavedText:setFillColor( 1, 1, 1 )
  moneySavedText.anchorX = 0.5
  sceneGroup:insert(moneySavedText)

  local mpgText = display.newText( "0", 0, 0, native.systemFont, 100 )
  mpgText.x = _W*0.5 + 360
  mpgText.y = _H*0.5-500
  mpgText:setFillColor( 1, 1, 1 )
  mpgText.anchorX = 0.5
  sceneGroup:insert(mpgText)


  local milesDrivenText = display.newText( "0", 0, 0, native.systemFont, 100 )
  milesDrivenText.x = _W*0.5 - 360
  milesDrivenText.y = _H*0.5-500
  milesDrivenText:setFillColor( 1, 1, 1 )
  milesDrivenText.anchorX = 0.5
  sceneGroup:insert(milesDrivenText)







  local fuelPrice = 2.75
  local milesDriven = 0

  local estimatedMPG = vehicleMPG or 0
  local estimatedFuelUsed
  local estimatedSpentOnFuel

  local simulatedMPG
  local simulatedFuelUsed
  local simulatedSpentOnFuel

  local moneyDifference
  local moneyDifferenceTemp = 0
  local moneyDifferenceRounded = 0


  local function addSavings()

    local digits = 2
    local shift = 10 ^ digits


    moneyDifferenceRounded = math.floor( moneyDifference*shift + 0.5 )/shift
    moneyDifferenceTemp = moneyDifferenceTemp + moneyDifferenceRounded

    moneySavedText.text = ("$" .. moneyDifferenceTemp)

    if estimatedFuelUsed > simulatedFuelUsed then
      print("Total Savings: " .. "$" .. moneyDifferenceRounded)

    elseif estimatedFuelUsed < simulatedFuelUsed then
      print("Total Lost: " .. "$" .. math.abs(moneyDifferenceRounded))
    end
  end



  local function calcMPG()

    milesDriven = milesDriven + 1
    milesDrivenText.text = milesDriven

    if milesDriven >= 2 then

      --Actual Fuel Math Functions

      print("Estimated MPG: " .. estimatedMPG )

      estimatedFuelUsed = milesDriven/estimatedMPG
      print("Estimated Fuel Used: " .. estimatedFuelUsed .. " Gallons")
      --Exact number from the car's data

      estimatedSpentOnFuel = fuelPrice*estimatedFuelUsed --Exact Amount Spent of Fuel
      print("Estimated Amount Spent on Fuel: " .. "$" .. estimatedSpentOnFuel )


      --Random Fuel Math Functions

      simulatedFuelUsed = math.random(100*estimatedFuelUsed*0.95, 100*estimatedFuelUsed*1.02) / 100
      print("Simulated Fuel Used: " .. simulatedFuelUsed .. " Gallons")
      --Fudged number to show variation

      simulatedSpentOnFuel = fuelPrice*simulatedFuelUsed --Fudged Amount Spent of Fuel
      print("Simulated Amount Spent on Fuel: " .. "$" .. simulatedSpentOnFuel )

      simulatedMPG = milesDriven/simulatedFuelUsed
      print("Simulated MPG: " .. simulatedMPG )

      mpgText.text = math.round(simulatedMPG*10)*0.1

      moneyDifference = (estimatedSpentOnFuel - simulatedSpentOnFuel)
      addSavings()
    end

  end

  calcMPG()
  timer.performWithDelay(2000, calcMPG, 0) --After every mile





    --average
    --highest
    --lowest


    --leaderboards - highest mpg average over 50 miles, highest mpg over 100 miles
    -- achievements - Save $5, Save $10, Save $20, Save $50, Drive 50 miles using Greenification

    ---coupons also pop up when you get Achievements













    function calcDist(lat1, lon1, lat2, lon2)
      lat1 = 37.989150
      lat2 = 37.997519
      lon1 = -122.076264
      lon2 = -121.715381

      dlon = lon2-lon1
      dlat = lat2-lat1

      a = math.pow(math.sin(dlat/2),2) + math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon/2),2)
      c = 2 * math.asin(math.sqrt(a))
      dist = 58.9 * c      -- multiply by 0.621371 to convert to miles
      print(dist)
      return dist
    end

    calcDist()

--[[

    local myMap = native.newMapView( 0, 0, 320, 480 )
    myMap.x = display.contentCenterX
    myMap.y = display.contentCenterY

    local locationTable  = myMap:getUserLocation()
    local locationtxt = display.newText( "My location is: ", 0, 0, native.systemFont, 16 )
    locationtxt.x = display.contentCenterX
    locationtxt.y = display.contentCenterY+ 500

    if ( locationTable.errorCode ) then
      locationtxt.text = locationtxt.text .. locationTable.errorMessage
    else
      locationtxt.text = locationtxt.text .. locationTable.latitude .. ", " ..locationTable.longitude
    end
--]]

  end



  -- "scene:destroy()"
  function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
  end


  -- -------------------------------------------------------------------------------

  -- Listener setup
  scene:addEventListener( "create", scene )
  scene:addEventListener( "show", scene )
  scene:addEventListener( "hide", scene )
  scene:addEventListener( "destroy", scene )

  -- -------------------------------------------------------------------------------

  return scene