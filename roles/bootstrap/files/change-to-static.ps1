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

# Base reference: http://itproguru.com/expert/2012/01/using-powershell-to-get-or-set-networkadapterconfiguration-view-and-change-network-settings-including-dhcp-dns-ip-address-and-more-dynamic-and-static-step-by-step/

$Adapters = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled='true'" | Where -Property DHCPEnabled -eq "True"

foreach ($Adapters in $Adapters) {
    $InterfaceIndex = $Adapters.InterfaceIndex
    $ipAddress = $Adapters.IPAddress
    $subnetMask = $Adapters.IPSubnet
    $subnetPrefix = Convert-IpAddressToMaskLength $subnetMask
    $dnsServers = $Adapters.DNSServerSearchOrder
    $defaultGateway = $Adapters.DefaultIPGateway
    if ( ($dnsServers) -and ($defaultGateway)) {
       Set-NetIPInterface -InterfaceIndex $InterfaceIndex -Dhcp Disabled
       New-NetIPAddress -InterfaceIndex "$InterfaceIndex" -AddressFamily IPv4 -PrefixLength "$subnetPrefix" -IPAddress "$ipAddress" -DefaultGateway "$defaultGateway"
       Set-DnsClientServerAddress -InterfaceIndex "$InterfaceIndex" -ServerAddresses  $dnsServers
    }
    if (!$defaultGateway) {
       Set-NetIPInterface -InterfaceIndex $InterfaceIndex -Dhcp Disabled
       New-NetIPAddress -InterfaceIndex "$InterfaceIndex" -AddressFamily IPv4 -PrefixLength "$subnetPrefix" -IPAddress "$ipAddress"
    }
}
