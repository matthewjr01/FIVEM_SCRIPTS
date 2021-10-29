local community_ID = "PRJSHDC"
local CAD_APIKEY = "484DCEE-2A1E-45BB-BB"
local SERVER_ID = 1

local ACU_API = "https://api.sonorancad.com/emergency/get_active_units"
local CALL_API = "https://api.sonorancad.com/emergency/get_active_units"

local Active_CALLS_webapi = {
    url = ACU_API,
    community_ID = community_ID,
    CAD_APIKEY = CAD_APIKEY,
    SERVER_ID = SERVER_ID
}






U_UNITID = ""


local POST_GET_AUNITS_DATA  = { -- DATA FORMATION FOR GET_ACTIVE_UNITS (POST) CALL
    ['serverId'] = SERVER_ID,  -- ID OF THIS SERVER
    ['onlyUnits'] = true  -- Show only Units Not Dispatches if true
}




-- local EXAMPLE  = {
--     ['serverId'] = SERVER_ID, 
--     ['isEmergency'] = true, 
--     ['caller'] = unit.data.name, 
--     ['location'] = unit.location, 
--     ['description'] = ("Unit %s has pressed their panic button!"):format(unit.data.unitNum),
--     ['metaData'] = {
--         ['callerPlayerId'] = source,
--         ['callerApiId'] = GetIdentifiers(source)[Config.primaryIdentifier],
--         ['uuid'] = uuid(),
--         ['silentAlert'] = false,
--         ['useCallLocation'] = false,
--         ['callPostal'] = postal
--     }
-- }

function Get_ActiveUnits()
    PerformHttpRequest(Active_CALLS_webapi.url, function (err, text, header) end, 
        'GET',
        json.encode({id = community_ID, key = CAD_APIKEY, type = "GET_ACTIVE_UNITS", data = POST_GET_AUNITS_DATA}), {["Content-Type"] = 'application/json'})
        print(header, text)
        return
end


RegisterCommand('ActiveUnits', function (source, author, text, location)
    print("RUNNING COMMAND TO GET ACTIVE UNITS")
    Get_ActiveUnits()
end)