### Migrate Schemas and Datas ###

# Variables
    $sourceServerName = "localhost" # name or ip
    $sourceDBName = "sakila"
    $sourceUser = "root"
    # $sourcePass = ConvertTo-SecureString "<password>" -AsPlainText -Force #convert the passwords to secure strings.
    $DumpFilePath = "C:\Users\azure-admin\Desktop\dump.sql"

    $targetServerName = "msql-azuresql-migration.database.windows.net" # name or ip
    $targetDBName = "migration-mysql"
    $targetUser = "azure-admin"
    $targetPass = ConvertTo-SecureString "GTICTUpassw0rd2023!" -AsPlainText -Force #convert the passwords to secure strings.

# Export from source
    mysqldump -h $sourceServerName -u $sourceUser -p $sourceDBName  --result-file=$DumpFilePath

# Import to target
    # Call cmd to run Unix like command.
    # cmd.exe /c "mysql.exe -h [servername] -u [username] -p[password] [database] < [schema file path]"
    $CommandString = "mysql.exe -h $targetServerName -u $targetUser -p $targetDBName < $DumpFilePath"
    cmd.exe /c $CommandString
