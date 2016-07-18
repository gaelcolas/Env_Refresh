Task default -Depends CreatePSModuleSymlink
#Thanks to Matt Hodgkins for his tip #2:
#https://hodgkins.io/five-tips-for-writing-dsc-resources-in-powershell-version-5 
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Properties {
    $myPSmodulePath = "$env:ProgramFiles\WindowsPowerShell\Modules"
    $ModuleFolder = $here | Split-Path -Leaf
}

Task CreatePSModuleSymlink  {
    $targetModulePath = Join-path $myPSmodulePath $ModuleFolder
    $ExistingSymLinkInModulePath = $env:PSModulePath -Split ';' |`
            Get-ChildItem  | Where-Object { $_.Attributes -match 'ReparsePoint'}
    if ($ExistingSymLinkInModulePath.FullName -notcontains $targetModulePath)
    {
        New-Item -ItemType SymbolicLink -Path $targetModulePath -Target $here
    }
    else {
        Write-Warning "$targetModulePath already exists in PSModulePath"
    }
 }
