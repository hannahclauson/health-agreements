export VER=release-`cat build/version`.$CIRCLE_BUILD_NUM
git tag -a $VER -m $VER
git push --tags git@github.com:sjezewski/health-agreements.git
#git fetch --tags