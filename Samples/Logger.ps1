Class Logging
{
    [DateTime]$TimeStamp
    [string]$Serverity 
    [string]$ScriptName
    [String]$Message 
        
    Logging() {
    }
    Logging([ServerityEnum]$serverity,[String]$message) {
        $this.Serverity=$Serverity
        $this.Message=$message
    }
    SendData([string] $WorpspaceId, $WorpspaceKey) {
        #send data to Log Analytics
        $this.TimeStamp=(Get-Date).ToUniversalTime()
        $this.ScriptName=$MyInvocation.MyCommand.Name
        ..\Tools\Add-AzureMonitorData.ps1 -WorpspaceId $WorpspaceId -WorpspaceKey $WorpspaceKey -LogTypeName "PowerShellLogger" -TimeStampField "TimeStamp" -JsonData ($this|ConvertTo-Json)
    }
}

Enum ServerityEnum
{
    Debug;
    Information;
    Warning;
    Error;
}


#How to use
#Initiate a instance of the class
$logging=New-Object Logging
$logging.Serverity=[ServerityEnum]::Warning
$logging.Message="Forecasted temperatur could harm your tomatos"
$logging.SendData($WorpspaceId,$WorpspaceKey);


#Another way to initiate a instance of the class
$logging2=[Logging]::new([ServerityEnum]::Error,"It's to coold.....")
$logging2.SendData($WorpspaceId,$WorpspaceKey);




    