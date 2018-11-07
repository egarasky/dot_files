# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export TERM='xterm-256color'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH=$PATH:/usr/local/bin/node_modules
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
bind "\C-t":forward-search-history

if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

# for less notes https://github.com/pimterry/notes
EDITOR=vim


# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

#set Less input preprocessor for https://github.com/wofr06/lesspipe.git from https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
if type lesspipe.sh >/dev/null 2>&1; then
	  export LESSOPEN='|lesspipe.sh %s'
fi
#set pygment for better syntax highlight, see: http://pygments.org/ and https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
if type pygmentize >/dev/null 2>&1; then
  export LESSCOLORIZER='pygmentize'
fi

#gradle
export GRADLE_HOME=/usr/local/gradle
export PATH=${GRADLE_HOME}/bin:${PATH}


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/eric/.sdkman"
[[ -s "/home/eric/.sdkman/bin/sdkman-init.sh" ]] && source "/home/eric/.sdkman/bin/sdkman-init.sh"



#prompt customization
GREEN="\[$(tput setaf 2)\]"
TEAL="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
PROMPT_DIR='\w'
command_prompt_fn(){
    if [ "${#PWD}" -gt 60 ]
    then
        PS1="${GREEN}\[\e]0;\u@\h:\W\a\]${debian_chroot:+($debian_chroot)}\u@\h:\${RESET}W${TEAL} ▷ " 
    else
        PS1="${GREEN}\[\e]0;\u@\h:\w\a\]${debian_chroot:+($debian_chroot)}\u@\h:${RESET}\w ${TEAL}▷ "
    fi
}
PROMPT_COMMAND='command_prompt_fn';
export PS1
