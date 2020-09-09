# Get-ChildItem /usr/share | Where-Object { $_ -match "az_\d+" } | Foreach-Object {
#     $_.Name.Split("_")[1]
# }

hg init -v hello
cd hello
echo 'This is a test' > data.txt
hg add data.txt
hg status
