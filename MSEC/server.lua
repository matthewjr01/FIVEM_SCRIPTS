

AddEventHandler('playerConnecting', function(name, setReason, deferrals)
    deferrals.defer()
    local source = source
    deferrals.update(_U('whitelist_check'))
    Citizen.Wait(300)
    local Identifiers = GetPlayerIdentifier(source)
    -- print(Identifiers)
    -- print("GOT NEW PLAYER WITH ID: ", Identifiers)
    MySQL.Async.fetchAll("SELECT * FROM usi WHERE SteamHex = @SteamHex",{["@SteamHex"] = Identifiers}, 
    function(result)
        if result[1] == nil then
            setReason('USER NOT FOUND IN DB!!!')
            deferrals.done('not_whitelisted')
            print(SteamHex)
            print("USER NOT SET IN DB!!!")
            CancelEvent()
            return
        end
        print(result[1].Name)
        print(result[1].SteamHex)
        print(result[1].PermLevel)
        print(result[1].IsWhitelisted)
    end)

    deferrals.done()
end)


function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end