<# 

Header stuff here

#>

$users = Get-ChildItem "C:\users" |select-object -expandproperty name

<# ===
$extensions = $users | foreach-object {
    Get-ChildItem "C:\users\$_\appdata\local\Google\Chrome\User Data\Default\Extensions\" |
    select-object -expandproperty name -ErrorAction SilentlyContinue  
}
=== #>
# === Extension IDs for testing === 
    #To use these, simply comment out the $extensions variable above, and remove the comments from this section.

$extensions = "aapocclcgogkmnckokdopfmhonfmgoek", "aohghmighlieiainnegkcijnfilokake", "apdfllckaahabafndbhieahigkjlhalf", "blpcfgokakmgnkcojhhkbfbldkacnbeo", "felcaaldnbdncclmgdcncolpebgiejap", "ghbmnnjooekpmoecnnnilnnbdlolhkhi",  "klbibkeccnjlkjkiokjodocebajanakg", "mdpljndcmbeikfnlflcggaipgnhiedbl"

#=== #>

$objects = @{
    ReferenceObject = get-content "C:\users\aj\Downloads\Malicious Chrome Extensions.txt" |out-string -stream
    DifferenceObject = $extensions
}
Compare-Object (get-content "C:\users\aj\Downloads\Malicious Chrome Extensions.txt") $extensions -IncludeEqual -ExcludeDifferent |
    Select-Object InputObject |
    Format-Table @{L="Malicious Extensions for user: $users";E={$_.InputObject}}

#@objects -ExcludeDifferent
        
