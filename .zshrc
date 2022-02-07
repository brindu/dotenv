# Path to your oh-my-zsh installation.
export ZSH=/Users/alexandre/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="agnoster"

#Uncomment to show the user@host name in the console prompt
#DEFAULT_USER="alexandre"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(rails git ruby)

# User configuration

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/usr/local/opt/postgresql@12/bin:/Users/alexandre/.rvm/gems/ruby-2.2.2/bin:/Users/alexandre/.rvm/gems/ruby-2.2.2@global/bin:/Users/alexandre/.rvm/rubies/ruby-2.2.2/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/alexandre/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.crenv/bin:$PATH"
eval "$(crenv init -)"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# get the name of the ruby version
rvm_prompt_info() {
  [ -f /usr/local/rvm/bin/rvm-prompt ] || [ -f $HOME/.rvm/bin/rvm-prompt ] || return
  local rvm_prompt
  if [ -f $HOME/.rvm/bin/rvm-prompt ] ; then
    rvm_prompt=$($HOME/.rvm/bin/rvm-prompt ${ZSH_THEME_RVM_PROMPT_OPTIONS} 2>/dev/null)
  fi
  if [ -f /usr/local/rvm/bin/rvm-prompt ] ; then
    rvm_prompt=$(/usr/local/rvm/bin/rvm-prompt ${ZSH_THEME_RVM_PROMPT_OPTIONS} 2>/dev/null)
  fi
  [[ "${rvm_prompt}x" == "x" ]] && return
  echo "[%{$fg_bold[red]%}${rvm_prompt}%{$reset_color%}]" | sed "s/ruby-//"
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# completion
autoload -U compinit
compinit

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# use incremental search
bindkey "^R" history-incremental-search-backward

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

# Try to correct command line spelling
setopt CORRECT

# Enable extended globbing
setopt EXTENDED_GLOB

# prompt
export RPS1='$(git_prompt_info)$(rvm_prompt_info)'

# for root
# use http://www.nparikh.org/unix/prompt.php#zsh for moar config
if [ "`id -u`" -eq 0 ]; then
  export PS1="%B%{$fg[yellow]%}%T%{$reset_color%}%b " # hour in bold yellow + space
  PS1+="%B%{$fg[red]%}%n%{$reset_color%}%b"           # user in bold red
  PS1+="%B%{$fg[yellow]%}@%{$reset_color%}%b"         # @ in bold yellow
  PS1+="%B%{$fg[green]%}%m%{$reset_color%}%b "        # short hostname in bold green
  PS1+="%B%{$fg[green]%}%~%{$reset_color%}%b"         # pwd in bold green
  PS1+="%B%{$fg[yellow]%}%#%{$reset_color%}%b "       # prompt delimitor in bold yellow + space
else
  export PS1="%B%{$fg[yellow]%}%T%{$reset_color%}%b " # hour in bold yellow + space
  PS1+="%B%{$fg[green]%}%n%{$reset_color%}%b"         # user in bold green
  PS1+="%B%{$fg[yellow]%}@%{$reset_color%}%b"         # @ in bold yellow
  PS1+="%B%{$fg[red]%}%m%{$reset_color%}%b "          # short hostname in bold red
  PS1+="%B%{$fg[green]%}%~%{$reset_color%}%b"         # pwd in bold green
  PS1+="%B%{$fg[yellow]%}%#%{$reset_color%}%b "       # prompt delimitor in bold yellow + space
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

# added by travis gem
[ -f /Users/alexandre/.travis/travis.sh ] && source /Users/alexandre/.travis/travis.sh

# For GPG
GPG_TTY=$(tty)
export GPG_TTY

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
