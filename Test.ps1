mkdir sample
cd sample
cabal init --license=MIT -p sample
cabal install haskell-say
cabal build :sample
cabal run
echo "-----"
cat sample.cabal
