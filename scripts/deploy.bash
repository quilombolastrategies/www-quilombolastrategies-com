#!/bin/bash
# script name : deploy.bash 
#
# Finally we check out the master branch, verify (--as always), and 
# merge the changes made to the staging branch. Of course this assumes
# that we actually bothered to checkout the staging site and viewed
# the new source code to verify changes and successful implementation.
# Then the changes are pushed to the master branch at the origin at
# GitHub, before identifying and then pushing the changes to the "live"
# or "production" instance ("production-heroku) at Heroku.
# 
# git operations
git remote remove origin
git remote add origin https://github.com/quilombolastrategies/www-quilombolastrategies-com.git
git checkout master || git checkout -b master
git merge staging
git push origin master

#
# heroku operations
cat ~/.netrc | grep heroku || heroku login && heroku keys:add ~/.ssh/id_rsa.pub
heroku apps:destroy www-quilombolastrategies-com --confirm www-quilombolastrategies-com
heroku apps:create www-quilombolastrategies-com
heroku domains:add www.quilombolastrategies.com --app www-quilombolastrategies-com
heroku domains:add quilombolastrategies.com --app www-quilombolastrategies-com
heroku git:remote -a www-quilombolastrategies-com -r production-heroku
git push production-heroku master:master
git checkout development
