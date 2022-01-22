local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-weed:server:CheckWetAmount', function(ItemAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemAmount = tonumber(ItemAmount)
    local CanProcess = Player.Functions.GetItemByName(Config.WeedItem)
    if CanProcess ~= nil and CanProcess.amount >= ItemAmount then
        TriggerClientEvent("qb-weed:client:MakingWeedDry", src, ItemAmount)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not Enough Weed...', 'error')
    end
end)


RegisterServerEvent('qb-weed:client:DryingWeedDone', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(Config.WeedItem, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WeedItem], 'remove')

    Wait(1000)
    Player.Functions.AddItem(Config.DryWeed, amount, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.DryWeed], 'add')
end)