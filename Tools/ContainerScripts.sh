docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest 

pwsh -c 'Invoke-Sqlcmd -Query "SELECT @@VERSION;" -QueryTimeout 3 -Username "SA" -Password "P@ssw0rd"'

docker rm --force dad596acd836f8b71d4ec9f3e8f87cfe48e345e552c46204aaec8eaa392b78c5