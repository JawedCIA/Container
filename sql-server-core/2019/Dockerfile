#escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Download SQL 2019 Express Online Installer
ARG DOWNLOAD_URL="https://go.microsoft.com/fwlink/?linkid=866658"

ENV sa_password="Pass@word!" `
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

# Download offline media of SQL 2019 Express Installer
RUN Invoke-WebRequest -Uri $env:DOWNLOAD_URL -OutFile sqlexpress2019.exe ; `
   Start-Process -Wait -FilePath .\sqlexpress2019.exe -ArgumentList /Action=Download, /HP, /Quiet, /ENU, /Language=en-US, /MediaPath=C:\installer ; `
   Remove-Item -Recurse -Force sqlexpress2019.exe ;
WORKDIR C:\installer
# Run Installation of SQL 2019 Express
RUN Start-Process -Wait -FilePath .\SQLEXPR_x64_ENU.exe -ArgumentList /qs, /x:setup ; `
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS ; `
    Remove-Item -Recurse -Force SQLEXPR_x64_ENU.exe, setup ;

# RUN Get-Service -name "*TELEMETRY*" | Stop-Service -passthru | Set-Service -startmode disabled;

RUN Stop-Service MSSQL`$SQLEXPRESS ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql15.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql15.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql15.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2 ;

COPY start.ps1 /
CMD .\start.ps1 -Verbose