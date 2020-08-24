$MgmtIP=$args[0]
$MgmtAdapters = gwmi -cl win32_networkadapterconfiguration -filter "ipenabled = 'true'" | ? {($_.ipaddress -like $MgmtIP) -and $_.dhcpEnabled -eq 'True' }
$MgmtInterfaceIndex = $MgmtAdapters.InterfaceIndex
Set-NetIPInterface -InterfaceIndex $MgmtInterfaceIndex -Dhcp Disabled
New-NetIPAddress -InterfaceIndex "$MgmtInterfaceIndex" -AddressFamily IPv4 -PrefixLength 24 -IPAddress $MgmtIP
$NonMgmtAdapters = gwmi -cl win32_networkadapterconfiguration -filter "ipenabled = 'true'" | ? {($_.ipaddress -notlike $MgmtIP) -and $_.dhcpEnabled -eq 'True' }

foreach ($NonMgmtAdapters in $NonMgmtAdapters) {
$NonMgmtipAddress = $NonMgmtAdapters.IPAddress
$NonMgmtsubnetMask = $NonMgmtAdapters.IPSubnet
$NonMgmtdnsServers = $NonMgmtAdapters.DNSServerSearchOrder
$NonMgmtdefaultGateway = $NonMgmtAdapters.DefaultIPGateway
$NonMgmtAdapters.EnableStatic($NonMgmtipAddress,$NonMgmtsubnetMask)
$NonMgmtAdapters.SetDNSServerSearchOrder($NonMgmtdnsServers)
$NonMgmtAdapters.SetGateways($NonMgmtdefaultGateway)
}

Restart-Computer -Force
