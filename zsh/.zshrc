autoload -Uz compinit; compinit -i

autoload -Uz colors && colors
PROMPT="
%{${fg_bold[yellow]}%}%n@%m%{${reset_color}%}:%{${fg_bold[cyan]}%}%~%{${reset_color}%} %# "

# Allow to completion dirname by <Tab>
zstyle ':completion:*:default' menu select=1

# Use 'ls -G' as default
alias ls='ls -G'

# Use always vim
alias vi='vim'

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

case ${OSTYPE} in
    darwin*)
        HOMEBREW_PATH='/usr/local'

        # MacVim
        alias mvim='open $1 -a /Applications/MacVim.app'
        alias gvim='mvim'

        ;;

    linux*)
        ;;
esac


#----------------------------------------------------------
# Display Git (or other VCS) branch name 
#
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# Allow refer variables in PROMPT
setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'

add-zsh-hook precmd vcs_info

# If we wrap `%{${vcs_info_msg_0_}%}` with `""`, this code would not work....`
PROMPT='
%{${fg_bold[yellow]}%}%n@%m%{${reset_color}%}:%{${fg_bold[cyan]}%}%~%{${vcs_info_msg_0_}%}%{${reset_color}%}%# '

