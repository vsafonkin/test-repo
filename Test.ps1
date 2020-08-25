mkdir sample
cd sample
cabal init --license=NONE -p sample
cabal build :sample
ls .
./sample
