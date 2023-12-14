# Prerequisites should be confirmed before running this script.
# https://github.com/Azure-Samples/data-migration-sql/blob/main//PowerShell/sql-server-to-sql-db.md

# Set Variables
$tenantId = "5a6ed698-c192-4cab-93a6-295abe49d551"
$subscription = "466e87b7-00d3-4bec-9e73-539a2182e691"
$RG = "rg-advspec-migration-lab"
$location = "EastAsia"
$DMSName = "MigrationServiceMSSQLtoAzureSQLDB"

$targetServerInstanceName = "advspec-sql-server"
$targetServerResourceID = "/subscriptions/466e87b7-00d3-4bec-9e73-539a2182e691/resourceGroups/rg-advspec-migration-lab/providers/Microsoft.Sql/servers/advspec-sql-server"

$targetServerName = "advspec-sql-server.database.windows.net" # name or ip
$targetDBName = "advspec-sql"
$targetAuthType = "SQLAuthentication" # SqlAuthentication or WindowsAuthentication
$targetUser = "azure-admin"
$targetPass = ConvertTo-SecureString "GTICTUpassw0rd2023!" -AsPlainText -Force #convert the passwords to secure strings.

$sourceServerName = "localhost\SQLEXPRESS" # name or ip
$sourceDBName = "SRMS-Copy-ready"
$sourceAuthType = "WindowsAuthentication" # SqlAuthentication or WindowsAuthentication
$sourceUser = "migration-lab-v\azure-admin"
$sourcePass = ConvertTo-SecureString "GTICTUpassw0rd2023!" -AsPlainText -Force #convert the passwords to secure strings.


# Azure login with PS
Connect-AzAccount -Subscription $subscription -TenantId $tenantId

    # switch subscriptions in the same tenant:
    #Set-AzContext -Subscription $subscription
    # check login status:
    #Get-AzContext

# Create Resource Group
New-AzResourceGroup -ResourceGroupName $RG -Location $location

# Create an instance of Database Migration Service
New-AzDataMigrationSqlService -ResourceGroupName $RG -Name $DMSName -Location $location
$DMSResource = Get-AzDataMigrationSqlService -ResourceGroupName $RG -Name $DMSName

# Register Database Migration Service with self-hosted Integration Runtime (IR)
 $authKeys = Get-AzDataMigrationSqlServiceAuthKey -ResourceGroupName $RG -SqlMigrationServiceName $DMSName

# Register-AzDataMigrationIntegrationRuntime -AuthKey $authKeys.AuthKey1
    # If use .MSI IR without installed, use this cmdlet instead:
#Register-AzDataMigrationIntegrationRuntime -AuthKey $authKeys.AuthKey1 -IntegrationRuntimePath "C:\Users\azure-admin\Downloads\IntegrationRuntime_5.29.8535.1.msi"



# Start Database Migration (with all data)
New-AzDataMigrationToSqlDb `
-ResourceGroupName $RG `
-SqlDbInstanceName $targetServerInstanceName `
-Kind "SqlDb" `
-TargetDbName $targetDBName `
-SourceDatabaseName $sourceDBName `
-SourceSqlConnectionAuthentication $sourceAuthType `
-SourceSqlConnectionDataSource $sourceServerName `
-SourceSqlConnectionUserName $sourceUser `
-SourceSqlConnectionPassword $sourcePass `
-Scope $targetServerResourceID `
-TargetSqlConnectionAuthentication $targetAuthType `
-TargetSqlConnectionDataSource $targetServerName `
-TargetSqlConnectionUserName $targetUser `
-TargetSqlConnectionPassword $targetPass `
-MigrationService $DMSResource.Id

    # Start Database Migration (with selected tables). Add following statement to the cmdlet:
   # -TableList "[dbo].[Attachment]", "[dbo].[Ticket]" `

# To monitor the migration, check the status of task.

    # Get data from Azure
    $migDetails = Get-AzDataMigrationToSqlDb -ResourceGroupName $RG -SqlDbInstanceName $targetServerInstanceName -TargetDbName $targetDBName -Expand MigrationStatusDetails

    # ProvisioningState should be Creating, Failed or Succeeded
    $migDetails.ProvisioningState | Format-List

    # MigrationStatus should be InProgress, Canceling, Failed or Succeeded
    $migDetails.MigrationStatus | Format-List

    # To view migration details at each backup file level
    $migDetails.MigrationStatusDetail | select *

# Delete Database Migration Service Instance
#Remove-AzDataMigrationSqlService -ResourceGroupName $RG -Name $DMSName