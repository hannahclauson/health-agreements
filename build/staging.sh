[[ ! -s \"$(git rev-parse --git-dir)/shallow\" ]] || git fetch --unshallow
git push git@heroku.com:symbolofhealth-staging.git $CIRCLE_SHA1:refs/heads/master
heroku run rake db:migrate --app symbolofhealth-staging
export VER=release-`cat build/version`.$CIRCLE_BUILD_NUM
git config --global user.email "symbolofhealthbot@gmail.com"
git config --global user.name "symbolofhealthbot"
git tag -a $VER -m $VER
git tag
git push --tags
#git@github.com:sjezewski/health-agreements.git
#git fetch --tags