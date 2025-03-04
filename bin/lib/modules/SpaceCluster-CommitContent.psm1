Function SpaceClusterCommitContent {

    $FormAddContentDataBase = [System.Windows.Forms.Form]::new()
    $FormAddContentDataBase.StartPosition = 'CenterScreen'
    $FormAddContentDataBase.FormBorderStyle = "FixedToolWindow"
    $FormAddContentDataBase.Size = "400,400"

    $LabelObject = [System.Windows.Forms.Label]::new()
    $LabelObject.Text = 'Object'
    $LabelObject.Font = [System.Drawing.Font]::new('Impact', 10)
    $LabelObject.AutoSize = $true
    $LabelObject.Location = [System.Drawing.Point]::new(55,20)
    $FormAddContentDataBase.Controls.Add($LabelObject)

    $LabelName = [System.Windows.Forms.Label]::new()
    $LabelName.Text = 'Name'
    $LabelName.Font = [System.Drawing.Font]::new('Impact', 10)
    $LabelName.AutoSize = $true
    $LabelName.Location = [System.Drawing.Point]::new(60,50)
    $FormAddContentDataBase.Controls.Add($LabelName)

    $LabelContent = [System.Windows.Forms.Label]::new()
    $LabelContent.Text = 'Content'
    $LabelContent.Font = [System.Drawing.Font]::new('Impact', 10)
    $LabelContent.AutoSize = $true
    $LabelContent.Location = [System.Drawing.Point]::new(25,80)
    $FormAddContentDataBase.Controls.Add($LabelContent)

    $TextBoxObject = [System.Windows.Forms.TextBox]::new()
    $TextBoxObject.Font = [System.Drawing.Font]::new('Arial', 10)
    $TextBoxObject.AutoSize = $true
    $TextBoxObject.Size = "200,0"
    $TextBoxObject.Location = [System.Drawing.Point]::new(100,17)
    $FormAddContentDataBase.Controls.Add($TextBoxObject)

    $TextBoxName = [System.Windows.Forms.TextBox]::new()
    $TextBoxName.Font = [System.Drawing.Font]::new('Arial', 10)
    $TextBoxName.AutoSize = $true
    $TextBoxName.Size = "200,0"
    $TextBoxName.Location = [System.Drawing.Point]::new(100,47)
    $FormAddContentDataBase.Controls.Add($TextBoxName)

    $TextBoxContent = [System.Windows.Forms.TextBox]::new()
    $TextBoxContent.Font = [System.Drawing.Font]::new('Arial', 10)
    $TextBoxContent.AutoSize = $false
    $TextBoxContent.Size = "340,200"
    $TextBoxContent.Location = [System.Drawing.Point]::new(25,105)
    $TextBoxContent.Multiline = $true
    $FormAddContentDataBase.Controls.Add($TextBoxContent)

    $ButtonCommitContent = [System.Windows.Forms.Button]::new()
    $ButtonCommitContent.Text = 'Commit'
    $ButtonCommitContent.BackColor = [System.Drawing.Color]::LightGray
    $ButtonCommitContent.Forecolor = [System.Drawing.Color]::Black
    $ButtonCommitContent.Font = [System.Drawing.Font]::new('Impact', 10)
    $ButtonCommitContent.Cursor = [System.Windows.Forms.Cursors]::Hand
    $ButtonCommitContent.Size = [System.Drawing.Size]::new(190, 40)
    $ButtonCommitContent.Location = [System.Drawing.Point]::new(100,315)
    $ButtonCommitContent.Add_Click({
        $Object  = $TextBoxObject.Text
        $Name    = $TextBoxName.Text
        $Content = $TextBoxContent.Text

        If ([string]::IsNullOrWhiteSpace($Object) -or [string]::IsNullOrWhiteSpace($Name) -or [string]::IsNullOrWhiteSpace($Content)) {
            [System.Windows.Forms.MessageBox]::Show(
                "Все поля должны быть заполнены.",
                "Ошибка",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Error
            )
        } 
        Else {
            $ResultCommit = [System.Windows.Forms.MessageBox]::Show(
                "Вы уверены, что хотите продолжить?",
                "Подтверждение",
                [System.Windows.Forms.MessageBoxButtons]::YesNo,
                [System.Windows.Forms.MessageBoxIcon]::Question
            )
            If ($ResultCommit -eq [System.Windows.Forms.DialogResult]::Yes) {
                Try {
                    SpaceClusterAddContent -Object "$Object" -Name "$Name" -Content "$Content"
                    [System.Windows.Forms.MessageBox]::Show(
                        "Commit to database done",
                        "Выполнено",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information
                    )
                }
                Catch {
                    [System.Windows.Forms.MessageBox]::Show(
                        "$($_)",
                        "Error",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Error
                    )


                }
                Finally  {
                    "SpaceClusterAddContent -Object $($Object) -Name $($Name) -Content '$($Content)'" >> "$($PSScriptRoot)\HistoryCommit\Content-$($Object)-$($Name).txt"        
                    $FormAddContentDataBase.Close()
                }
            }
        }
    })
    $FormAddContentDataBase.Controls.Add($ButtonCommitContent)
    $FormAddContentDataBase.ShowDialog()
}