cd sample
ghc Main.hs --make -o sample
ls .

cd ..



# cd sample
# cabal install haskell-say
# cabal build :sample
# cabal run
mkdir sample-cabal
cd cabal-sample
cabal init
cabal build :sample-cabal
cabal run


cd ..
stack new sample-stack new-template
cd sample-stack
stack setup
stack build
stack exec sample-stack-exe

