$subs = Get-AzureRmSubscription
$exportPath = ''
Foreach ($sub in $subs){   
   $sub = $sub.Name
   Select-AzSubscription -Subscription "$sub"

   $nsgs = Get-AzNetworkSecurityGroup
   Foreach ($nsg in $nsgs){
        New-Item -ItemType file -Path "$exportPath\$($nsg.Name).csv" -Force
        $nsgRules = $nsg.SecurityRules
        foreach ($nsgRule in $nsgRules){
        $nsgRule | Select-Object Name,Description,Priority,Protocol,Access,Direction,@{Name=’SourceAddressPrefix’;Expression={[string]::join(“,”, ($_.SourceAddressPrefix))}},@{Name=’SourcePortRange’;Expression=
{
[string]::join(“,”, ($_.SourcePortRange))}},@{Name=’DestinationAddressPrefix’;Expression={[string]::join(“,”, ($_.DestinationAddressPrefix))}},@{Name=’DestinationPortRange’;Expression={[string]::join(“,”, ($_.DestinationPortRange))}} `

| Export-Csv "$exportPath\$sub\$($nsg.Name).csv" -NoTypeInformation -Encoding ASCII -Append}

        }
}
