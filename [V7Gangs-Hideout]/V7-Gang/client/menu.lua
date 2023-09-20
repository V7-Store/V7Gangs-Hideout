local src = source

RegisterNetEvent('first:menu:aboa7med:v7:gang', function()
exports[Config.menu]:openMenu({
{
    header = "شراء الأسلحة",
    txt = "تستطيع شراء الاسلحة من هنا",
},
{
    header = "Pistol Mk2",
    txt = "شراء $5000",
    params = {
        event = "v7:gang:giveweapon:pistol:mk2:client",
    }
},
{
    header = "Pistol 50",
    txt = "شراء $8000",
    params = {
        event = "v7:gang:giveweapon:pistol:50:client",
    }
},
{
    header = "Pistol Clot",
    txt = "شراء $1000",
    params = {
        event = "v7:gang:giveweapon:pistol:Clot:client2",
    }
},
{
    header = "[x] الخروج",
    params = {
        event = "",
    }
},
})
end)

RegisterNetEvent('two:menu:aboa7med:v7:gang', function()
exports[Config.menu]:openMenu({
{
    header = "كيمرات المقر",
},
{
    header = "البوابة",
    txt = "رؤية المكان",
    params = {
        event = "gangs:client:ActiveCamera",
        args = 1
    }
},
{
    header = "الشارع",
    txt = "رؤية المكان",
    params = {
    event = "gangs:client:ActiveCamera",
    args = 2
    }
},
{
    header = "خلف المقر",
    txt = "رؤية المكان",
    params = {
        event = "gangs:client:ActiveCamera",
        args = 3
    }
},
})
end) -- done\\


RegisterNetEvent("v7:gang:giveweapon:pistol:mk2:client", function()
    TriggerServerEvent("v7:gang:giveweapon:pistol:mk2", src)
end)

RegisterNetEvent("v7:gang:giveweapon:pistol:50:client", function()
    TriggerServerEvent("v7:gang:giveweapon:pistol:50", src)
end)

RegisterNetEvent("v7:gang:giveweapon:pistol:Clot:client2", function()
    TriggerServerEvent("v7:gang:giveweapon:pistol:Clot", src)
end)
