$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. $here\dsc_configuration.ps1

Default 
Start-DscConfiguration -wait -Force Default -Verbose