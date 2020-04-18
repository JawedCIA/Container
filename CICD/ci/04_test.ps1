Write-Output '*** Running end-to-end tests'

cd ..\src

$outFileFormate=Get-Date -Format "yyyy-MM-dd-HH-MM"

docker image build -t mddevops/sample:atseaapp-e2e-tests -f .\docker\e2e-tests\DockerFile .

$e2eId = docker container run -d  mddevops/sample:atseaapp-e2e-tests

Start-Sleep -Seconds 10

docker container cp "$($e2eId):C:\e2e-tests\TestResult.xml" .
docker container rm $e2eId -f

$testResult = [xml] (Get-Content .\TestResult.xml)
$results= $testResult.SelectNodes('./test-run/test-suite')

Write-Output '*** E2E test results:' 
$results

$result = $results.result
Write-Output "*** Overall: $result"

docker rm -f $(docker container ls --filter "label=ci" -q)

if ($result -eq 'Failed') 
{ 
    Write-Output "Test failed:..."
    Write-Output $testResult.InnerXml
    $testResult |ConvertTo-Html | Out-File C:\$outFileFormate-testresult.htm
    exit 1 

}