using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$Num_Cuenta = $Request.Query.Num_cuenta
$saldo = $Request.Query.saldo
if (-not $Num_Cuenta) {
    $Num_Cuenta = $Request.Body.Num_cuenta
}

$body = "This HTTP triggered function executed successfully. Pass a Num_Cuenta in the query string or in the request body for a personalized response."

if ($Num_Cuenta) {
        
    Invoke-WebRequest -URI  https://72tgrow1b2.execute-api.us-east-1.amazonaws.com/Test1/modify-account -ContentType "application/json" -Method GET -Body (@{"num_cuenta" = $Num_Cuenta; "saldo"=$saldo;} | ConvertTo-Json)
    $body = "Hello, the amount $saldo were injected successfully into the table Banco.Cuenta to the account $Num_cuenta in database"
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})