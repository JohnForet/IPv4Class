@{

# Script module or binary module file associated with this manifest.
#RootModule = '.\IPv4Class.psm1'

ScriptsToProcess = @('IPv4Class.ps1')

# Version number of this module.
ModuleVersion = '1.0.0'

# ID used to uniquely identify this module
GUID = 'bf7757d2-607a-42e7-995f-f85386008ede'

# Author of this module
Author = 'John Foret'

# Company or vendor of this module
CompanyName = 'John Foret'

# Copyright statement for this module
Copyright = '(c) 2018 John Foret. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell class for creating and manipulating IPv4 addresses'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('IP', 'IPv4', 'Class')

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/JohnForet/IPv4Class'

    } # End of PSData hashtable

} # End of PrivateData hashtable

}
