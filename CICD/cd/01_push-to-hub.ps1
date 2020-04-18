$localregistry='registry.mddevops.local:5000'
$VERSION_NUMBER=$Env:BUILD_BuildNumber

Write-Output '*** Pushing images to Hub'

docker login --username $env:DOCKER_HUB_USER --password "$env:DOCKER_HUB_PASSWORD"

$images =   'sample:atseaapp-e2e-tests',
            'nunit:3.11.1-windowsservercore-ltsc2019',
            'sample:atseaapi',
            'sample:atseadb',
            'sqlserver:2019.express-core',
            'sample:registry-2.7.1'

foreach ($image in $images) {   
    $sourceTag = "$localregistry/mddevops/$image-$($VERSION_NUMBER)"
    $targetTag = "mddevops/$image-$(($VERSION_NUMBER))"
    
    docker image pull $sourceTag 
    docker image tag $sourceTag $targetTag
    docker image push $targetTag
}