# prompt display
## `\n` + Ubuntu's config
PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# for macOS
HOMEBREW_PREFIX=`brew --prefix`

# complete git commands
if [ -f $HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash ]; then
  source $HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash
fi

# display git branch name
if [ -f $HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh ]; then
  source $HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh
  PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1)\[\033[00m\]\$ '
fi

# bash-completion
if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then
  source $HOMEBREW_PREFIX/etc/bash_completion
fi

# Use 'ls -G' as default
alias ls="ls -G"

# MacVim
alias mvim="open $1 -a /Applications/MacVim.app"
alias gvim="open $1 -a /Applications/MacVim.app --args --remote-tab-silent"

# Use always vim
alias vi="vim"

# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

HISTSIZE=1000
HISTFILESIZE=1000
HISTCONTROL=ignoreboth
shopt -s histappend