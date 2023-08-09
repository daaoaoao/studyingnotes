now=$(data"+%Y-%m-%d")
pathDir=D:/workstudy/studyingnotes
echo "Change Directory to $pathDir"
cd $pathDir
echo "pushing to git"
git add -A
git commit -m "update $now"
git pull
git push
echo "pushed to git"
read -p "Press enter to continue"

