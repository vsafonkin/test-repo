# Get-ChildItem /usr/share | Where-Object { $_ -match "az_\d+" } | Foreach-Object {
#     $_.Name.Split("_")[1]
# }

hg clone https://www.mercurial-scm.org/repo/hello
cd hello
rm Hello.c
hg add .
hg status
