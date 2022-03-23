$MainPath = <Replace with main folder>
$LockerPath = $MainPath + "\<Replace with folder name"
$LockedPath = $MainPath + "\<Replace with zipped file name, or what you want the zipped file to be"
$TestLocker = Test-Path $LockerPath
$TestLocked = Test-Path $LockedPath

while (1)
{
    $Function = Read-Host 'Locking or Unlocking?'

	if ( $Function -eq "Locking" -Or $Function -eq "Lock")
	{
		if ( -Not $TestLocker ) 
		{
			Write-Host "Locker folder doesn't exist."
			continue
		}

		$SecureString = Read-Host 'Enter a password to lock the folder with' -AsSecureString
		Compress-7zip -Path $LockerPath -ArchiveFileName "Locked.zip" -Format Zip -SecurePassword $SecureString
		
		if ( $? ) 
		{
			Remove-Item -Path $LockerPath -Recurse
		}
	} 
	elseif ( $Function -eq "Unlocking" -Or $Function -eq "Unlock") 
	{	
		
		if ( -Not $TestLocked ) 
		{
			Write-Host "Zip folder doesn't exist."
			continue
		}

		$SecureString = Read-Host 'Enter the password to extract the folder' -AsSecureString

		if ( -Not $TestLocker )
		{
			New-Item -Path $MainPath -ItemType "directory" -Name "Locker"
		}

		Expand-7Zip -TargetPath $LockerPath -ArchiveFileName "Locked.zip" -SecurePassword $SecureString
		
		if ( $? ) 
		{
			Remove-Item -Path $LockedPath
		}
        else
        {
            Remove-Item -Path $LockerPat
        }
	}
	else
	{
		Write-Host "Option doesn't exist."
		continue
	}
	Exit
}
