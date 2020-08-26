# cd sample
# cabal update
# cabal install haskell-say
# ghc Main.hs --make -o sample
# ls .

# echo "---------------"
# cd ..
cd sample
cabal update
cabal install haskell-say
cabal build :sample
cabal run
# mkdir sample-cabal
# cd sample-cabal
# cabal init
# cabal build :sample-cabal
# cabal run

# echo "---------------"
# cd ..
# stack new sample-stack new-template
# cd sample-stack
# stack setup
# stack build
# stack exec sample-stack-exe

