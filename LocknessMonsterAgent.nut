server.log("Lock/Unlock: " + http.agenturl() + "?LockState=[insert state]");

//local previousState = 1; //state of lock
local impLocation = "";

device.on("location", function (location) {
    local url = "https://maps.googleapis.com/maps/api/browserlocation/json?browser=electric-imp&sensor=false";
    
    foreach (network in location) {
        url += ("&wifi=mac:" + addColons(network.bssid) + "|ss:" + network.rssi);
    }

    local request = http.get(url);
    local response = request.sendsync();

    if (response.statuscode == 200) {
        local data = http.jsondecode(response.body);
        
        impLocation = data.location.lat + "," + data.location.lng;
    }
});

function requestHandler(request, response) {
    try {
        //LockState 1 = unlock; 0 = lock
        if ("LockState" in request.query) {
            
            if (request.query.LockState == "1") {
                  
                device.send("set.motor2", -1);
                imp.sleep(50);
                device.send("set.motor2", 0);
                device.send("set.motor1", 1);
                imp.sleep(1);
                device.send("set.motor1", 0);
                
            }
            else if (request.query.LockState == "0") {
                
                device.send("set.motor1", -1);
                imp.sleep(2);
                device.send("set.motor1", 0);
                imp.sleep(1);
                device.send("set.motor2", 1);
                imp.sleep(35);
                device.send("set.motor2", 0);
            }
            else if (request.query.LockState == "-1") //location state
            {
                response.send(200,impLocation);
            }
            else
            {
                device.send("set.motor1", 0);
                device.send("set.motor2", 0);
            }
        }
    
        // Send a response back to the browser saying everything was OK.
        //response.send(200, "OK");

    } catch (ex) {
        response.send(500, "Internal Server Error: " + ex);
    }
}

http.onrequest(requestHandler);

function addColons(bssid) {
    local result = bssid.slice(0, 2);
    
    for (local i = 2; i < 12; i += 2) {
        result += ":" + bssid.slice(i, (i + 2));
    }
    
    return result;
}