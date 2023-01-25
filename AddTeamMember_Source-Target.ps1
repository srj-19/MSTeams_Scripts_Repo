#START

Param
(
[Parameter(Mandatory=$true)]
[string]$SourceTeam,

[Parameter(Mandatory=$true)]
[string]$TargetTeam
)

$SourceGroupID = (Get-Team -DisplayName $SourceTeam).GroupID
$TargetGroupID = (Get-Team -DisplayName $TargetTeam).GroupID

$Users = (Get-TeamUser -GroupId $SourceGroupID).User

foreach($user in $users)
{
	Add-TeamUser -GroupId $TargetGroupID -User $user -Role Member
}


#END