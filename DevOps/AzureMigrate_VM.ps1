$vmName = $args[0]

$projectName = "proj-migrate-dev-001"
$rgName = "rg-migrate-dev-001”

$replicatingServer = Get-AzMigrateServerReplication -ProjectName $projectName -ResourceGroupName $rgName -MachineName $vmName
$targetServer = Get-AzMigrateServerReplication -TargetObjectID $replicatingServer.Id

$NicMapping = @()
$Nics = (Get-AzMigrateServerReplication -TargetObjectID $replicatingServer.Id).ProviderSpecificDetail.VMNic
$i = 2

foreach ($Nic in $Nics) {
    if ($Nic.IsPrimaryNic -eq $true) {
        $NicMapping += New-AzMigrateNicMapping -NicId $Nic.NicId -TargetNicName "nic01-$vmName"
    }
    else {
        $NicMapping += New-AzMigrateNicMapping -NicId $Nic.NicId -TargetNicName "("nic" + $i.ToString("00"))-$vmName"
        $i++
    }
}

#$job = Set-AzMigrateServerReplication -InputObject $targetServer -NicToUpdate $NicMapping

$DiskMapping = @()
$i = 2
$Disks = (Get-AzMigrateServerReplication -TargetObjectID $replicatingServer.Id).ProviderSpecificDetail.ProtectedDisk
foreach ($Disk in $Disks) {
    if ($Disks.IsOSDisk -eq $true) {
        $OSDisk = Set-AzMigrateDiskMapping -DiskID $Disk.DiskId -DiskName "disk01-$vmName"
        $DiskMapping += $OSDisk
    }
    else {
        $dataDisk = Set-AzMigrateDiskMapping -DiskID $Disk.DiskId -DiskName "("disk" + $i.ToString("00"))-$vmName"
        $DiskMapping += $dataDisk
        $i++
    }
}

$job = Set-AzMigrateServerReplication -InputObject $targetServer -NicToUpdate $NicMapping -DiskToUpdate $DiskMapping

#$job = Set-AzMigrateServerReplication -InputObject $targetServer -TargetDiskName "disk01-$vmName" -NicToUpdate $NicMapping
Start-Sleep 5
Write-Host -ForegroundColor Cyan "Configuration Summary"
(Get-AzMigrateServerReplication -TargetObjectID $replicatingServer.Id).ProviderSpecificDetail.ProtectedDisk.TargetDiskName
(Get-AzMigrateServerReplication -TargetObjectID $replicatingServer.Id).ProviderSpecificDetail.VMNic[0].TargetNicName

