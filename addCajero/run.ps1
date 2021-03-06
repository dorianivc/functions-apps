using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = $Request.Query.Cedula
if (-not $name) {
    $name = $Request.Body.Cedula
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
        
    Invoke-WebRequest -URI https://72tgrow1b2.execute-api.us-east-1.amazonaws.com/Test1/addcajero -ContentType "application/json" -Method GET -Body (@{"cedula" = $name;} | ConvertTo-Json)
    $body = "Hello, the ID $name were injected successfully into the table Banco.Cajero"
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
