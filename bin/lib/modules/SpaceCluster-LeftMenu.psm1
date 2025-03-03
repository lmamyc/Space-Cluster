Function SpaceClusterLeftMenu($Form) {
    
    $PanelLeftMenu = [System.Windows.Forms.Panel]::new()
    $PanelLeftMenu.Dock = [System.Windows.Forms.DockStyle]::Left
    $PanelLeftMenu.BackColor = [System.Drawing.Color]::DarkGray
    $PanelLeftMenu.Width = 200
    $Form.Controls.Add($PanelLeftMenu)

    $ButtonServers = [System.Windows.Forms.Button]::new()
    $ButtonServers.Text = 'Сервера'
    $ButtonServers.BackColor = [System.Drawing.Color]::LightGray
    $ButtonServers.Forecolor = [System.Drawing.Color]::Black
    $ButtonServers.Font = [System.Drawing.Font]::new('Impact', 10)
    $ButtonServers.Cursor = [System.Windows.Forms.Cursors]::Hand
    $ButtonServers.Size = [System.Drawing.Size]::new(190, 40)
    $ButtonServers.Location = [System.Drawing.Point]::new(5, 100)
    $ButtonServers.Image = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetContent 'Button' 'Servers'))))
    $ButtonServers.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonServers.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonServers.Padding = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)

    $ButtonService = [System.Windows.Forms.Button]::new()
    $ButtonService.Text = 'Службы'
    $ButtonService.BackColor = [System.Drawing.Color]::LightGray
    $ButtonService.Forecolor = [System.Drawing.Color]::Black
    $ButtonService.Font = [System.Drawing.Font]::new('Impact', 10)
    $ButtonService.Cursor = [System.Windows.Forms.Cursors]::Hand
    $ButtonService.Size = [System.Drawing.Size]::new(190, 40)
    $ButtonService.Location = [System.Drawing.Point]::new(5, 150)
    $ButtonService.Image = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetContent 'Button' 'Service'))))
    $ButtonService.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonService.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonService.Padding = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)

    $ButtonUsers            = [System.Windows.Forms.Button]::new()
    $ButtonUsers.Text       = 'Пользователи'
    $ButtonUsers.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonUsers.Forecolor  = [System.Drawing.Color]::Black
    $ButtonUsers.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonUsers.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonUsers.Size       = [System.Drawing.Size]::new(190, 40)
    $ButtonUsers.Location   = [System.Drawing.Point]::new(5, 200)
    $ButtonUsers.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetContent 'Button' 'Users'))))
    $ButtonUsers.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonUsers.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonUsers.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)

    $ButtonDataBase            = [System.Windows.Forms.Button]::new()
    $ButtonDataBase.Text       = 'База данных'
    $ButtonDataBase.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonDataBase.Forecolor  = [System.Drawing.Color]::Black
    $ButtonDataBase.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonDataBase.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonDataBase.Size       = [System.Drawing.Size]::new(190, 40)
    $ButtonDataBase.Location   = [System.Drawing.Point]::new(5, 750)
    $ButtonDataBase.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetContent 'Button' 'Database'))))
    $ButtonDataBase.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonDataBase.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonDataBase.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)

    $ButtonDevoloper            = [System.Windows.Forms.Button]::new()
    $ButtonDevoloper.Text       = 'Разработчик'
    $ButtonDevoloper.BackColor  = [System.Drawing.Color]::LightGray
    $ButtonDevoloper.Forecolor  = [System.Drawing.Color]::Black
    $ButtonDevoloper.Font       = [System.Drawing.Font]::new('Impact', 10)
    $ButtonDevoloper.Cursor     = [System.Windows.Forms.Cursors]::Hand
    $ButtonDevoloper.Size       = [System.Drawing.Size]::new(190, 40)
    $ButtonDevoloper.Location   = [System.Drawing.Point]::new(5, 800)
    $ButtonDevoloper.Image      = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.Convert]::FromBase64String($(SpaceClusterSelectGetContent 'Button' 'Devoloper'))))
    $ButtonDevoloper.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $ButtonDevoloper.TextAlign  = [System.Drawing.ContentAlignment]::MiddleCenter
    $ButtonDevoloper.Padding    = [System.Windows.Forms.Padding]::new(10, 0, 0, 0)

    If($Role -eq 'Root'){
        $PanelLeftMenu.Controls.Add($ButtonServers)
        $PanelLeftMenu.Controls.Add($ButtonService)
        $PanelLeftMenu.Controls.Add($ButtonUsers)
        $PanelLeftMenu.Controls.Add($ButtonDataBase)
        $PanelLeftMenu.Controls.Add($ButtonDevoloper)
    }
    ElseIf($Role -eq 'Administrator'){
        $PanelLeftMenu.Controls.Add($ButtonServers)
        $PanelLeftMenu.Controls.Add($ButtonService)
        $PanelLeftMenu.Controls.Add($ButtonUsers)
        
    }
    Else{
    }
}