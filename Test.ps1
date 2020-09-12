$rubyVersion = "2.7.1"
$rubyPath = Join-Path $env:AGENT_TOOLSDIRECTORY "Ruby" $rubyVersion "x64"

$testPath = "~/.rubies"
New-Item $testPath -ItemType Directory

# Remove-Item "$rubyPath/*" -Recurse -Force
# Write-Host "Check ruby $rubyVersion toolcache directory:"
# ls $rubyPath

wget -O ruby-2.7.1.tar.gz 'https://github.com/ruby/ruby-builder/releases/download/enable-shared/ruby-2.7.1-ubuntu-18.04.tar.gz'
tar -xz -C $testPath -f ruby-2.7.1.tar.gz
Write-Host "--------"
Get-ChildItem $testPath

# export LD_LIBRARY_PATH="${AGENT_TOOLSDIRECTORY}/Ruby/2.7.1/x64/lib"
# Invoke-Expression "echo 'export LD_LIBRARY_PATH=$env:AGENT_TOOLSDIRECTORY/Ruby/2.7.1/x64/lib' | tee -a /etc/skel/.bashrc"
# Invoke-Expression "sudo echo '$rubyPath/lib' >> /etc/ld.so.conf.d/ruby.conf;sudo ldconfig"

# Invoke-Expression "echo '##vso[task.prependpath]/home/vsts/.rubies/ruby-2.7.1/bin'"
# Invoke-Expression "/home/vsts/.rubies/ruby-2.7.1/bin/gem install bundler -v ~> 2 --no-document"
Invoke-Expression "/home/runner/.rubies/ruby-2.7.1/bin/ruby --version"
Invoke-Expression "/home/runner/.rubies/ruby-2.7.1/bin/gem --version"
