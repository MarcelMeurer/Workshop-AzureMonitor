# Workshop Azure Monitor - Lessons

To get practice in using Azure Monitor, I have prepared some examples. These examples can be recreated with a little PowerShell. I have prepared more complex program parts. These can be found in the "Tools" folder. Finished solutions are stored in the folder "Samples".

### In the Tools folder there are the following scripts:

```powershell
./Add-AzureMonitorData.ps1 -WorpspaceId <WorkSpaceId> -WorpspaceKey <WorpspaceKey> -LogTypeName <LogTypeName> [-TimeStampField <TimeStampField>] -JsonData <JsonData>
```

Send jsonData to the Log Analytics workspace into the given LogTyeName. TimeStampField is not mandatory. If given, it must be the name of the field containing the timestamp of each data set.

## Missions

### Store information about the running processes from your computer

Collect the process information from your computer each 30 seconds and send these data to your Log Analytics workspace. Use PowerShell to automate this mission.

Select an app and use this app  to "overload" your CPU.

If data are visible in Log Analytics, build a custom dashboard by using "Log" to query the data.

- Find out:

  - Count of distinct processes
  - Average CPU load over time (all processes). Render a time chart
  - Render a time chart for the app you used to overload the CPU

- Some useful PowerShell commands:

```powershell
#Get cpu consumption by process
(Get-Counter "\process(*)\% Processor Time").CounterSamples

#Convert objects to 
$json=$object | ConvertTo-Json
```

### Store temperature data for multiple cities

Collect data from OpenWeatherMap for three different cities each 30 seconds. Send the data to your Log Analytics workspace using Add-AzureMonitorData.ps1. Use PowerShell to automate this mission.

If data are visible in Log Analytics, build a custom dashboard using the View Designer within Log Analytics. Build:

- One overview tile showing the number of the different cities
- Two dashboards showing the temperature and humidity as a chart and as a list per city
- Connect PowerBi Dekstop to your data: Display Line Charts and use a selector/filter for the cities (drop down field)

Hints:

- Collect data from OpenWeatherMap

  - https://openweathermap.org/
  - Create an account and api key
  - Test your key (it can take some minutes):
     https://api.openweathermap.org/data/2.5/weather?q=Bonn&APIKEY=xxxxxxx

- Some useful PowerShell commands:

```powershell
#Endless-loop
do {   } while ($true)

#Sleep $n seconds
sleep $n

#make a http request
Invoke-WebRequest -Uri $uri -Method GET -ContentType "application/json"
```

### Build your own log-writer function

Build a log-writer function for your own PowerShell scripts using Log Analytics. There are some request to your solution:

- Have the following columns:
  - TimeStamp (as TimeGeneratedField)
  - Serverity (Debug|Information|Warning|Error)
  - Message (Text)
  - ScriptName (Name of the script using your function)