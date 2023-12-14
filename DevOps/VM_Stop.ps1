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


# 1. Stop VM
Stop-AzVM -ResourceGroupName $rgName -Name $vmName -Force