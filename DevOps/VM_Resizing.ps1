# ====================================
# Pre-requisite
# ====================================
# Import Module from Module Gallery:
# 	Az.Accounts
# 	Az.Compute
# ====================================

# Parameters
$rgName="rg-advspec-migration-lab"
$vmName="migration-resize"
$newSize="Standard_B1s"

# 1. Stop VM
Stop-AzVM -ResourceGroupName $rgName -Name $vmName -Force

# 2. Resize VM
$vm = Get-AzVM -ResourceGroupName $rgName -VMName $vmName
$vm.HardwareProfile.VmSize = $newSize
Update-AzVM -VM $vm -ResourceGroupName $rgName

# 3. Start VM
Start-AzVM -ResourceGroupName $rgName -Name $vmName