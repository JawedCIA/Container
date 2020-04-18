Write-Output '*** Running application containers'
Write-Output '*** Removing all Running application CI containers'

try
{
  docker container rm -f $(docker container ls --filter "label=ci" -q)
}
catch
{ 
  Write-Host "An error occurred while removing container:"
  Write-Host $_  
}
write-host ' creating atseadb container'

docker container run -d `
 --label ci `
 --name atseadb `
  mddevops/sample:atseadb;

write-host 'Creating atseaapp container'

docker container run -d `
 --label ci `
 --name atseaapp.mddevops.test `
 --restart always `
 -l "traefik.frontend.rule=Host:atseaapp.mddevops.test;PathPrefix:/" `
 -l "traefik.frontend.priority=1" `
 --label "traefik.port=80" `
 --label "traefik.backend.loadbalancer.stickiness=true" `
 mddevops/sample:atseaapi;
 
 write-host 'Creating traefik as proxy/loadbalancer container'
docker container run -d -p 80:80 -p 8080:8080 `
 --label ci `
 --name mddevops-test `
 -v \\.\pipe\docker_engine:\\.\pipe\docker_engine `
 sixeyed/traefik:v1.7.8-windowsservercore-ltsc2019 `
 --docker --docker.endpoint=npipe:////./pipe/docker_engine --logLevel=DEBUG --api
 