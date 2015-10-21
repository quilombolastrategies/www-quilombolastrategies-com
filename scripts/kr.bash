#!/bin/bash
# script name : kr.bash
# 
git clone git@github.com:munair/www-quilombolastrategies-kr.git
cd www-quilombolastrategies-kr
echo "you have five seconds to Ctrl-Z in your manual changes"
sleep 5
cp -f ../js/* js
cp -f ../css/* css
cp -f ../images/* images
cp -f ../fonts/* fonts
cp -f ../sounds/* sounds
cat ../README.md | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > README.md
cat ../edit.bash | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > edit.bash
cat ../inc_contact.html | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > inc_contact.html
cat ../inc_email.html | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > inc_email.html
cat ../inc_formconfirmation.html | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > inc_formconfirmation.html
cat ../package.json | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > package.json
cat ../web.js | sed 's/quilombolastrategies-com/quilombolastrategies-kr/g' | sed 's/quilombolastrategies\.com/quilombolastrategies\.kr/g' > web.js
bash edit.bash . "[AUTOMATED] Pushing changes to KR website from COM website excluding index.html in particular. To modify index.html git clone the repo and modify by hand." noprompting
cd ..
rm -rf www-quilombolastrategies-kr
