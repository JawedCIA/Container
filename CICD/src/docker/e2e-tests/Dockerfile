# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src\E2E.Tests.mddevops.dotnet
COPY dotnet\Docker.AtSea\E2E.Tests.mddevops.dotnet\E2E.Tests.mddevops.dotnet\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY dotnet\Docker.AtSea\E2E.Tests.mddevops.dotnet\E2E.Tests.mddevops.dotnet\ .
RUN msbuild E2E.Tests.mddevops.dotnet.csproj /p:OutputPath=C:\e2e-tests

# test runner
FROM mddevops/nunit:3.11.1-windowsservercore-ltsc2019

WORKDIR /e2e-tests
CMD nunit3-console E2E.Tests.mddevops.dotnet.dll

COPY --from=builder C:\e2e-tests .