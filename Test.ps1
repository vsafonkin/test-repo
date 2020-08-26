cd sample
# cabal install haskell-say
# cabal build :sample
# cabal run

stack init
stack setup
stack build
stack run

echo "-----"
stack --help
