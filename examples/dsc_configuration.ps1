Configuration Default {

    Import-DSCResource -ModuleName Env_Refresh
    Node 'localhost' {
        Env_Refresh TESTVAR 
        {
            Ensure            = 'Present'
            RunName           = 'RMQ_BASE_VAR'
            VariableNameList  = 'RABBITMQ_BASE'
        }
    }
    
}