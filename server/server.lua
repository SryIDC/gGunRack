local Config = require('config')
local ox_inventory = exports.ox_inventory
local logger = require '@qbx_core.modules.logger'
local webhook = Config.Logs.Webhook

exports.qbx_core:CreateUseableItem(Config.Item, function(source)
    local src = source
    TriggerClientEvent('gRack:client:useItem', src)
end)

RegisterNetEvent('gRack:server:CreateStash', function(id)
    local src = source
    exports.ox_inventory:RemoveItem(src, Config.Item, 1)
    ox_inventory:RegisterStash(id, id, Config.Slots, Config.Weight * 1000, false, Config.Jobs)
    if Config.Logs.Enable then
        if webhook == "" then print("Webhook id was not registered") end
        logger.log({
            source = src,
            event = "Created stash",
            message = "New stash with id: "..id.." was created",
            webhook = webhook,
        })
    end
end)
