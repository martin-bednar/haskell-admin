#!/bin/bash
set -e # Exit immediately on error
echo "Publish candidate $1..."
cd $1
stack build --test --haddock
stack upload --candidate .
cabal v2-haddock --builddir="./doc" --haddock-for-hackage --enable-doc
cd doc
cabal upload -d *.tar.gz
cd ..
rm -r doc
echo "Publish candidate done"