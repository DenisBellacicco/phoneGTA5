local phoneOpen = false
local contacts = {}

RegisterCommand('phone', function()
    phoneOpen = not phoneOpen
    SetNuiFocus(phoneOpen, phoneOpen)
    SendNUIMessage({ action = phoneOpen and "open" or "close", contacts = contacts })
end, false)

RegisterNUICallback('closePhone', function()
    phoneOpen = false
    SetNuiFocus(false, false)
end)

RegisterNUICallback('addContact', function(data, cb)
    table.insert(contacts, { name = data.name, number = data.number })
    cb('ok')
end)

RegisterNUICallback('sendSMS', function(data, cb)
    TriggerServerEvent('phone:sendSMS', data.target, data.message)
    cb('ok')
end)

RegisterNUICallback('makeCall', function(data, cb)
    TriggerServerEvent('phone:makeCall', data.target)
    cb('ok')
end)

RegisterNetEvent('phone:receiveSMS')
AddEventHandler('phone:receiveSMS', function(message)
    SendNUIMessage({ action = "receiveSMS", message = message })
end)

RegisterNetEvent('phone:incomingCall')
AddEventHandler('phone:incomingCall', function(caller)
    SendNUIMessage({ action = "incomingCall", caller = caller })
end)

RegisterNetEvent('phone:callConnected')
AddEventHandler('phone:callConnected', function(target)
    SendNUIMessage({ action = "callConnected", target = target })
end)