# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias cdk='cd /home/kuwako/dev/kirei_kaigi/app'
alias cdka='cd /home/kuwako/dev/kirei_kaigi/app_admin'
alias cdd='cd /home/kuwako/dev/dekita'
alias sengoku='cd /home/sengoku/dev/kirei_kaigi/ '
alias sand='cd /home/h-takeo/dev/sandbox'
alias sandpull='sudo git pull http://kuwako@gitlab.leverages.net:12480/beauty/kirei_kaigi.git development'
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
