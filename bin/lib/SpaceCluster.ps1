Add-Type -AssemblyName System.Windows.Forms

Import-Module "$($PSScriptRoot)\Tools-DataBase\SpaceCluster-Database.psm1"
Import-Module "$($PSScriptRoot)\modules\SpaceCluster-LeftMenu.psm1"

$Role = 'Administrator'

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

Function SpaceHelperAddContentDataBase {
    $FormAddContentDataBase = [System.Windows.Forms.Form]::new()
    $FormAddContentDataBase.Controls.Add($FormAddContentDataBase)
}

$PanelDevoloper           = [System.Windows.Forms.Panel]::new()
$PanelDevoloper.BackColor = [System.Drawing.Color]::White
$PanelDevoloper.Location  = [System.Drawing.Point]::new(200,0)
$PanelDevoloper.Size      = [System.Drawing.Size]::new(1720,1010)
    
    $ButtonAddContent            = [System.Windows.Forms.Button]::new()
    $ButtonAddContent.Text       = 'Add content'
    $ButtonAddContent.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonAddContent.Forecolor  = [System.Drawing.Color]::Black
    $ButtonAddContent.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonAddContent.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonAddContent.Size       = [System.Drawing.Size]::new(190, 40)
    $ButtonAddContent.Location   = [System.Drawing.Point]::new(35,35)
    $ButtonAddContent.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetContent 'Button' 'Content'))))
    $ButtonAddContent.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonAddContent.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonAddContent.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)
    $ButtonAddContent.
    SpaceHelperAddContentDataBase
    $PanelDevoloper.Controls.Add($ButtonAddContent)

$Form.Controls.Add($PanelDevoloper)

$Form.ShowDialog()