$ModuleName = "IPv4Class"
$RootPath = (Get-Item -Path $PSScriptRoot).Parent.FullName
$ModuleManifest = "$RootPath\$ModuleName.psd1"

Get-Module $ModuleName | Remove-Module
Import-Module $ModuleManifest

Describe "$ModuleName Module Tests" {

    It "has the root module $ModuleName.ps1" {
        "$RootPath\$ModuleName.ps1" | Should Exist
    }

    It "has the manifest file of $ModuleName.psd1" {
        "$RootPath\$ModuleName.psd1" | Should Exist
        {Test-ModuleManifest -Path "$RootPath\$ModuleName.psd1"} | Should Not Throw
    }

    It "has valid PowerShell code" {
        $psFile = Get-Content -Path "$RootPath\$ModuleName.ps1" -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should be 0
    }

    Context "Documentation Files"{
        It "has a README file"{
            "$RootPath\README.md" | Should Exist
            }

        It "has a LICENSE file"{
            "$RootPath\LICENSE.md" | Should Exist
        }

        It "has valid links in README file"{
            $READMEMedia = Get-Content "$RootPath\README.md" | Select-String -SimpleMatch ! | Where-Object {$_ -notlike "*http*"}
            foreach ($File in $ReadMeMedia){
                $File = $File.ToString().Split('(').Replace(')','')[1]
                "$RootPath\$File" | Should Exist
            }
        }

    }
}

Remove-Module $ModuleName