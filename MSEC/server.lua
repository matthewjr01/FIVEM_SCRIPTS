

AddEventHandler('playerConnecting', function(name, setReason, deferrals)
    deferrals.defer()
    local source = source
    deferrals.update('whitelist_check')
    Citizen.Wait(300)
    local Identifiers = GetPlayerIdentifier(source)
    -- print(Identifiers)
    print("GOT NEW PLAYER WITH ID: ", Identifiers)
    MySQL.Async.fetchAll("SELECT * FROM usi WHERE SteamHex = @SteamHex",{["@SteamHex"] = Identifiers}, 
    function(result)
        if result[1] == nil then
            print("USER NOT WHITELISTED -- REJECTING ACCESS TO SERVER")
            setReason('USER NOT FOUND IN DB!!!')
            deferrals.defer("FAILED")
            print(SteamHex)
            print("USER NOT SET IN DB!!!")
            CancelEvent()
            deferrals.done("YOUR NOT AUTHROIZED!!")
        end
        print(result[1].Name)
        print(result[1].SteamHex)
        print(result[1].PermLevel)
        print(result[1].IsWhitelisted)

        if result[1] ~= nil then
            deferrals.done()
        end
    end)
    
    
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



AddEventHandler('chatMessage', function(source, name, msg)

    local source = source
    Citizen.Wait(300)
    local Identifiers = GetPlayerIdentifier(source)
    sm = stringsplit(msg, " ");
    if sm[1] == "/ooc" then
		CancelEvent()
		
	
    MySQL.Async.fetchAll("SELECT * FROM usi WHERE SteamHex = @SteamHex",{["@SteamHex"] = Identifiers}, 
    function(result)
        if result[1] == nil then
            print("USER NOT FOUND!!!")
        end
        print(result[1].Name)
        TriggerClientEvent('chatMessage', -1, "ooc | " .. result[1].Name, { 128, 128, 128 }, string.sub(msg,5))
    end)
end
	
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end