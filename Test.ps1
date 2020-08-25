mkdir sample
cd sample
cabal init --license=MIT -p sample
cabal build :sample
cabal run
cabal install haskell-say
cat sample.cabal
