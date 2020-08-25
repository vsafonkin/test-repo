cd sample
cabal install haskell-say
cabal build :sample
cabal run

echo "-----"

ghc -o sample Main.hs
bash ./sample
