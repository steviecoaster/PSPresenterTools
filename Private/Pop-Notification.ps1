Function Pop-Notification {
    $XmlString = @"
    <toast>
    <visual>
        <binding template="ToastGeneric">
        <text>Time Warning!</text>
        <text>$text</text>
        <image src="$PSScriptRoot\Lib\alarm.png" placement="appLogoOverride" hint-crop="circle" />
        </binding>
    </visual>
    <audio src="ms-winsoundevent:Notification.Default" />
    </toast>
"@
    
    $AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()
    $ToastXml.LoadXml($XmlString)
    $Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($Toast)

}