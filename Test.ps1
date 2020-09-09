# Get-ChildItem /usr/share | Where-Object { $_ -match "az_\d+" } | Foreach-Object {
#     $_.Name.Split("_")[1]
# }

hg clone https://www.mercurial-scm.org/repo/hello
cd hello
echo 'This is a test' > data.txt
hg add data.txt
hg status
