$ModuleName = "IPv4Class"
$RootPath = (Get-Item -Path $PSScriptRoot).Parent.FullName
$ModuleManifest = "$RootPath\$ModuleName.psd1"

Get-Module $ModuleName | Remove-Module
Import-Module $ModuleManifest -Force

describe 'ClassTests' {

    $results = [IPv4Class]::new("10.0.8.0")

    it 'should set IPAddress to 10.0.8.0' {
        $results.IPAddress | should be '10.0.8.0'
    }

    it 'should set Decimal to 167774208' {
        $results.Decimal | should be '167774208'
    }

    it 'should set Binary to 00001010000000000000100000000000' {
        $results.Binary | should be '00001010000000000000100000000000'
    }

    it 'should be have a type of IPv4Class' {
        $results.GetType().Name | should be 'IPv4Class'
    }

    Context 'GetBinaryFromIP' {

        $results = [IPv4Class]::GetBinaryFromIP("10.0.0.4")

        it 'should return 00001010000000000000000000000100' {
            $results | should be '00001010000000000000000000000100'
        }

        it 'should be 32 characters long' {
            $results.ToCharArray() | measure | Select-Object -ExpandProperty Count | should be 32
        }

        it 'should return only one object' {
            $results | measure | Select-Object -ExpandProperty Count | should be 1
        }

        it 'should be a string' {
            $results.GetType().Name | should be 'String'
        }

    }

    Context 'GetDecimalFromIP' {

        $results = [IPv4Class]::GetDecimalFromIP("10.0.0.1")

        it 'should return 167772161' {
            $results | should be '167772161'
        }

        it 'should return only one object' {
            $results | measure | Select-Object -ExpandProperty Count | should be 1
        }

        it 'should be Int64' {
            $results.GetType().Name | should be 'Int64'
        }

    }

    Context 'GetIPFromBinary' {

        $results = [IPv4Class]::GetIPFromBinary("00001010000000000000000000000011")

        it 'should return 10.0.0.3' {
            $results | should be '10.0.0.3'
        }

        it 'should return only one object' {
            $results | measure | Select-Object -ExpandProperty Count | should be 1
        }

        it 'should be a string' {
            $results.GetType().Name | should be 'String'
        }

    }

    Context 'GetIPFromDecimal' {

        $results = [IPv4Class]::GetIPFromDecimal("167772162")

        it 'should return 10.0.0.2' {
            $results | should be '10.0.0.2'
        }

        it 'should return only one object' {
            $results | measure | Select-Object -ExpandProperty Count | should be 1
        }

        it 'should be a string' {
            $results.GetType().Name | should be 'String'
        }

    }

    Context 'GetSubnetID' {

        $test = [IPv4Class]::new("192.168.1.56")
        $results = $test.GetSubnetID("255.255.255.0")

        it 'should return 192.168.1.0' {
            $results | should be '192.168.1.0'
        }

        it 'should return only one object' {
            $results | measure | Select-Object -ExpandProperty Count | should be 1
        }

        it 'should be a string' {
            $results.GetType().Name | should be 'String'
        }

    }

    Context 'GetSubnetHostCount' {

        $results = [IPv4Class]::GetSubnetHostCount("255.255.255.0")

        it 'should return 254' {
            $results | should be 254
        }

        it 'should return only one object' {
            $results | measure | Select-Object -ExpandProperty Count | should be 1
        }

        it 'should be a string' {
            $results.GetType().Name | should be 'String'
        }

    }

    Context 'GetSubnetIPs' {

        $test = [IPv4Class]::new("10.0.8.0")
        $results = $test.GetSubnetIPs("255.255.255.0")

        it 'should return 254' {
            $results | measure | Select-Object -ExpandProperty Count | should be 254
        }

        it 'should return 10.0.8.1 as the first result' {
            $results | Select-Object -First 1 | should be "10.0.8.1"
        }

        it 'should return 10.0.8.254 as the last result' {
            $results | Select-Object -Last 1 | should be "10.0.8.254"
        }

        it 'should be an array' {
            $results.GetType().BaseType.Name | should be 'Array'
        }

    }

}