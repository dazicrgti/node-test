# Arguments from command line input

# Variables of source DB
$SourceDBUserName = testuser1
$SourceDBName     = testDB1
$BackUpFileName   = testdata.sql

# Variables of target DB
$TargetDBUserName = "azureadmin"
$TargetDBName     = "migration-mysql.mysql.database.azure.com"
$TargetDBIpAddress  = localhost

# export files from source MySQL
mysqldump -u $SourceDBUserName -p $SourceDBName > $BackUpFileName.sql

# import files into target MySQL
mysql -u $TargetDBUserName -p -h $TargetDBIpAddress $TargetDBName < $BackUpFileName.sql
