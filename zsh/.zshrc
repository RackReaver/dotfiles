# <username> at <hostname> in <current_directory>
PROMPT="%B%F{208}%n%f%b at %B%F{11}%m%f%b in %B%F{34}%~%f%b$ "

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZ

export GPG_TTY=$(tty)

# Override existing openssh by adding the brew version to beginning of PATH
# Allows YubiKey to be used as second authentication for ssh keys
export PATH=$(brew --prefix openssh)/bin:$PATH

# Fix for using YubiKey as two factor for ssh
eval `ssh-agent -s`

# Aliases

alias ls='ls -G'	# Colorize list command
alias ll='ls -lG'	# Colorize list command
alias cls='clear'
alias python='python3'
alias pip='pip3'
alias config='vim $HOME/.zshrc'
alias vconfig='vim $HOME/.vimrc'
alias pro='cd $HOME/Documents/code'
alias reload='source $HOME/.zshrc'

# Git aliases
alias gs='git status'
alias gc='git commit -a'
alias gp='git pull'
alias gd='git diff'

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Setup new computer or terminal.
terminal_setup () {

    # Install and setup brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git gpg-suite

    # Install .vimrc
    curl https://raw.githubusercontent.com/RackReaver/dotfiles/main/vim/.vimrc > ~/.vimrc

    # Setup git
    git config --global user.name "Matt Ferreira"
    git config --global user.email "rackreaver@gmail.com"
    git config --global commit.gpgsign true
    git config --global gpg.program gpg
}

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

# Setup for copying dotfiles for github.
copy_dotfiles () {
    cp $HOME/.zshrc ${1:?"The destination must be specified."}/zsh
    cp $HOME/.vimrc $1/vim
}
