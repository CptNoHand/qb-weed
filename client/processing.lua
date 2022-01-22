local QBCore = exports['qb-core']:GetCoreObject()

local function OpenWeedTable()
    local ProcessMenu = {
        {
            isMenuHeader = true,
            header = 'Weed Processing Table',
            txt =  '',
        },
    }
    Wait(100)
    table.insert(ProcessMenu, {
        header = "Weed Bags",
        txt = "Make some 2.5oz bags of weed!",
        params = {
            event = "qb-weed:client:WeedBag",
        },
    })
    Wait(100)
    table.insert(ProcessMenu, {
        header = 'Joints',
        txt = 'Rolle some Joints!',
        params = {
            event = "qb-weed:client:Joint",
        }
    })
    Wait(100)
    exports['qb-menu']:openMenu(ProcessMenu)
end

CreateThread(function() 
    for k, v in pairs(Config.WeedProcessing) do
        local coords = Config.WeedProcessing[k]["Coords"]

        exports['qb-target']:AddBoxZone("WeedProcessing"..math.random(1,100), vector3(coords.x, coords.y, coords.z), 1.0, 1.0, { 
            name = "WeedProcessing"..math.random(1,100), 
            heading=25, 
            debugPoly = Config.DebugPolyzone, 
            minZ = coords.z-1, 
            maxZ = coords.z+1, 
            }, {
            options = { 
              { 
                type = "client", 
                event = "qb-weed:client:Process", 
                icon = 'fas fa-cannabis', 
                label = '????', 
              }
            },
            distance = 1.5,
        })
    end
end)

RegisterNetEvent('qb-weed:client:Process', function()
    OpenWeedTable()
end)

RegisterNetEvent('qb-weed:client:WeedBag', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Weed Processing',
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'WeedBag',
                text = 'Maximum: '..Config.MaxProcess..' At a time!'
            },
        }
    })
    if dialog then
        if not dialog.WeedBag then return end
        if tonumber(dialog.WeedBag) <= Config.MaxProcess then
            TriggerServerEvent('qb-weed:server:CheckAmount', dialog.WeedBag, "WeedBag")
        else
            QBCore.Functions.Notify("You cannot process more than "..Config.MaxProcess.." at a time", "error", 4500)
        end
    end
end)

RegisterNetEvent('qb-weed:client:Joint', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Joint Making',
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'Joint',
                text = 'Maximum: '..Config.MaxProcess..' At a time!'
            },
        }
    })
    if dialog then
        if not dialog.Joint then return end
        if tonumber(dialog.Joint) <= Config.MaxProcess then
            TriggerServerEvent('qb-weed:server:CheckAmount', dialog.Joint, "Joints")
        else
            QBCore.Functions.Notify("You cannot process more than "..Config.MaxProcess.." at a time", "error", 4500)
        end
    end
end)


RegisterNetEvent('qb-weed:client:MakingJoint', function(amount)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    QBCore.Functions.Progressbar("JointsMaking", "Making Joints", Config.ProcessTime*amount, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent("qb-weed:client:MakingJointDone", amount)
    end)
end)

RegisterNetEvent('qb-weed:client:MakingWeed', function(amount)
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    QBCore.Functions.Progressbar("WeedBagging", "Bagging Weed", Config.ProcessTime*amount, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent("qb-weed:client:MakingWeedDone", amount)
    end)
end)