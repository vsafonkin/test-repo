cd sample
cabal install haskell-say
cabal build :sample
cabal run

cd ..
mkdir stack-sample
cd stack-sample
stack new
stack setup
stack build
stack run

