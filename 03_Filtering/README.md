
# 01. Payload Validation 
Related file: 01_payload_validation.bal
## Command
```
curl -v http://localhost:9090/filter/validateJson \
    -H 'Content-Type: application/json' \
    -d '[
            {
                "id": "8fa8435c-fca4-4b42-9b5a-e81f9bd9aa16",
                "username": "bob",
                "email": "bob@mulesoft.com",
                "connectionInfo": {
                    "IPAddress": "212.141.190.171",
                    "MACAddress": "2A-7A-6F-D3-64-54"
                }
            },{
                "id": "6d4747ee-eb00-4e81-b7dc-2b01585e6d93",
                "username": "greg",
                "email": "greg@mulesoft.com",
                "connectionInfo": {
                    "IPAddress": "128.211.42.181",
                    "MACAddress": "8D-BD-C3-C4-D8-A4"
                }
            },{
                "id": "6d4747ee-eb00-4e81-b7dc-2b01585e6d99",
                "username": "anna",
                "email": "anna@mulesoft.com",
                "connectionInfo": {
                    "IPAddress": "40.125.118.177",
                    "MACAddress": "9E-05-9B-68-8E-80"
                }
            }
        ]'
```