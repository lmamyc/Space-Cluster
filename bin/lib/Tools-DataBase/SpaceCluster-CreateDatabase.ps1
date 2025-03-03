Function SpaceClusterConnectionDataBase {
    Add-Type -Path "$($PSScriptRoot)\System.Data.SQLite.dll"
    $Connection = New-Object System.Data.SQLite.SQLiteConnection
    $Connection.ConnectionString = "Data Source=$(Split-Path $PSScriptRoot)\SpaceCluster.db;Version=3;"
    $Connection.Open()
    Return $Connection
}

Function CreateDataBase {
    
    Function CreateTableUser {
        $Connection = SpaceClusterConnectionDataBase
        $command = $Connection.CreateCommand()
        $command.CommandText = 'CREATE TABLE "Users" ("ID" INTEGER NOT NULL, "Name" TEXT NOT NULL UNIQUE, "Fullname" TEXT, PRIMARY KEY("ID" AUTOINCREMENT));'
        $command.ExecuteNonQuery()
        $Connection.Close()
    }
    CreateTableUser
    Function CreateTableContent {
        $Connection = SpaceClusterConnectionDataBase
        $command = $Connection.CreateCommand()
        $command.CommandText = 'CREATE TABLE "Content" ( "ID" INTEGER NOT NULL, "Object" TEXT, "Name" TEXT, "Content" TEXT, PRIMARY KEY("ID" AUTOINCREMENT));'
        $command.ExecuteNonQuery()
        $Connection.Close()
    }
    CreateTableContent
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
    CreateUser -Name $env:USERNAME -Fullname ''
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
    SpaceClusterAddContent -Object Button -Name Servers   -Content 'iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAtUlEQVR4nOWSsQ2DQBAEN6MFaImUYkjJ7Mg0AVWQfgOuwC7gU+KzLB2SJTj4u7MwyCutCHh+tCOAf04O4AmAVvrgc+bcuN4zq7lsrJg6ejQUAO6JoFlahYaKL7kKFSGjQkMmXcIRISkA+vj4/ayFbkKCoCAsQNS6pheNoKBZgJh1DYKC4Ve6SPsLW3SRFaLRRdwOQK+BaH5hsi6xQDrPkvJIS8gD8SyJ31hiyi6QmAiIHsi58wJMgiTMxHvr0QAAAABJRU5ErkJggg=='
    SpaceClusterAddContent -Object Button -Name Service   -Content 'iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABjklEQVR4nM2V3ypEURTGf+NPPATPorzADAnhBtM0ypAUc0GSW+NF3JFRSoq4GAz3rlxQkn8zRGRGu9ap1e6cmTl7jpqvVjN7r73WN/s76zsDLYw2YBg4AJKyNw5sA31RkrwBVeAJGAMeZV0C2ptt3iXfT6WpHUfN3iABfAHnQCWA5AfYBe6AAReSQ5+ml0AOKPrk9lxIRpX2HkGH5DqBK5UrA/M4IqkabVq5nMqZYXDCLPCqGhXlBt5NrlXuHhhxITnz0d1ItGURNDxpCXU4LntTcpOLgMky8Q0cA5/AoF/jNLAExICsKlwWj2TljMFNAMmO5Lv9TJlSs2+0fleFJTWiv0BGPs36AZgT/5j1bS15JmtIYEcGmBbiIalfl5GeESUCUWiA4CSg1shZ9yGvAR+WW3sk8mr/WZ6bqQkFv19smnvoDTjTeiRxYMWSKy/NTeyr/RdgVXknFGJ1TFaN4v9iMcQIT7iSpJUZC5Z0ZWXGihjXGSkxpcGGIlkQOc3oeq+VSGAk8Uj6o2z8L/gDp8nVLleLca4AAAAASUVORK5CYII='
    SpaceClusterAddContent -Object Button -Name Database  -Content 'iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABmElEQVR4nOXVv2pUQRgF8J/p1cRVUAP+KUQUFU2TNzFaKFqL2iroC6gPILHRYMRGxBSijX8bjQElPoGCuumipDEpVkZOYNm9F9blQgoPDMPMnDln7nzzfZd6HMJFzGIeS/iFTvqlzN8Pr/AHwiacxkLE/rUt4FR0KrEVz4cU7/S0Z9Hrw8OGDDppD6pMlhs2Wd6wL9mRu2zC4Cm2V5m8xB5M4cOQ4vPZvxevqkwKaQW3cRQHcQEzeIcf+Ble6b9nfia8wj+W/Svh9eF3z6k+YxrnMYkDaCUHWhlPZn06/O79Ra8PjxsO/KMqk1busQmDF9hWZXIXW3AWn4YU/4gzyfZ7dYH/hmvYjcO4lAL4Hu2eAtnO/HqBLPxxXI9OZeBXu060lqu7lYI3gf0YC3cs44msF97r7FvXKHp9mGs48E/qMv5tQwZv6jK+vPXNefeLQ4ov4lx07tQF/guuYCeO4HLXn7FdE/jZPJDC34Wr+DpIxq+mlt3ASRzHPoyGO5rxidSqm+Gv/T8ZXzDSUMaP/FUbAMNk/MbhD+ArhvqiMUlcAAAAAElFTkSuQmCC'
    SpaceClusterAddContent -Object Button -Name Users     -Content 'iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABj0lEQVR4nO3UT4iNURjH8Y9/2WBDLKRRStStWYitjSVNMmOUjSkLplnMRjbKVhSJkgVrU3Y2smVmMxZqMlIiZYNkXCNjwtVbz63T27mvcy01T/3qnN/pnO9z3vO8DyvxP8YWjOHsv2zehBGcw47w9uAe3uIZduMQ2ujgIXaWAobwKTZWmsNJ7MP3xP+FE3GLrveoBFBlu5RsSjWMqzXvY9x6OebV3jV/g1zpAehElgcz/na8i/GXkptMNUBeYVfN+4l1WIz5txLIpQbIYxzI+BvxOcb3SyC3GiBPMpCqKLZFEfzGYAkkrZS67uBYzTuMmzGeVxir8SIDWMZWTCfefDz6j6SyqiTXl4DOZCB3caTmPQ9wVdYLif8eE1jVBNmbgYzhRsZ/ilFsxrXaWtUtsrEWlzOHPYg+dRyzmfWX2I/zifcmd3j1mV43PPxXXMcATidv0dWHeKOL8StMpoANmGk4vK42juJUZm281ye63QegE1qMjnshsu6q1QuSdtx+NKGPmKxlU6pWP5CVUBJ/AGyV5YIACDngAAAAAElFTkSuQmCC'
    SpaceClusterAddContent -Object Button -Name Devoloper -Content 'iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAABbklEQVR4nMXUv0tXURjH8ZcSIklEkxQhrera1CQizg1BbUIUCW4hughKENQkOBkNQrg0KErgJi7RH2BEukWDmKKTPwiiGxeOcLndr+d8v98LPvCBe859nucNz4/DFVs3HmEJX7GPPzjEDj7iOW62CniCH8gSdIwpdKYm78DbxORZSavoSoFMtgjIghZigH78bhPyF/cvg7xvE5AFrTQC5LU8TUhwjoGIzxl6qiAPGgT8wkbh/CWU42Kq1hrEjVRBnlU45jsxjNeFu3lMhO8j3MFmRWw+QP/ZdIXjHIYC7OLuMT4UzlsBtFeK/YnrZchUIuQedhMguWbKkLGEch3gVhjTWLlyneBueUeqHA8Kjf+E0cK/vPHrkUlbLj8n3yMBi3jT5M58K5dsvKZlzMLL8Q59Zcg1bNcEeeUSG6oJMidin2uAzMYgdfTmRQwy2CbgBLdjkBttAh5KtGYSP8XL8Mj2pgKahbRs+WanKmr/ANJyewW6gRq4AAAAAElFTkSuQmCC'
    SpaceClusterAddContent -Object Button -Name Content   -Content 'iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA5klEQVR4nO3UwUoDMRSF4W/jygEZcSPdiAhjQXQhFRWlIhZaFC2KWKviSnz/N5CBK8xixMm06KI9EAI5SX7uPSEstfAqMMXjHMYUO3UdvUI+p1bn6P8GuWtZwU0KpDzQRuMUyHXLSoYpkFmVN4Hs4QEDrKGD1cre8/B72Ah/JRXyGvMTzvAZoRaVdfFUx+FfBqwx5ABvcfF3JR2sh98P0FGlknJkKZBZlTeBHOM+WrEdGWxW9o7wjAvsh5+lQt5jLi86xQdecFLj34Y/wW4KZCsyKUOv02E8ju4P/v9mUvzFL7zUAukLdK0v4lB6wNAAAAAASUVORK5CYII='
}

CreateDataBase