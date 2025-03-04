Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

Import-Module "$($PSScriptRoot)\Tools-DataBase\SpaceCluster-Database.psm1"
Import-Module "$($PSScriptRoot)\modules\SpaceCluster-LeftMenu.psm1"
Import-Module "$($PSScriptRoot)\modules\SpaceCluster-CommitContent.psm1"

$Role = 'root'

$Form               = [System.Windows.Forms.Form]::new()
$Form.Text          = 'Space Cluster'
$Form.WindowState   = 'Maximized'
$Form.StartPosition = 'CenterScreen'
$Form.BackColor     = [System.Drawing.Color]::White
$Form.KeyPreview    = $True
$Form.Add_KeyDown({
    Param($sender, $e)
    If ($E.KeyCode -eq [System.Windows.Forms.Keys]::Escape) {
        $Form.Close()
    }
})

SpaceClusterLeftMenu($Form)

$PanelDevoloper           = [System.Windows.Forms.Panel]::new()
$PanelDevoloper.BackColor = [System.Drawing.Color]::White
$PanelDevoloper.Location  = [System.Drawing.Point]::new(200,0)
$PanelDevoloper.Size      = [System.Drawing.Size]::new(1720,1010)

    $ButtonExplorerSpaceCluster            = [System.Windows.Forms.Button]::new()
    $ButtonExplorerSpaceCluster.Text       = 'Explorer Space Cluster'
    $ButtonExplorerSpaceCluster.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonExplorerSpaceCluster.Forecolor  = [System.Drawing.Color]::Black
    $ButtonExplorerSpaceCluster.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonExplorerSpaceCluster.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonExplorerSpaceCluster.Size       = [System.Drawing.Size]::new(225, 40)
    $ButtonExplorerSpaceCluster.Location   = [System.Drawing.Point]::new(135,35)
    $ButtonExplorerSpaceCluster.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetCodeContent 'Button' 'Explorer'))))
    $ButtonExplorerSpaceCluster.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonExplorerSpaceCluster.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonExplorerSpaceCluster.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)
    $ButtonExplorerSpaceCluster.Add_Click({
        Explorer $PSScriptRoot
    })
    $PanelDevoloper.Controls.Add($ButtonExplorerSpaceCluster)
 
    $ButtonBrowserDBSpaceCluster            = [System.Windows.Forms.Button]::new()
    $ButtonBrowserDBSpaceCluster.Text       = 'BrowserDB SpaceCluster'
    $ButtonBrowserDBSpaceCluster.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonBrowserDBSpaceCluster.Forecolor  = [System.Drawing.Color]::Black
    $ButtonBrowserDBSpaceCluster.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonBrowserDBSpaceCluster.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonBrowserDBSpaceCluster.Size       = [System.Drawing.Size]::new(225, 40)
    $ButtonBrowserDBSpaceCluster.Location   = [System.Drawing.Point]::new(135,80)
    $ButtonBrowserDBSpaceCluster.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetCodeContent 'Button' 'ConfigureDatabase'))))
    $ButtonBrowserDBSpaceCluster.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonBrowserDBSpaceCluster.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonBrowserDBSpaceCluster.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)
    $ButtonBrowserDBSpaceCluster.Add_Click({
        Start-Process "$(Split-Path -Path $PSScriptRoot)\SQL Browser\DB Browser for SQLite.exe" "$($PSScriptRoot)\SpaceCluster.db"
    })
    $PanelDevoloper.Controls.Add($ButtonBrowserDBSpaceCluster)
    
    $ButtonInsertContentRaw            = [System.Windows.Forms.Button]::new()
    $ButtonInsertContentRaw.Text       = 'Insert Content Raw'
    $ButtonInsertContentRaw.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonInsertContentRaw.Forecolor  = [System.Drawing.Color]::Black
    $ButtonInsertContentRaw.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonInsertContentRaw.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonInsertContentRaw.Size       = [System.Drawing.Size]::new(190, 40)
    $ButtonInsertContentRaw.Location   = [System.Drawing.Point]::new(535,35)
    $ButtonInsertContentRaw.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetCodeContent 'Button' 'InsertContentRaw'))))
    $ButtonInsertContentRaw.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonInsertContentRaw.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonInsertContentRaw.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)
    $ButtonInsertContentRaw.Add_Click({
        SpaceClusterCommitContent
    })
    $PanelDevoloper.Controls.Add($ButtonInsertContentRaw)

    $ButtonDeleteContentRaw            = [System.Windows.Forms.Button]::new()
    $ButtonDeleteContentRaw.Text       = 'Delete Content Raw'
    $ButtonDeleteContentRaw.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonDeleteContentRaw.Forecolor  = [System.Drawing.Color]::Black
    $ButtonDeleteContentRaw.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonDeleteContentRaw.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonDeleteContentRaw.Size       = [System.Drawing.Size]::new(190, 40)
    $ButtonDeleteContentRaw.Location   = [System.Drawing.Point]::new(535,80)
    $ButtonDeleteContentRaw.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetCodeContent 'Button' 'DeleteContentRaw'))))
    $ButtonDeleteContentRaw.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonDeleteContentRaw.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonDeleteContentRaw.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)
    $ButtonDeleteContentRaw.Add_Click({
        SpaceClusterDeleteContentRaw
    })
    $PanelDevoloper.Controls.Add($ButtonDeleteContentRaw)

$Form.Controls.Add($PanelDevoloper)
$Form.ShowDialog()