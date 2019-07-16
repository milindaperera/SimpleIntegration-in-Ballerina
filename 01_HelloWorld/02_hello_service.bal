import ballerina/http;

// This simple sample (strip down to minimum) expose simple Rest API which return a string with service config
// command : curl -v http://localhost:9090/helloworld/sayhello

// Listener configurations
http:ServiceEndpointConfiguration helloWorldListenerConfig = {
    keepAlive: "AUTO",
    timeoutMillis: 60000
};

// Listeners
listener http:Listener helloWorldEP = new(9090, config = helloWorldListenerConfig);

//Services
@http:ServiceConfig {
    basePath : "/helloworld"
}
service helloService on helloWorldEP {

    @http:ResourceConfig {
        path: "/sayhello"
    }
    resource function sayHello(http:Caller caller, http:Request request) {
        var message = "Hello World !!";
        var result = caller->respond(message);
    }
}