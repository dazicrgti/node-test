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

# 1. Start VM
Start-AzVM -ResourceGroupName $rgName -Name $vmName