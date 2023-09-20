local V7 = exports[Config.core]:GetCoreObject()

RegisterNetEvent("v7:gang:stash", function()
  TriggerServerEvent("inventory:server:OpenInventory", "stash", "V7-gangs", {
    maxweight = 4000000,
    slots = 500,
})
TriggerEvent("inventory:client:SetCurrentStash", "V7-gangs")
end)
 
 RegisterNetEvent('v7:gang:vehicle', function()
     local vehicle = Config.veh
         V7.Functions.Progressbar("Tkae", Lang:t('info.spawnveh'), 1000, false, false, {
             disableMovement = true,
             disableCarMovement = true,
             disableMouse = false,
             disableCombat = true,
         }, {}, {}, {}, function() -- Done
             DoScreenFadeOut(500)
             Wait(1000)
         V7.Functions.SpawnVehicle(vehicle, function(veh)
             local plate = V7.Functions.GetPlate(veh)
 
             SetEntityHeading(267.56) -- الاحداثيات
             SetVehicleModKit(veh, 0)
             TriggerEvent("vehiclekeys:client:SetOwner", plate)
             TriggerServerEvent('v7-gangsgarage:server:SaveVehicle', plate, vehicle)
             DoScreenFadeIn(500)
         end, vector4(-25.14, -1410.64, 29.51, 267.66), true) -- الاحداثيات
     end)
end)

local currentCameraIndex = 0
local createdCamera = 0

local function GetCurrentTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours < 10 then
        hours = tostring(0 .. GetClockHours())
    end
    if minutes < 10 then
        minutes = tostring(0 .. GetClockMinutes())
    end
    return tostring(hours .. ":" .. minutes)
end

local function ChangeSecurityCamera(x, y, z, r)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
        createdCamera = 0
    end

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, r.x, r.y, r.z, 2)
    RenderScriptCams(1, 0, 0, 1, 1)
    Wait(250)
    createdCamera = cam
end

local function CloseSecurityCamera()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    if Config.GangsCam.hideradar then
        DisplayRadar(true)
    end
    FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
end

local function InstructionButton(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

local function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
    scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage('Close Camera')
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

RegisterNetEvent('gangs:client:ActiveCamera', function(cameraId)
    if Config.GangsCam.cameras[cameraId] then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        SendNUIMessage({
            type = "enablecam",
            label = Config.GangsCam.cameras[cameraId].label,
            id = cameraId,
            connected = Config.GangsCam.cameras[cameraId].isOnline,
            time = GetCurrentTime(),
        })
        local firstCamx = Config.GangsCam.cameras[cameraId].coords.x
        local firstCamy = Config.GangsCam.cameras[cameraId].coords.y
        local firstCamz = Config.GangsCam.cameras[cameraId].coords.z
        local firstCamr = Config.GangsCam.cameras[cameraId].r
        SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
        ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)
        currentCameraIndex = cameraId
        DoScreenFadeIn(250)
    elseif cameraId == 0 then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        CloseSecurityCamera()
        SendNUIMessage({
            type = "disablecam",
        })
        DoScreenFadeIn(250)
    else
        V7.Functions.Notify("aa", "error")
    end
end)

RegisterNetEvent('gangs:client:DisableAllCameras', function()
    for k, _ in pairs(Config.GangsCam.cameras) do
        Config.GangsCam.cameras[k].isOnline = false
    end
end)

RegisterNetEvent('gangs:client:EnableAllCameras', function()
    for k, _ in pairs(Config.GangsCam.cameras) do
        Config.GangsCam.cameras[k].isOnline = true
    end
end)

RegisterNetEvent('gangs:client:SetCamera', function(key, isOnline)
    Config.GangsCam.cameras[key].isOnline = isOnline
end)

CreateThread(function()
    while true do
        local sleep = 2000
        if createdCamera ~= 0 then
            sleep = 5
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)

            if Config.GangsCam.hideradar then
                DisplayRadar(false)
            end
            
            if IsControlJustPressed(1, 177) then
                DoScreenFadeOut(250)
                while not IsScreenFadedOut() do
                    Wait(0)
                end
                CloseSecurityCamera()
                SendNUIMessage({
                    type = "disablecam",
                })
                DoScreenFadeIn(250)
            end

            if Config.GangsCam.cameras[currentCameraIndex].canRotate then
                local getCameraRot = GetCamRot(createdCamera, 2)

                if IsControlPressed(0, 32) then
                    if getCameraRot.x <= 0.0 then
                        SetCamRot(createdCamera, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                    end
                end

                if IsControlPressed(0, 8) then
                    if getCameraRot.x >= -50.0 then
                        SetCamRot(createdCamera, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                    end
                end

                if IsControlPressed(0, 34) then
                    SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
                end 

                if IsControlPressed(0, 9) then
                    SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
                end
            end
        end
        Wait(sleep)
    end
end)

function CreateNPC(type,model,anim,dict,pos,help)
    Citizen.CreateThread(function()
      local hash = GetHashKey(model)
      local talking = false
  
      RequestModel(hash)
      while not HasModelLoaded(hash) do
        Wait(1)
      end
  
      RequestAnimDict(anim)
      while not HasAnimDictLoaded(anim) do
        Wait(1)
      end
  
      local ped = CreatePed(type, hash, pos.x, pos.y, pos.z, pos.h, false, true)
      SetEntityHeading(ped, pos.h)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,anim,dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      
      while true do
        Citizen.Wait(0)
        local your = GetEntityCoords(GetPlayerPed(-1), false)
      end
    end)
  end
  --vector4(-26.81, -1412.53, 29.51, 308.88)
  CreateNPC(4,"csb_cletus","amb@world_human_clipboard@male@idle_b","idle_a",{x = -26.81, y = -1412.53, z = 29.51 - 1 , h = 308.88},"") 

RegisterNetEvent('v7:gang:money:client', function()
    V7.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            action = true
            V7.Functions.Progressbar("a", "", 4000, false, true, { 
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },{}, {}, function() 
             end)
        
             Citizen.Wait(4000)
        TriggerEvent("v7:money:client")
        print("true")
        else
            V7.Functions.Notify(Lang:t('Notify.notify1'), "error")
        end
         end, {Config.item1}) 
end)

RegisterCommand("test2", function()
    TriggerEvent("v7:gang:money:client")
end)

RegisterNetEvent("v7:money:client", function()
    TriggerServerEvent("v7:gangs:money", src)
end)