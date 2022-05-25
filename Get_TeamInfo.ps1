Param
(
[Parameter(Mandatory=$true)]
[string]$DisplayName
)

$out=@()
$ResultPath = "C:\Temp\TeamInfo.csv"
$channelcount=0
$standchannel=0
$privatechannel=0
$sharedchannel=0

$groupid = (Get-Team -DisplayName $displayname).GroupID
$team = Get-Team -GroupID $groupid

$channels = Get-TeamChannel -GroupId $groupid
foreach($channel in $channels)
{
	$channelcount++
	if($channel.membershiptype -eq "Standard")
	{
		$standchannel++
	}
	elseif($channel.membershiptype -eq "Private")
	{
		$privatechannel++
	}
	else
	{
		$sharedchannel++
	}
}

$property = [PSCustomObject]@{	GroupID = $team.groupid
				DisplayName = $team.displayname
				TeamType = $team.visibility
				Archived = $team.archived
				Description = $team.description
				TotalChannels = $channelcount
				StandardChannels = $standchannel
				PrivateChannels = $privatechannel
				SharedChannels= $sharedchannel
			     }
$out += $property

$out | Export-Csv $ResultPath -NoTypeInformation -Encoding utf8