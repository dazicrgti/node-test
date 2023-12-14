### Migrate Schemas and Datas ###

# Variables
$sourceServerName = "localhost" # name or ip
$sourceDBName = "classicmodels"
$sourceUser = "root"
# $sourcePass = ConvertTo-SecureString "GTICTUpassw0rd2023!" -AsPlainText -Force #convert the passwords to secure strings.
$DumpFilePath = "C:\Users\azure-admin\Desktop\dump.sql"

$targetServerName = "migration-mysql.mysql.database.azure.com" # name or ip
$targetUser = "azureadmin"
$targetPass = ConvertTo-SecureString "GTICTUpassw0rd2023!" -AsPlainText -Force #convert the passwords to secure strings.

# Export from source
mysqldump -h $sourceServerName -u $sourceUser -p --databases $sourceDBName --result-file=$DumpFilePath

# Import to targe
# Call cmd to run Unix like command.
$CommandString = "mysql.exe -h $targetServerName -u $targetUser -p < $DumpFilePath"
cmd.exe /c $CommandString
