<#
Currently, Windows has a limit of 15 overlay icons that can be loaded.
With the installation of One Drive, Windows prioritizes its own icons over DropBox's
This has caused Dropbox Overlay icons to break and many Marketplace Users are complaining about this.
This script finds all the DropBox Icon Overlay Identifier Registry Items and renames them with spaces in front so that
they will be prioritized over the One Drive Icons.
#>

$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers"
$keys = Get-ChildItem $path

foreach($key in $keys) {
  if( $key -like "*DropBox*" ) {
    $itemname = $key.name.split("\")[7] -replace "[ ]",""
    $pathname = "HKLM:\$($key.name.trim("HKEY_LOCAL_MACHINE\"))"
    #Rename-Item -path $pathname -NewName "          $($itemname)"
  }
}
