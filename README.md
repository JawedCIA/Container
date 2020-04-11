# Container
Working with Docker &amp; 
Collection of various windows container with example

# SQL Express 2019 build on top of Windows core 2019
Run as container directly </br>
```
docker container run -d `
-p 1433:1433 `
--restart always `
--name sqlexpress2019 `
-e sa_password=md!eV0p) `
mddevops/sqlserver:2019.express-core
```
