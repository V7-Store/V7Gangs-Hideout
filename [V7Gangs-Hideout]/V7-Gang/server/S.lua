local V7 = exports[Config.core]:GetCoreObject()
local src = source

function AddItem(item, numper)
    local src = source
    local PL = V7.Functions.GetPlayer(src)

    PL.Functions.AddItem(item, numper)
    TriggerClientEvent('inventory:client:ItemBox', src, V7.Shared.Items[item], 'add')
end

function RemoveItem(item, numper)
    local src = source
    local PL = V7.Functions.GetPlayer(src)

    PL.Functions.RemoveItem(item, numper)
    TriggerClientEvent('inventory:client:ItemBox', src, V7.Shared.Items[item], 'add')
end

RegisterNetEvent('v7:gang:giveweapon:pistol:mk2', function()
    local src = source
    local PL = V7.Functions.GetPlayer(src)
    ifcash1 = 5000


    if PL.Functions.GetMoney("cash") >= ifcash1 then
    AddItem(Config.weapon1, 1)
   TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notify2'))
   PL.Functions.RemoveMoney("cash", 5000)
    else
       TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notifyError'), "error")
    end
end)

RegisterNetEvent('v7:gang:giveweapon:pistol:50', function()
    local src = source
    local PL = V7.Functions.GetPlayer(src)
    ifcash2 = 8000

    if PL.Functions.GetMoney("cash") >= ifcash2 then
        AddItem(Config.weapon2, 1)
       TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notify2'))
       PL.Functions.RemoveMoney("cash", 8000)
        else
           TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notifyError'), "error")
        end 
end)

RegisterNetEvent('v7:gang:giveweapon:pistol:Clot', function()
    local src = source
    local PL = V7.Functions.GetPlayer(src)
    ifcash3 = 1000

    if PL.Functions.GetMoney("cash") >= ifcash3 then
        AddItem(Config.weapon3, 1)
       TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notify2'))
       PL.Functions.RemoveMoney("cash", 1000)
        else
           TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notifyError'), "error")
        end 
end)

RegisterNetEvent('v7:gangs:money', function()
    local src = source
    local PL = V7.Functions.GetPlayer(src)
    
    RemoveItem(Config.item1, 1)
    PL.Functions.AddMoney("cash", 500)
   TriggerClientEvent('QBCore:Notify', src, Lang:t('Notify.notify3'))
end)