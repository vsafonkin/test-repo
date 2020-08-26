cd sample
# cabal install haskell-say
# cabal build :sample
# cabal run

mkdir stack-sample
cd stack-sample
stack new
stack setup
stack build

echo "-----"
stack --help
