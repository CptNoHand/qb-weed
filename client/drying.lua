local QBCore = exports['qb-core']:GetCoreObject()

local function OpenWeedTable()
    local ProcessMenu = {
        {
            isMenuHeader = true,
            header = 'Weed Drying',
            txt =  'Dry your weed here!',
        },
    }
    table.insert(ProcessMenu, {
        header = "Dry Weed",
        txt = "Start drying your weed!",
        params = {
            event = "qb-weed:client:DryWeed",
        },
    })
    Wait(100)
    exports['qb-menu']:openMenu(ProcessMenu)
end

CreateThread(function() 
    for k, v in pairs(Config.WeedExtraction) do
        local coords = Config.WeedExtraction[k]["Coords"]

        exports['qb-target']:AddBoxZone("WeedDrying"..math.random(1,100), vector3(coords.x, coords.y, coords.z), 1.0, 1.0, { 
            name = "WeedDrying"..math.random(1,100), 
            heading = 25, 
            debugPoly = Config.DebugPolyzone, 
            minZ = coords.z-1, 
            maxZ = coords.z+1, 
            }, {
            options = { 
              { 
                type = "client", 
                event = "qb-weed:client:DryingWeed", 
                icon = 'fas fa-cannabis', 
                label = '????', 
              }
            },
            distance = 1.5,
        })
    end
end)

RegisterNetEvent('qb-weed:client:DryingWeed', function()
    OpenWeedTable()
end)

RegisterNetEvent('qb-weed:client:DryWeed', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Weed Processing',
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'DryWeed',
                text = 'Maximum: '..Config.MaxProcess..' At a time!'
            },
        }
    })
    if dialog then
        if not dialog.DryWeed then return end
        if tonumber(dialog.DryWeed) <= Config.MaxProcess then
            TriggerServerEvent('qb-weed:server:CheckWetAmount', dialog.DryWeed)
        else
            QBCore.Functions.Notify("You cannot process more than "..Config.MaxProcess.." at a time", "error", 4500)
        end
    end
end)

RegisterNetEvent('qb-weed:client:MakingWeedDry', function(amount)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    QBCore.Functions.Progressbar("WeedBagging", "Drying Weed", Config.ProcessTime*amount, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent("qb-weed:client:DryingWeedDone", amount)
    end)
end)