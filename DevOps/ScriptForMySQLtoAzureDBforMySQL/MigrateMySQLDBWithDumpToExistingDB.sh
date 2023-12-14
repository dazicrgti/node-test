### Migrate Schemas and Datas ###

# Variables
    sourceServerName="localhost" # name or ip
    sourceDBName="sql_tutorial"
    sourceUser="root"
    # sourcePass = ConvertTo-SecureString "<password>" -AsPlainText -Force #convert the passwords to secure strings.
    DumpFilePath="D:\Working_Area\MigrationLab\MySQLtoAzureDBforMySQL\MySqlDump.sql"

    targetServerName="mysqlsv-kevin-migratetest-001.mysql.database.azure.com" # name or ip
    targetDBName="mysqldb-kevin-migratetest-001"
    targetUser="azureadmin"
    # $targetPass = ConvertTo-SecureString "<password>" -AsPlainText -Force #convert the passwords to secure strings.

# Export from source
    mysqldump -h $sourceServerName -u $sourceUser -p $sourceDBName > $DumpFilePath

# Import to targe
    # Call cmd to run Unix like command.
    # cmd.exe /c "mysql.exe -h [servername] -u [username] -p[password] [database] < [schema file path]"
    mysql.exe -h $targetServerName -u $targetUser -p $targetDBName < $DumpFilePath
