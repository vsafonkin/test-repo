# cd sample
# cabal install haskell-say
# cabal build :sample
# cabal run
mkdir cabal-sample
cd cabal-sample
cabal init
cabal build :cabal-sample
cabal run


cd ..
stack new my-project
cd my-project
stack setup
stack build
stack exec my-project-exe

