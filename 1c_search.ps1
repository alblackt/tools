$drives = Get-PSDrive -PSProvider 'FileSystem' # Get all drives list
$outputFileName = "$env:COMPUTERNAME.txt" # Create the name of a text file with search results

# search function
function FindFileOnDrive($driveLetter, $fileName) {
  $path = "$driveLetter`:/" # Create path for search
  $results = Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue | where { $_.Name -eq $fileName } # search file on disk
  if ($results) { # if file is found
    $results | ForEach-Object {
      Write-Output $_.FullName # Print path to file
      Add-Content $outputFileName $_.FullName # Write path to txt file
    }
  }
}

# search for files on each disk and print the search progress
$drives | ForEach-Object {
  $driveLetter = $_.Name
  Write-Output "Searching for files on drive $driveLetter..."
  FindFileOnDrive $driveLetter "1cv8.exe"
  FindFileOnDrive $driveLetter "1cv77.exe"
}

Write-Output "Search completed." 
