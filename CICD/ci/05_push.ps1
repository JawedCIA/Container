$localregistry='registry.mddevops.local:5000'
$BUILD_TAG= $Env:BUILD_BuildNumber#$(Build.BuildNumber)

Write-Output '*** Pushing images'

$images =   'sample:atseaapp-e2e-tests',
            'nunit:3.11.1-windowsservercore-ltsc2019',
            'sample:atseaapi',
            'sample:atseadb',
            'sqlserver:2019.express-core',
            'sample:registry-2.7.1'
# -$($env:BUILD_TAG)
foreach ($image in $images) {
    $sourceTag = "mddevops/$image"
    $targetTag = "$localregistry/mddevops/$image-$BUILD_TAG"
    "=================\n"
    "Source Tag: $sourceTag \n" 
    "Target Tag: $targetTag \n"
    docker image tag $sourceTag $targetTag
    docker image push $targetTag
    "=================\n"
}