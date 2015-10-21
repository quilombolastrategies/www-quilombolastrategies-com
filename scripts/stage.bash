#!/bin/bash
# script name : edit.bash
# script args : $1 -- file to be edited [ALL for working+sub directories]
#       $2 -- comments for git
#       $3 -- remove interactivity if parameter equals "noprompting"
#
# Make certain that you are only editing the development branch.
# Edit the file supplied as an argument to this script.
#
# The script ensures that edits are pushed to the development 
# branch at the origin before checking out staging to merge
# the edits previously made into staging. The script then pushes
# the merge into the staging branch back at the origin.
#
# After pushing the merge to staging at the origin we are ready to
# deploy to Heroku. Consequently the script lets git know about the
# staging Heroku app for the domain and identifies it as "staging-
# heroku". Then the push is made.
#
git remote remove origin
git remote add origin https://github.com/quilombolastrategies/www-quilombolastrategies-com.git
git checkout development || git checkout -b development
if [ $1 == "ALL" ] ; then
	git add --all .
else
	git add $1
fi
git commit -m "$2"
git push origin development
[ $3 == "noprompting" ] || while true; do
    read -p "shall we push changes to the staging GitHub repository and the staging instance on Heroku? " yn
    case $yn in
        [Yy]* ) echo "proceeding..."; break;;
        [Nn]* ) exit;;
        * ) echo "please answer yes or no.";;
    esac
done
git checkout staging || git checkout -b staging
git merge development
git push origin staging
cat ~/.netrc | grep heroku || heroku login && heroku keys:add ~/.ssh/id_rsa.pub
heroku apps:destroy staging-quilombolastrategies-com --confirm staging-quilombolastrategies-com
heroku apps:create staging-quilombolastrategies-com
heroku domains:add staging.quilombolastrategies.com --app staging-quilombolastrategies-com
heroku git:remote -a staging-quilombolastrategies-com -r staging-heroku
git push staging-heroku staging:master
git checkout development
