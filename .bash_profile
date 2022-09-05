# .bash_profile                                                                                                                                           

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

export ANYENV_ROOT="/Users/m-kuwako/.anyenv"
export PATH=$PATH:"/Users/m-kuwako/.anyenv/bin"
eval "$(anyenv init -)"
export PATH="$(brew --prefix php@7.1)/bin:$PATH"
