mkdir sample
cd sample
cabal init --license=MIT -p sample
cabal build :sample
ls ./dist-newstyle

