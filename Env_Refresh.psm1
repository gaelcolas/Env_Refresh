####################################################################################################

enum Ensure {
    Absent
    Present
}

[DscResource()]
Class Env_Refresh {
    [DSCProperty(Key)]
    [Ensure] $Ensure

    #[DSCProperty(key)]
    #[string]$RunName

    #[DSCProperty(Mandatory)]
    #[string[]]$VariableNameList


    [void] Set()
    {
        Write-Verbose "EnvironmentVariableRefresh for $($this.Ensure)::$($this.RunName)"
        if ($this.VariableNameList -eq '*')
        {
            $this.VariableNameList = [Environment]::GetEnvironmentVariables().Keys
        }
        if ($this.Ensure -eq [Ensure]::Present) 
        {
            foreach ($variableName in $this.VariableNameList)
            {
                Write-Verbose "Processing $($this.RunName)::$variableName"
                $VariableValue = [environment]::GetEnvironmentVariable($variableName,[EnvironmentVariableTarget]::Machine)
                [Environment]::SetEnvironmentVariable($variableName,$VariableValue, [EnvironmentVariableTarget]::Process)
            }
        }
    }
    
    [Env_Refresh] Get()
    {
        Write-Verbose "Returning This instance for GET: Ensure:$($this.Ensure.ToString()) $($this.RunName)"
        return $this
    }

    [bool] Test()
    {
        return $false
    }
}