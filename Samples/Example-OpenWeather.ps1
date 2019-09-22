param
(
    [string]$WorpspaceId = $WorpspaceId,
    [string]$WorpspaceKey = $WorpspaceKey,
    [string]$LogTypeName = "OpenWeatherMap",
    [string]$apiKey=$apiKey,
    [string]$JsonData = "",
    [string]$TimeStampField =""
)

if (($WorpspaceId -eq "") -or ($WorpspaceKey -eq "") -or ($LogTypeName -eq "")) {
    Write-Error "WorkspaceId, WorkspaceKey and LogTypeName are requiered parameters"
    exit
}

Function Get-OpenWeatherMap($apiKey,$city)
{
	#api.openweathermap.org/data/2.5/weather?q=Bonn&APIKEY=xxxxxxxxxxxxxxxxxxxxxxx
    $method = "GET"
    $contentType = "application/json"
    $uri = "api.openweathermap.org/data/2.5/weather?q=${city}&APIKEY=${apiKey}"
    $headers = @{
    }
    $response = Invoke-WebRequest -Uri $uri -Method $method -ContentType $contentType -Headers $headers
    return $response.content
}

$cities=@("Bonn","Helsinki","Sidney")

do {
    $cities | foreach {
        $weatherJson=Get-OpenWeatherMap -apiKey $apiKey -city $_
        $weather=$weatherJson|ConvertFrom-Json
        write-host "Saving weather data for: $_ ($($weather.main.temp-273.15)°C)"
        ..\Tools\Add-AzureMonitorData.ps1 -WorpspaceId $WorpspaceId -WorpspaceKey $WorpspaceKey -LogTypeName $LogTypeName -JsonData $weatherJson
    }
    sleep 3
cls
} while ($true)

