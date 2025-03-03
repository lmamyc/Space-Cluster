Function SpaceClusterConnectionDataBase {
    Add-Type -Path "$($PSScriptRoot)\System.Data.SQLite.dll"
    $Connection = New-Object System.Data.SQLite.SQLiteConnection
    $Connection.ConnectionString = "Data Source=$(Split-Path -Path $PSScriptRoot)\SpaceCluster.db;Version=3;"
    $Connection.Open()
    Return $Connection
}
Function CreateUser {
    Param([string]$Name,[string]$Fullname)
    $Connection = SpaceClusterConnectionDataBase
    $command = $Connection.CreateCommand()
    $command.CommandText = "INSERT INTO Users (Name, Fullname) VALUES (@Name, @Fullname);"
    $command.Parameters.AddWithValue("@Name",$Name) | Out-Null
    $command.Parameters.AddWithValue("@Fullname",$Fullname) | Out-Null
    $command.ExecuteNonQuery()
    $Connection.Close()
}
Function CreateGroup {
    Param([string]$Name)
    $Connection = SpaceClusterConnectionDataBase
    $command = $Connection.CreateCommand()
    $command.CommandText = "INSERT INTO groups (name) VALUES (@name);"
    $command.Parameters.AddWithValue("@name", $Name) | Out-Null
    $command.ExecuteNonQuery()
    $Connection.Close()
}
Function SpaceClusterAddContent {
    Param([string]$Object,[string]$Name,[string]$Content)
    $Connection = SpaceClusterConnectionDataBase
    $Command = $Connection.CreateCommand()
    $Command.CommandText = "INSERT INTO Content (Object, Name, Content) VALUES (@Object, @Name, @Content);"
        $Command.Parameters.AddWithValue("@Object",$Object) | Out-Null
        $Command.Parameters.AddWithValue("@Name",$Name) | Out-Null
        $Command.Parameters.AddWithValue("@Content",$Content) | Out-Null
    $Command.ExecuteNonQuery()
    $Connection.Close()
}
Function SpaceClusterSelectGetContent {
    Param([string]$Object,[string]$Name)
    $Connection = SpaceClusterConnectionDataBase
    $Command = $Connection.CreateCommand()
    $Command.CommandText = "SELECT Content FROM Content WHERE Object = @Object AND Name = @Name"
        $Command.Parameters.AddWithValue("@Object", $Object) | Out-Null
        $Command.Parameters.AddWithValue("@Name", $Name) | Out-Null
    $Reader = $Command.ExecuteReader()
    $ImageHashtable = @{}
    while ($reader.Read()) {
        $Content = $reader.GetValue(0)
        Return $Content
    }
    $Reader.Close()
    $Connection.Close()
}
Function SpaceClusterSelectDataBaseUser {
    Param(
        [string]$User
    )
    $Connection = SpaceClusterConnectionDataBase
    $Command = $Connection.CreateCommand()
    $Command.CommandText = "SELECT * FROM Users WHERE Name = @Name"
    $Command.Parameters.AddWithValue("@Name", $User) | Out-Null
    $Reader = $command.ExecuteReader()
    $UserHashtable = @{}
    while ($reader.Read()) {
        $userId = $reader.GetValue(0)
        $userName = $reader.GetValue(1)
        $userFullName = $reader.GetValue(2)
        $userGroup = $reader.GetValue(3)
        $UserHashtable["ID"] = $userId
        $UserHashtable["Name"] = $userName
        $UserHashtable["FullName"] = $userFullName
        $UserHashtable["Group"] = $userGroup
    }
    $Reader.Close()
    $Connection.Close()
    Return $UserHashtable
}
Function SpaceClusterSelectDataBaseImage {
    Param(
        [string]$Name
    )
    $Connection = SpaceClusterConnectionDataBase
    $Command = $Connection.CreateCommand()
    $Command.CommandText = "SELECT * FROM Images WHERE Name = @Name"
    $Command.Parameters.AddWithValue("@Name", $Name) | Out-Null
    $Reader = $Command.ExecuteReader()
    $ImageHashtable = @{}
    while ($reader.Read()) {
        $ImageId = $reader.GetValue(0)
        $ImageName = $reader.GetValue(1)
        $ImageCode = $reader.GetValue(2)
        $ImageHashtable["ID"] = $ImageId
        $ImageHashtable["Name"] = $ImageName
        $ImageHashtable["Code"] = $ImageCode
    }
    $Reader.Close()
    $Connection.Close()
    Return $ImageHashtable
}
Function SpaceClusterViewImageTable {
    Param(
        [string]$Name
    )
    $Connection = SpaceClusterConnectionDataBase
    $Command = $Connection.CreateCommand()
    $Command.CommandText = "SELECT * FROM Images"
    $Reader = $Command.ExecuteReader()
    $ImageArray = @()

    While ($Reader.Read()) {
        $ImageId = $Reader.GetValue(0)
        $ImageName = $Reader.GetValue(1)
        $ImageCode = $Reader.GetValue(2)
        $ImageObject = [PSCustomObject]@{
            ID = $ImageId
            Name = $ImageName
            Code = $ImageCode
        }
        $ImageArray += $ImageObject
    }
    $Reader.Close()
    $Connection.Close()
    $ImageArray | Out-GridView -Title 'Table images'
}