$OU = "OU=Compass,OU=Accounts,OU=Lal Lal Primary School,DC=curric,DC=lal-lal-ps,DC=wan"

New-ADGroup -Name CompassAttendanceManagers -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassBusinessManagers -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassCommunications -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassCustomClasses -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassDailyOrg -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassFinanceView -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassLearningLeaders -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassParents -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassPrincipals -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassRegistrars -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassReplacementStaff  -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassSecretaries -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassSecretariesView -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassSponsors -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassStaff -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassStudentManagers -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassStudents -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassSuper -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassTeachingStaff -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassTechnicians -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassViewAll -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassWellbeing -GroupCategory Security -GroupScope Global -Path $OU
New-ADGroup -Name CompassWellbeingView -GroupCategory Security -GroupScope Global -Path $OU