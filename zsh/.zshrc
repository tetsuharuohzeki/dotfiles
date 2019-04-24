autoload -Uz compinit; compinit -i

autoload -Uz colors && colors
PROMPT="
%{${fg_bold[yellow]}%}%n@%m%{${reset_color}%}:%{${fg_bold[cyan]}%}%~%{${reset_color}%} %# "

# Allow to completion dirname by <Tab>
zstyle ':completion:*:default' menu select=1

# Use 'ls -G' as default
alias ls='ls -G'

# MacVim
alias mvim='open $1 -a /Applications/MacVim.app'
alias gvim='mvim'

# Use always vim
alias vi='vim'