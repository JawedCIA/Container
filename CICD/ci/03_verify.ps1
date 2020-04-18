$AUT="http://atseaapp.mddevops.test"
Write-Output '*** Verifying - containers: '
docker container ls --filter  "label=ci"

Write-Output '*** Sleeping'
Start-Sleep -Seconds 40

Write-Output '*** Checking website'
$attempt = 3
$success = $false
while ($attempt -gt 0 -and -not $success) {
  try {
    Write-Output 'accessing Application under test for an attempt: ' $attempt 
    Invoke-WebRequest -UseBasicParsing $AUT
    $success = $true
  } catch {
    # remember error information
    $ErrorMessage = $_.Exception.Message
    Write-Output '** Failed in $($attempt) attempt with error message : ' $ErrorMessage
    Write-Output '============'
    Write-Output '** RETRYING.....'
    $attempt--
  }
}

