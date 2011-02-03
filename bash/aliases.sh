# Dirs
alias o="open ."  # OS X, open in Finder
alias la="ls -a"
alias ll="ls -l"   
alias l='tree --dirsfirst -ChAFL 1'
alias cdd='cd -'  # back to last directory
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Tools
alias gist="ruby1.8 /usr/local/bin/gist"
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

# Ruby on Rails
alias r='rails'   
alias rs='rails server'
alias rsd='rails server --debugger'
alias mig='rake db:migrate'
alias ss='./script/server'
alias ssd='./script/server --debug'
alias sc='./script/console'     
alias devlog='tail -f log/development.log'
alias restart_rails="touch tmp/restart.txt && echo touched tmp/restart.txt"  # Passenger

# Bundler 
alias bi='bundle install'

# Git 
alias got='git '
alias gst='git status'
alias ga='git add'
alias gca='git commit -v -a'
alias gc='git commit -m '
alias gp='git push'
alias gpp='git pull && git push'
alias gl='git pull'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gd='git diff'
alias gdm="git diff | mate"
alias gls='git log --stat'
alias gll='git log --pretty=oneline'
alias glg='git log --pretty=format:"%h : %s" --topo-order --graph'
alias glm="git log | mate"
alias gcp="git cherry-pick"

# git flow
alias gf='git flow'
alias gff='git flow feature'
alias gfr='git flow release'
alias gfh='git flow hotfix'
alias gfs='git flow support'
alias gfv='git flow version'

# Svn 
alias sst='svn status'
alias ssi='svn info'
alias sco='svn commit -m '
alias sa='svn add '
alias ssu='svn update'
  

# Textmate
alias m="mate"
alias mm="mate ."

# By default, your app's error log now goes here. Unless you configure your apps otherwise, 
# it's helpful to have an alias to take you to your error log quickly.
alias apache_logs='cd /usr/local/apache2/logs/'

# Dito with hosts
alias hosts='sudo vim /etc/hosts'

# You'll need to restart apache whenever you make a change to vhosts. 
# You can also click System Preference->Sharing->Web Sharing, but this is quicker.
alias apache_restart='sudo apachectl restart'
