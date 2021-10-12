$List = @("Randy", "Cartman", "Kenny", "Kyle", "Stan")

function New-Menu {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [System.Array]$MenuItems,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$MenuQuestion,

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$MenuTitle
  )

  [int]$Index = 0
  [int]$Answer = 0
  $Switch= 'switch ($Answer) { '

  Write-Host "`n`t------------------$MenuTitle------------------"
  
  foreach ($e in $MenuItems) {
    Write-Host "`t$Index : $e"
    $Switch += "$Index { `$Return = `"$e`" } "
    $Index++
  }
  
  Write-Host "`t------------------------------------"

  $Switch += "}"
  $Answer = Read-Host "`n$MenuQuestion"
  Invoke-Expression $Switch

  Return $Return
}

$myFavorite = New-Menu -MenuItems $List -MenuQuestion "Who is your favorite ?"

Write-Host $myFavorite
