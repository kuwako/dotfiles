# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias x='exit'
alias g='git'
alias ga='git add -i'
alias gst='git status'
alias gbr='git branch'
alias gco='git checkout'
alias gcm='git commit -m'
alias gpl='git pull upstream '
alias gps='git push origin '
alias glog='git log '
alias fnd='find ./ | xargs grep -n --color=always '
alias fndl='find ./ | grep -v "storage" |xargs grep -n --color=always'
alias swp='find ./ | grep -E "*.swp" | xargs rm -f'
alias loge='tail -f -n 100 storage/logs/error.log'
alias logl='tail -f -n 100 storage/logs/laravel.log'
# User specific aliases and functions

if [ "$PS1" ]; then
    exec /bin/zsh
fi

export PATH="$PATH:$HOME/rvm/bin" # Add RVM to PATH for scripting
