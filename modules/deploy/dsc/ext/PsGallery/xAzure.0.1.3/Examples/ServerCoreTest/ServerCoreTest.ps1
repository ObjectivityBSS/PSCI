﻿configuration ServerCoreTest
{
        WindowsFeature NoGUI
        {
           Ensure = 'Absent'
           Name = 'Server-Gui-Mgmt-Infra'
        }
        LocalConfigurationManager
            RebootNodeIfNeeded = 'True'
}