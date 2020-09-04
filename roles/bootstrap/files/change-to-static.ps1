# Author: Rolando Anton
# Contact: rolando@anton.sh
# Blog: https://rolando.anton.sh


# Function from: https://d-fens.ch/2013/11/01/nobrainer-using-powershell-to-convert-an-ipv4-subnet-mask-length-into-a-subnet-mask-address/

function Convert-IpAddressToMaskLength([string] $dottedIpAddressString)
{
  $result = 0; 
  # ensure we have a valid IP address
  [IPAddress] $ip = $dottedIpAddressString;
  $octets = $ip.IPAddressToString.Split('.');
  foreach($octet in $octets)
  {
    while(0 -ne $octet) 
    {
      $octet = ($octet -shl 1) -band [byte]::MaxValue
      $result++; 
    }
  }
  Write-Output $result;
}

$MgmtAdapters = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled='true'" | Where -Property DHCPEnabled -eq "True"

foreach ($MgmtAdapters in $MgmtAdapters) {
    $MgmtInterfaceIndex = $MgmtAdapters.InterfaceIndex
    $MgmtipAddress = $MgmtAdapters.IPAddress
    $MgmtsubnetMask = $MgmtAdapters.IPSubnet
    $MgmtsubnetPrefix = Convert-IpAddressToMaskLength $MgmtsubnetMask
    $MgmtdnsServers = $MgmtAdapters.DNSServerSearchOrder
    $MgmtdefaultGateway = $MgmtAdapters.DefaultIPGateway
    if ( ($MgmtdnsServers) -and ($MgmtdefaultGateway)) {
       Set-NetIPInterface -InterfaceIndex $MgmtInterfaceIndex -Dhcp Disabled
       New-NetIPAddress -InterfaceIndex "$MgmtInterfaceIndex" -AddressFamily IPv4 -PrefixLength "$MgmtsubnetPrefix" -IPAddress "$MgmtipAddress" -DefaultGateway "$MgmtdefaultGateway"
       Set-DnsClientServerAddress -InterfaceIndex "$MgmtInterfaceIndex" -ServerAddresses  $MgmtdnsServers
    }
    if (!$MgmtdefaultGateway) {
       Set-NetIPInterface -InterfaceIndex $MgmtInterfaceIndex -Dhcp Disabled
       New-NetIPAddress -InterfaceIndex "$MgmtInterfaceIndex" -AddressFamily IPv4 -PrefixLength "$MgmtsubnetPrefix" -IPAddress "$MgmtipAddress"
    }
}
