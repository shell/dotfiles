# for Mercurial
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


source /usr/local/git/contrib/completion/git-completion.bash
if [ -f ~/.bashrc ]; then source ~/.bashrc; fi
	
	
alias la="ls -a"
alias ll="ls -l"   
alias t="tree -L 1 -C -h"
alias l='tree --dirsfirst -ChAFL 1'

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# #hg id -bn 2> /dev/null | sed -e 's/\(.*\) \(.*\)/(\2:\1)/'
}

# Set the prompt.
CODE_RED=$'\[\033[0;31m\]'
CODE_GREEN=$'\[\033[0;32m\]'
CODE_YELL=$'\[\033[0;33m\]'
CODE_BLUE=$'\[\033[0;34m\]'
CODE_NORM=$'\[\033[m\]'
CODE_GRAY=$'\[\033[1;30m\]'
PRUSER="\u"
PRTERM=":\l "
PREXIT="${CODE_YELL}\$EXITCODE${CODE_NORM}"
PRPROMPT="$"
if [ "$EUID" = "0" ]; then
  PRUSER="${CODE_RED}\u${CODE_NORM}"
  PRPROMPT="${CODE_RED}#${CODE_NORM}";
fi
    
TITLEBAR="\[\033]0;\w\007\]"
PSTRING=$PREXIT$TITLEBAR${CODE_GREEN}$PRPROMPT${CODE_NORM}

export CLICOLOR=1
export LS_COLORS=exfxcxdxbxegedabagacad
            

# MacPorts Installer addition on 2009-06-28_at_16:43:03: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.

export PS1='\h: [\W]:$ '

alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

alias gst='git status'
alias ga='git add'
alias gca='git commit -v -a'
alias gp='git pull && git push'
alias gl='git pull'
alias gc='git commit -m '
alias gp='git push'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gd='git diff | mate'
alias gls='git log --stat'
alias gl='git log --pretty=oneline'
alias glg='git log --pretty=format:"%h : %s" --topo-order --graph'
# alias logp 'git log --pretty=format:"%h — %an: %s"'
alias gf='git-flow'

alias sst='svn status'
alias ssi='svn info'
alias sco='svn commit -m '
alias sa='svn add '
alias ssu='svn update'
  
alias gist="ruby1.8 /usr/local/bin/gist"

# Working aliases       
alias r='rails'
alias smysql='/Applications/MAMP/bin/startMysql.sh'
alias ss='./script/server'
alias ssd='./script/server --debug'
alias sc='./script/console'     
alias devlog='tail -f log/development.log'
#alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'
# alias cdgems='cd /usr/local/lib/ruby/gems/1.9.1/gems'

# Use this in any RAILS_ROOT dir. That restart.txt file tells mod_rails to restart this app.
# You'll want to do this when (for example) you install a new plugin.
alias restart_rails='touch tmp/restart.txt'

# By default, your app's error log now goes here. Unless you configure your apps otherwise, 
# it's helpful to have an alias to take you to your error log quickly.
alias apache_logs='cd /usr/local/apache2/logs/'

# Dito with hosts
alias hosts='sudo vim /etc/hosts'

# You'll need to restart apache whenever you make a change to vhosts. 
# You can also click System Preference->Sharing->Web Sharing, but this is quicker.
alias apache_restart='sudo apachectl restart'

# export EDITOR=/usr/local/bin/mvim
export EDITOR=mate
set o -vi
                  
# export CLICOLOR=1
# PS1="${CODE_GRAY}\w${CODE_YELL}\$(parse_git_branch) ${CODE_NORM}${TITLEBAR}${PSTRING} "[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh
export GIT_EDITOR="mate -w" 

if [[ -s /Users/vladimirpenkin/.rvm/scripts/rvm ]] ; then source /Users/vladimirpenkin/.rvm/scripts/rvm ; fi
	
# export PS1='\[\033[36m\]\W\[\033[m\] $(__git_ps1 "(\[\033[32m\]%s\[\033[m\]) ")\[\033[31m\]→\[\033[m\] '

export CLICOLOR=1
export LS_COLORS=exfxcxdxbxegedabagacad
export PATH="/Users/vladimirpenkin/narwhal/bin:$PATH"
