hugo -d docs/ --minify
git add .
git commit -m "$1"
git push
