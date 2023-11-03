# Import the .NET Data SQL Client namespace
Add-Type -AssemblyName "System.Data"

# Define connection string
$connectionString = "Server=localhost;User Id=SA;Password=P@ssw0rd;"

# Create a new SQL connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString


# Initialize retry variables
$maxRetries = 45
$retryInterval = 1 # in seconds

# Try to connect
for ($i = 0; $i -lt $maxRetries; $i++) {
    try {
        $connection.Open()
        Write-Host "Successfully connected to SQL Server."
        $connection.Close()
        break
    } catch {
        Write-Host "Waiting for SQL Server..."
        Start-Sleep -Seconds $retryInterval
    }
}

Write-Host "Executing PrepareServer.sql"

# Open the SQL connection
$connection.Open()

# Build the path to the SQL file located in the same directory as the script
$sqlFilePath = Join-Path -Path $PSScriptRoot -ChildPath "PrepareServer.sql"

# Read the SQL file into an array of strings, one per line
$sqlFileLines = Get-Content -Path $sqlFilePath

# Join the lines into a single string
$sqlFileContent = $sqlFileLines -join "`r`n"

# Split the SQL commands into batches
$sqlBatches = $sqlFileContent -split '\bGO\b'

# Initialize SQL command object
$command = $connection.CreateCommand()

foreach ($batch in $sqlBatches) {
    # Skip empty batches
    if (-not [string]::IsNullOrWhiteSpace($batch)) {
        $command.CommandText = $batch
        $command.ExecuteNonQuery()
    }
}

# Close the SQL connection
$connection.Close()

Write-Host "Finished executing PrepareServer.sql"