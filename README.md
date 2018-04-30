# IPv4Class
PowerShell class for creating and manipulating IPv4 addresses.

[![Build status](https://ci.appveyor.com/api/projects/status/github/JohnForet/ipv4class?branch=master&svg=true)](https://ci.appveyor.com/project/JohnForet/ipv4class/branch/master)

### Motivation
This module/class was created to provide an easier way to do subnet calculations from within PowerShell

### Prerequisites
As this is a PowerShell class, you'll need to have at least **PowerShell 5** in order to use this.

### Installing

In order to install this module, just copy the module folder `IPv4Class` (in order for the module to be imported it's contents must be in this folder) to one the folders in `$env:PSModulePath`.

Since you're running PowerShell 5 (*right?*), you can also install it directly from the PowerShell Gallery with the following command:

`Install-Package -Name IPv4Class`

**IMPORTANT!:** Once installed, in order to use this class you'll have to first run `Import-Module IPv4Class` in your script or session. Elsewise the class will not be found.

### Usage

Create new IP object (at the moment *only* dotted decimal can be used when creating an object). Once created it will automatically calculate and create the decimal and binary versions of the IP as properties.
```powershell
[ipv4class]::new("192.168.1.15")
```
```text
IPAddress       Decimal Binary                          
---------       ------- ------                          
192.168.1.15 3232235791 11000000101010000000000100001111
```
Return all usable IPs using an IP in the subnet and the subnet mask
```powershell
$ipobject = [ipv4class]::new("192.168.1.15")
$ipobject.GetSubnetIPs("255.255.252.0")
```
```text
192.168.0.1
192.168.0.2
192.168.0.3
...
```

Calculate the SubnetID from a client IP and its subnet mask
```powershell
$ipobject = [ipv4class]::new("10.0.2.1")
$ipobject.GetSubnetID("255.255.252.0")
```
```text
10.0.0.0
```

Find out how many usable IPs a subnet mask will contain
```powershell
[ipv4class]::GetSubnetHostCount("255.255.252.0")
```
```text
1022
```

Convert dotted decimal IP into binary
```powershell
[ipv4class]::GetBinaryFromIP("192.168.1.89")
```
```text
11000000101010000000000101011001
```

Convert dotted decimal IP into plain decimal
```powershell
[ipv4class]::GetDecimalFromIP("192.168.1.89")
```
```text
3232235865
```

Convert binary IP into dotted decimal
```powershell
[ipv4class]::GetIPFromBinary("11000000101010000000000101011001")
```
```text
192.168.1.89
```

Convert plain decimal IP into dotted decimal
```powershell
[ipv4class]::GetIPFromDecimal("3232235865")
```
```text
192.168.1.89
```

### Authors

* **John Foret** - *Initial work* - [JohnForet](https://github.com/JohnForet)

### License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details