

AddEventHandler('playerConnecting', function(name, setReason)
    local source = source
    Citizen.Wait(300)
    local Identifiers = GetPlayerIdentifier(source)
    print(Identifiers)
    print("GOT NEW PLAYER WITH ID: ", Identifiers)
    MySQL.Async.fetchAll("SELECT * FROM usi WHERE SteamHex = @SteamHex",{["@SteamHex"] = Identifiers}, 
    function(result)
        print(result[1].Name)
        print(result[1].SteamHex)
        print(result[1].PermLevel)
        print(result[1].IsWhitelisted)
    end)

    local SteamHex = result[1].SteamHex
    local Name = result[1].name
    local PermLevel = result[1].PermLevel
    local IsWhitelisted = result[1].IsWhitelisted

    if SteamHex == nil then
        print("SYSTEM IDENTIFIER FOUND IS: "+ Identifiers)
        print("DB IDENTIFIER FOUND IS: "+ SteamHex)
        print("USER NOT FOUND IN DB FOR WHITELIST!!! RETURNED NULL")
        setReason('Could Not Find User!!!')
        CancelEvent()
        return
    end

    if Name == nil then
        setReason('USER "NAME" NOT FOUND IN DB!!!')
        print(SteamHex)
        print("USER: NAME: NOT SET IN DB CORRECTLY!!!")
        CancelEvent()
        return
    end
    
    if(IsWhitelisted == 0) then
        setReason('USE NOT WHITELISTED!!!!')
        print(SteamHex)
        print("USER NOT WHITELISTED IN SERVER")
        CancelEvent()
        return
    end
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