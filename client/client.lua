local ox_inventory = exports.ox_inventory
local Config = require('config')
RegisterNetEvent('gRack:client:useItem', function()
    local plate = GetVehicleNumberPlateText(cache.vehicle)
    local model = qbx.getVehicleDisplayName(cache.vehicle)
    local class = GetVehicleClass(cache.vehicle)
    local id = "GunRack_" .. plate
    if not cache.vehicle then return end
    if not QBX.PlayerData.job.name == 'police' then return lib.notify({ description = "You are not a police"}) end
    if class ~= 18 then return lib.notify({ description = "Can't install gun rack in a non-emergency vehicle!" }) end
    if ox_inventory:openInventory('stash', { id = id }) == false then
        if lib.progressBar({
                label = "Installing gunrack...",
                anim = {
                    dict = "mini@repair",
                    clip = "fixing_a_ped",
                },
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                },
                duration = 5000,
            }) then
            lib.notify({ description = "Installed gunrack" })
            TriggerServerEvent('gRack:server:CreateStash', id, model, plate)
        end
    else
        lib.notify({ description = "This vehicle already has a gunrack" })
    end
end)

lib.addKeybind({
    name = 'opengunrack',
    description = 'press J to open gunrack',
    defaultKey = Config.Keybind,
    onPressed = function(self)
        if not cache.vehicle then return end
        local class = GetVehicleClass(cache.vehicle)
        if class ~= 18 then return end
        local plate = GetVehicleNumberPlateText(cache.vehicle)
        local id = 'GunRack_' .. plate
        if ox_inventory:openInventory('stash', { id = id }) == false then
            lib.notify({ description = "This vehicle doesn't have a gunrack" })
        else
            ox_inventory:openInventory('stash', { id = id })
        end
    end
})
