# <username> at <hostname> in <current_directory>
PROMPT="%B%F{208}%n%f%b at %B%F{11}%m%f%b in %B%F{34}%~%f%b$ "

# Remove all python temp files
pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

# Get number of lines coded by user for current git repo
gitlinecount () {
    git ls-files | while read f; do git blame -w --line-porcelain -- "$f" | grep -I '^author ';     done | sort -f | uniq -ic | sort -n
}

# Clean up dangling docker images
dockerclean () {
    docker rmi -f $(docker images -qf dangling=true)
}                   

export GPG_TTY=$(tty)

