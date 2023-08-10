# Note: the below command will change the execution polciy temporarily for one session only:
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process


# List of Apps to search for
$apps = (

#'MicrosoftTeams',
'Microsoft.GetHelp', 
'Microsoft.WindowsMaps', 
'Microsoft.WindowsCamera', 
'Microsoft.Getstarted', 
'Microsoft.People',
#'Microsoft.XboxGameOverlay',

'')

# Create an array to hold unsuccessful attempts
$notFound = @()

# Create an array to hold the list
$list = @()

# Process each line
foreach ($line in $apps) {
    # Trim any leading or trailing white space
    $line = $line.Trim()

    # Ignore empty lines and Get the package, if it exists

    if ( (-not [string]::IsNullOrWhiteSpace($line)) -and ($package = Get-AppxPackage | Where-Object { $_.Name -eq $line -or $_.PackageFullName -eq $line }) ) {
    
        # Adds the packages to the list
		$list += $package
        } 
        
        else {
         # Adds the packages to the notFound list if lenght is > 1
            if ($line.length -gt 1) {
                # Adds the packages to the list
		        $notFound += $line
                }      
        }
    }


# Display AppX packages that are installed
Write-Host 'All packages installed:'
Get-AppxPackage | Select Name, PackageFullName | Out-Host


# Lists the packages that are not found
Write-Host 'Following packages not found:'
Write-Host ($notFound -join "`n")


# Create GUI list to remove-AppxPackage
$list | Out-GridView -PassThru | Remove-AppxPackage
