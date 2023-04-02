.\hugo.exe -d .\docs\ --minify
git add .
git commit -m "$args[0]"
git push