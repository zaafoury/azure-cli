$subs = Get-AzureRmSubscription
$exportPath = ''
Foreach ($sub in $subs){
   $sub = $sub.Name
   Select-AzSubscription -Subscription "$sub"

   $pips = Get-AzureRmPublicIpAddress
   Foreach ($pip in $pips){
        $pip | Select-Object Name,IpAddress,PublicIpAllocationMethod,ResourceGroupName,Location`
        | Export-Csv "$exportPath\allpip.csv" -NoTypeInformation -Encoding ASCII -Append}

        }
