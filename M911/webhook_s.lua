local cad_webapi = {
    url = "https://api.sonorancad.com/emergency/call_911",
    community_ID = "PRJSHDC",
    CAD_APIKEY = "484DCEE-2A1E-45BB-BB"
}

RegisterCommand('C911', function (source, author, text, location)
    PerformHttpRequest(cad_webapi.url, function (err, text, header) end, 
        'POST',
        json.encode({id = community_ID, key = CAD_APIKEY, type = "CALL_911", data = {serverId == 1, isEmergency == 1, caller = author, location = location, description = text, metaData = ""}}), {["Content-Type"] = 'application/json'}
)
end)