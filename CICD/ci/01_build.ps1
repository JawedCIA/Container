
Write-Output '*** Building images'

cd ..\src

    #Build Database Image
    Write-Output '*** Building Database image mddevops/sample:atseadb'
    docker image build -t mddevops/sample:atseadb -f  .\docker\database\DockerFile  .
    # Buil Apps/api image
    Write-Output '*** Building API image as mddevops/sample:atseaapi'
    docker image build -t mddevops/sample:atseaapi -f  .\docker\api\DockerFile  .
Write-Host 'Image Building done!' 
