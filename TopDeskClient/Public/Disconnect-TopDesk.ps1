function Disconnect-TopDesk {
    <#
    .Synopsis

        Disconnect from TopDesk instance.

    .DESCRIPTION

        This command disconnects from the current TopDesk instance, clearing instance and authentication information.

    .EXAMPLE

        Disconnect-TopDesk

        This command will disconnect from the current TopDesk instance.

    .INPUTS

        This command does not accept input.

    .OUTPUTS

        [System.Boolean]

    .NOTES

        This command can be useful when connecting to multiple TopDesk instances or clearing current connection.

    .LINK

        https://github.com/rbury/TopDeskClient/blob/master/Docs/Connect-TopDesk.md

#>
    [CmdletBinding(HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Disconnect-TopDesk.md',
        ConfirmImpact = 'Medium')]
    [OutputType([bool])]
    Param()

    $script:tdCredential = [pscredential]::Empty
    $script:tdAPIVersion = 0
    $script:tdConnected = $false
    $script:tdURI = ''
    return $true

}
