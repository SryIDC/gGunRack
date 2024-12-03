return {
    Item = "gunrack",   -- Gunrack Item Name
    Keybind = "J",      -- Default keybind to open gunrack
    Weight = 150,        -- Weight in kg (default 80 KG)
    Slots = 15,         -- No of slots
    Logs = {            -- Discord log system for when a gun rack is registered and is lockpicked
        Enable = false, -- Enable/Disable discord Logs
        Webhook = "",   -- Webhook id for discord logs
    },
    Jobs = {            -- Jobs which can access gunrack
        ['police'] = 1,
    },
}
