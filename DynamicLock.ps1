while (1)
{
    $Function = Read-Host 'Locking or Unlocking?'

	if ( $Function -eq "Locking" -Or $Function -eq "Lock")
	{
        $LockerPath = Read-Host "Enter the absolute or relative path of the folder you wish to encrypt"
        $LockedName = Read-Host "Enter the desired name of the zip file output"

		$SecureString = Read-Host 'Enter a password to lock the folder with' -AsSecureString
		Compress-7zip -Path $LockerPath -ArchiveFileName $LockedName -Format Zip -SecurePassword $SecureString
		
		if ( $? ) 
		{
			Remove-Item -Path $LockerPath -Recurse
		}
	} 
	elseif ( $Function -eq "Unlocking" -Or $Function -eq "Unlock") 
	{	
        $LockedName = Read-Host "Enter the absolute or relative path of the zip file you wish to decrypt"
        $LockerName = Read-Host "Enter the desired name of the output folder"

		$SecureString = Read-Host 'Enter the password to extract the folder' -AsSecureString

        $TestLocker = Test-Path $LockerName

		if ( -Not $TestLocker )
		{
			New-Item -Path . -ItemType "directory" -Name $LockerName
		}

		Expand-7Zip -TargetPath $LockerName -ArchiveFileName $LockedName -SecurePassword $SecureString
		
		if ( $? ) 
		{
			Remove-Item -Path $LockedName
		}
	}
	else
	{
		Write-Host "Option doesn't exist."
		continue
	}
	Exit
}