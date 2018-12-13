#!/bin/bash

echo "Rebuilding and pushing to GitHub . . ."

hugo -t hermit

cd public
git add .
git commit -m "Site regenerated at `date`"
git push origin master

cd ..