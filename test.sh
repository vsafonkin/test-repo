echo "clone repository"
git clone https://github.com/couchbaselabs/couchbase-shell
cd ./couchbase-shell

echo "install deps"
brew install automake

export MACOSX_DEPLOYMENT_TARGET=10.9
export VCPKGRS_DYNAMIC=1

cargo build --verbose

