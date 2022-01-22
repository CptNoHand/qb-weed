local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-weed:server:CheckAmount', function(ItemAmount, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemAmount = tonumber(ItemAmount)
    local CanProcess = Player.Functions.GetItemByName(Config.DryWeed)
    if CanProcess ~= nil and CanProcess.amount >= ItemAmount then
        if item == "WeedBag" then
            local Itemsneeded = Player.Functions.GetItemByName(Config.WeedBag)
            if Itemsneeded ~= nil and Itemsneeded.amount >= ItemAmount then
                TriggerClientEvent("qb-weed:client:MakingWeed", src, ItemAmount)
            else 
                TriggerClientEvent('QBCore:Notify', src, 'What are you gonna put weed inside?', 'error')
            end
        elseif item == "Joints" then
            local Itemsneeded = Player.Functions.GetItemByName(Config.JointItem)
            if Itemsneeded ~= nil and Itemsneeded.amount >= ItemAmount then
                TriggerClientEvent("qb-weed:client:MakingJoint", src, ItemAmount)
            else 
            TriggerClientEvent('QBCore:Notify', src, 'What are you gonna roll a joint with?', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not Enough Weed...', 'error')
    end
end)


RegisterServerEvent('qb-weed:client:MakingWeedDone', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(Config.WeedBag, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WeedBag], 'remove')

    Player.Functions.RemoveItem(Config.DryWeed, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.DryWeed], 'remove')

    Wait(1000)
    Player.Functions.AddItem(Config.WeedInBag, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WeedInBag], 'add')
end)

RegisterServerEvent('qb-weed:client:MakingJointDone', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(Config.JointItem, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.JointItem], 'remove')

    Player.Functions.RemoveItem(Config.DryWeed, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.DryWeed], 'remove')

    Wait(1000)
    Player.Functions.AddItem(Config.FinalJoint, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.FinalJoint], 'add')
end)