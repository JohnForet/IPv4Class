Class IPv4Class {
    [ValidatePattern("^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")]
    [string]$IPAddress

    [int64]$Decimal

    [string]$Binary

    # Constructors
    IPv4Class (
        [string]$IPAddress
    ){
        $this.IPAddress = $IPAddress
        $this.Decimal = [IPv4Class]::GetDecimalFromIP($IPAddress)
        $this.Binary = [IPv4Class]::GetBinaryFromIP($IPAddress)
    }

    # Methods
    static [string]GetBinaryFromIP([string]$IPAddress){
        $binarynum = ($IPAddress.Split('.') | ForEach-Object{[Convert]::ToString($_, 2).PadLeft(8,"0")}) -join ''
        return $binarynum
    }

    static [int64]GetDecimalFromIP([string]$IPAddress){
        $binarynum = ($IPAddress.Split('.') | ForEach-Object{[Convert]::ToString($_, 2).PadLeft(8,"0")}) -join ''
        return [convert]::ToInt64($binarynum,2)
    }

    static [string]GetIPFromBinary([string]$Binary){
        $binarynum = $Binary.PadLeft(32,"0")
        $IP = (
            0, 8, 16, 24 | ForEach-Object{
                [convert]::ToInt64($binarynum.Substring($_,8),2)
            }
        ) -join '.'
        return $IP
    }

    static [string]GetIPFromDecimal([string]$Decimal){
       $binarynum = [convert]::ToString([int64]$Decimal,2)
       return [IPv4Class]::GetIPFromBinary($binarynum)
    }

    [string] GetSubnetID([string]$SubnetMask){
        $SubnetMaskIP = ([IPv4Class]::new($SubnetMask)).IPAddress
        $IPAddressArray = $this.IPAddress.Split('.')
        $SubnetMaskArray = $SubnetMaskIP.Split('.')
        $SubnetID = (
            0..3 | ForEach-Object{
                $IPAddressArray[$_] -band $SubnetMaskArray[$_]
            }
        ) -join '.'
        return $SubnetID
    }

    static [string] GetSubnetHostCount([string]$SubnetMask){
        $SubnetMaskIP = ([IPv4Class]::new($SubnetMask)).IPAddress
        $MaskZeroCount = [IPv4Class]::GetBinaryFromIP($SubnetMaskIP).TrimStart("1").ToCharArray() | measure | Select-Object -ExpandProperty Count
        $SubnetHostCount = [math]::Pow(2,$MaskZeroCount) - 2
        return $SubnetHostCount
    }

    [array] GetSubnetIPs([string]$SubnetMask){
        $SubnetMaskIP = ([IPv4Class]::new($SubnetMask)).IPAddress
        $ip = [IPv4Class]::new($this.IPAddress)
        $subnetid = $ip.GetSubnetID($SubnetMaskIP)
        $start = [IPv4Class]::new($subnetid).Decimal + 1
        $end = $start + ([IPv4Class]::GetSubnetHostCount($SubnetMaskIP) - 1)
        #odd math needed here to get range numbers into int32
        $IPs = ($start - ($start - 1))..($end - ($start - 1))| ForEach-Object{
            $ip = $_ + ($start -1)
            [IPv4Class]::GetIPFromDecimal($ip)
        }
        return $IPs
 
    }

}
