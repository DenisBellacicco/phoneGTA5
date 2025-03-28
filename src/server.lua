RegisterServerEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(target, message)
    local targetPlayer = GetPlayerFromServerId(target)
    if targetPlayer then
        TriggerClientEvent('phone:receiveSMS', targetPlayer, message)
        print("SMS envoyé à " .. target .. ": " .. message)
    else
        print("Erreur: joueur introuvable pour l'envoi du SMS")
    end
end)

RegisterServerEvent('phone:makeCall')
AddEventHandler('phone:makeCall', function(target)
    local targetPlayer = GetPlayerFromServerId(target)
    if targetPlayer then
        TriggerClientEvent('phone:incomingCall', targetPlayer, source)
        TriggerClientEvent('phone:callConnected', source, target)
        print("Appel de " .. source .. " vers " .. target)
    else
        print("Erreur: joueur introuvable pour l'appel")
    end
end)
