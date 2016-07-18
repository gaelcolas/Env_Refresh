Configuration Default {

    Import-DSCResource -ModuleName Env_Refresh
    Node 'localhost' {
        Env_Refresh TESTVAR 
        {
            Ensure            = 'Present'
            #RunName           = 'RMQ_BASE_VAR'
            #VariableNameList  = 'RABBITMQ_BASE'
        }
        Script Test 
        {
            SetScript = { 'test' | Write-verbose }
            GetScript = { return @{result='test'} }
            TestScript = { return $false }
        }
    }
    
}

$configData = @{
AllNodes = @(
        @{
            NodeName = 'localhost';
        }
    )
}

#Default 
#Start-DscConfiguration -wait -Force Default -Verbose