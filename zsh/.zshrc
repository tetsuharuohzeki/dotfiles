#----------------------------------------------------------
# Load platform default settings.
#
case ${OSTYPE} in
    darwin*)
        ;;

    linux*)
        ;;
esac

#----------------------------------------------------------
# Prompt
#
autoload -Uz colors && colors
PROMPT="
%{${fg_bold[yellow]}%}%n@%m%{${reset_color}%}:%{${fg_bold[cyan]}%}%~%{${reset_color}%} %# "

# Show the status code returned from the previous command
setopt prompt_percent
PROMPT="%(?..%B%F{red}[status code] %?%f%b )${PROMPT}"


#----------------------------------------------------------
# Alias
#

# Use 'ls -G' as default
alias ls='ls -G'

# Use always vim
alias vi='vim'


#----------------------------------------------------------
# fzf https://github.com/junegunn/fzf#settings
#
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh

    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

    # Compare ripgrep 11.0.2 with fd 7.4.0, ripgrep is slightly faster.
    # For large scale git repository, `git ls-tree -r --name-only HEAD` would be faster.
    # It might be a best way to switch by `direnv`
    export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
    export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --color never'
    # `tree` is pretty faster than `exa --tree`.
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi

#----------------------------------------------------------
# Alias (platform specific)
#
case ${OSTYPE} in
    darwin*)
        # MacVim
        alias mvim='open $1 -a /Applications/MacVim.app'
        alias gvim='mvim'

        # neovim use set as vim if there is it.
        if type nvim >/dev/null 2>&1; then
            alias vim='nvim'
            alias builtin_vim='/usr/bin/vim'
        fi


        # This is disabled since `/bin/zsh` bundled by macOS 10.14 Mojave includes its path by default.
        # local homebrew_prefix='/usr/local'
        # fpath=(
        #   ${homebrew_prefix}/share/zsh/site-functions
        #   ${homebrew_prefix}/share/zsh/site-functions/*(N-/)

        #   $fpath
        # )
        ;;

    linux*)
        ;;
esac


#----------------------------------------------------------
# Completion
#
fpath=(
    ~/.zfunc
    ~/.zfunc/*(N-/)

    $fpath
)
autoload -Uz compinit
compinit -i
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz add-zsh-hook

#----------------------------------------------------------
# Display Git (or other VCS) branch name 
#
autoload -Uz vcs_info

# Allow refer variables in PROMPT
setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' formats ' (%s:%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'

add-zsh-hook precmd vcs_info

# If we wrap `%{${vcs_info_msg_0_}%}` with `""`, this code would not work....`
RPROMPT='%{${fg_bold[cyan]}%}${vcs_info_msg_0_}%{${reset_color}%}'


#----------------------------------------------------------
# Keybinding
#

# Allow to use `delete` key.
bindkey "^[[3~" delete-char


#----------------------------------------------------------
# History
#
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=2000
export SAVEHIST=2000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
