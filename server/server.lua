local Config = require('config')
local ox_inventory = exports.ox_inventory

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    LoadGunracks(function(gunracks)
        print(gunracks .. ' number of gunracks has been loaded!')
    end)
end)

function LoadGunracks(cb)
    MySQL.query('SELECT * FROM gunracks', {}, function(result)
        local gunracks = 0
        if result then
            for i = 1, #result do
                local row = result[i]
                ox_inventory:RegisterStash(row.id, row.id, Config.Slots, Config.Weight * 1000, false, Config.Jobs)
                gunracks = gunracks + 1
            end
        end
        if cb then
            cb(gunracks)
        end
    end)
end

exports.qbx_core:CreateUseableItem(Config.Item, function(source)
    local src = source
    TriggerClientEvent('gRack:client:useItem', src)
end)


RegisterNetEvent('gRack:server:CreateStash', function(id, model, plate)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local citizenid = player.PlayerData.citizenid
    exports.ox_inventory:RemoveItem(src, Config.Item, 1)
    ox_inventory:RegisterStash(id, id, Config.Slots, Config.Weight * 1000, false, Config.Jobs)
    MySQL.insert.await('INSERT INTO `gunracks` (id, citizenid, model, plate) VALUES (?, ?, ?, ?)', {
        id, citizenid, model, plate
    })
end)
