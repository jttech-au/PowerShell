$a = (Get-Date)
$Year = $a.ToString("yyyy")
$YearPlusOne = $a.AddYears(1).ToString("yyyy")
$YearFolder = "$Year" + "-" + "$YearPlusOne"

$YearRootFolder = "\\SERVER\folder\$YearFolder"

$groups = @("ATO","Bookkeeping","Clients","Receipts")
$bk = @("Account Transactions","Balance Sheet","Profit & Loss")
$cli = @("DET")
$clisub = @("Invoice","Remittance","Time Sheet")
$Month12 = @("07 July","08 August","09 September","10 October","11 November","12 December")
$Month6 = @("01 January","02 February","03 March","04 April","05 May","06 June")

foreach ($g in $groups )
    {
    $GroupsFolder = $YearRootFolder + "\" + $g
    New-Item -Path $GroupsFolder -ItemType directory
        if ($g -eq "Receipts")
            {
                $ReceiptsYearFolder = $YearRootFolder + "\" + $g + "\" + $Year
                New-Item -Path $ReceiptsYearFolder -ItemType directory
                foreach ($m12 in $Month12 )
                    {
                        $m12Folder = $YearRootFolder + "\" + $g + "\" + $Year + "\" + $m12
                        New-Item -Path $m12Folder -ItemType directory
                    }

                $ReceiptsYearPlusOneFolder = $YearRootFolder + "\" + $g + "\" + $YearPlusOne
                New-Item -Path $ReceiptsYearPlusOneFolder -ItemType directory
                foreach ($m6 in $Month6 )
                    {
                        $m6Folder = $YearRootFolder + "\" + $g + "\" + $YearPlusOne + "\" + $m6
                        New-Item -Path $m6Folder -ItemType directory
                    }
            }
    }

foreach ($b in $bk )
    {
    $bkFolder = $YearRootFolder + "\" + "Bookkeeping" + "\" + $b
    New-Item -Path $bkFolder -ItemType directory
    }

foreach ($c in $cli )
    {
    foreach ($cs in $clisub)
            {
            $ClientsFolder = $YearRootFolder + "\" + "Clients" + "\" + $c + "\" + $cs
            if (($c -eq "Example Services") -or ($cs -ne "Time Sheet"))
                {
                    New-Item -Path $ClientsFolder -ItemType directory
                }
            }
    }