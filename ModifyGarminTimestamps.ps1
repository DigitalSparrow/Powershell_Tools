[xml] $xml = Get-Content C:\Temp\activity_2790529943.tcx

$LastGoodTime = [datetime]"2018-06-20T07:22:58.000Z"

$FirstBadTime = [datetime]"2019-04-07T00:14:04.000Z"

$ts = New-TimeSpan -Start $LastGoodTime -End $FirstBadTime

$xml.TrainingCenterDatabase.Activities.Activity.Lap.Track.Trackpoint.ChildNodes| where {$_.name -eq "Time"} |% {

    $thisDate = [datetime]$_.'#text'

    $_.'#text' + " Subtract interval: " + $ts
    
    [string]$newDate = Get-Date -Format O $thisDate.Add(-$ts).AddHours(-1).ToString()

    if([datetime]$thisDate -gt $LastGoodTime){

        $newNodeValue = $newDate.Substring(0,23) + "Z"

        "Update needed: " + $newNodeValue

        $_.'#text' = $newNodeValue
       
    } else {
    "No update required!"
    }


}

$xml.Save("C:\Temp\NewActivityFile.xml");