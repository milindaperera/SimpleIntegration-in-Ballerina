import ballerina/http;

// This simple sample (strip down to minimum) expose simple Rest API which return a string with service config
// command : Refer README.md


// Listener configurations
http:ServiceEndpointConfiguration httpListenerConfig = {
    keepAlive: "AUTO",
    timeoutMillis: 60000
};

// Listeners
listener http:Listener httpListener = new(9090, config = httpListenerConfig);

//Global Variables
string[] blacklistedIPs = ["40.125.118.175", "40.125.118.176"];

//Services
@http:ServiceConfig {
    basePath : "/filter"
}
service validationService on httpListener {

    @http:ResourceConfig {
        path: "/validateJson",
        consumes: ["application/json"]
    }
    resource function validateJson(http:Caller caller, http:Request request) {
        json|error payload = request.getJsonPayload();

        if (payload is error) {
            respond(caller, "Error occurred while reading the message");
        }
        
        if (payload is json[]) {
            if (validateUserEntries(caller, <json[]> payload)) {
                respond(caller, "Validation Successful");
            }
        } else {
            respond(caller, "Payload is not a JSON Array");
        }
        

    }
}

function respond(http:Caller caller, string payload) {
    var result = caller->respond(payload);
}

function validateUserEntries(http:Caller caller, json[] entries) returns boolean {
    foreach json entry in entries {
        if (entry.id == null) {
            respond(caller, "Record: " + entry.toString() + " does not contain id field!");
            return false;
        }
        if (entry.email == null) {
            respond(caller, "Record: " + entry.toString() + " does not contain email!");
            return false;
        }
        // TODO: email validation goes here
        if (entry.connectionInfo == null) {
            respond(caller, "Record: " + entry.toString() + " does not contain conection info!");
            return false;
        }
        if (isBlacklistedIP(<string>entry.connectionInfo.IPAddress)) {
            respond(caller, untaint ("IP address of record: " + entry.toString() + " is on blacklist!"));
            return false;
        }
    }
    return true;
}

function isBlacklistedIP(string ip) returns boolean {
    foreach string blackIP in blacklistedIPs {
        if (ip.equalsIgnoreCase(blackIP)) {
            return true;
        }
    }
    return false;
}