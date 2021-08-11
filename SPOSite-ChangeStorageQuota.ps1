<#
Goes thru all APMG SharePoint sites and checks to see if
the current storage used is less than 50GB
If current storage used is less than 50GB and storage quota is greater than 50gb, 
it changes the storage quota for that site to 50GB.
If not, it skips.
/*Want to avoid sites like ITD3 and Reading Investigation*/
#>

$sposites=Get-SPOSite -Limit All

foreach($site in $sposites) {
  $storageused = $site.StorageUsageCurrent
  $storagequota = $site.StorageQuota
  
  if ( $storageused -lt (50gb/1mb) -and $storagequota -gt (50gb/1mb) ) {
    #Set-SPOSite $site.Url -StorageQuota (50gb/1mb) -StorageQuotaWarningLevel (45gb/1mb)
    Write-Host -ForegroundColor Red "Updated Storage Quota for $($site.Url): From:$($site.StorageQuota) To:$(50gb / 1mb) Usage:$($storageused) Free:$((50gb / 1mb) - $($storageused))"
  }else {
    Write-Host -ForegroundColor Green "Verified Storage Quota for $($site.Url): Quota:$($site.StorageQuota) Usage:$($storageused) Free:$($($site.StorageQuota) - $($storageused))"
  }
}