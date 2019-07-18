autoload -Uz colors && colors
PROMPT="
%{${fg_bold[yellow]}%}%n@%m%{${reset_color}%}:%{${fg_bold[cyan]}%}%~%{${reset_color}%} %# "

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

fpath=(
    ~/.zfunc
    ~/.zfunc/*(N-/)

    $fpath
)
autoload -Uz compinit
compinit -i
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#----------------------------------------------------------
# Display Git (or other VCS) branch name 
#
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

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
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history



#----------------------------------------------------------
# Zsh support for Apple Terminal.
# Tell the terminal about the working directory whenever it changes.
#
# The base is /etc/bashrc_Apple_Terminal
# see
#   - https://apple.stackexchange.com/questions/128998/how-to-open-a-new-terminal-tab-in-current-working-directory
#   - http://superuser.com/a/328148/180983
#   - https://github.com/fish-shell/fish-shell/blob/82052a6cc9fa797070d8945130d45226d5cbc1c5/share/functions/__fish_config_interactive.fish#L266-L276
#   - http://hints.macworld.com/article.php?story=20110722211753852
# By http://superuser.com/a/328148/180983
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL, including
        # the host name to disambiguate local vs. remote paths.

        # Percent-encode the pathname.
        local url_path=''
        {
            # Use LC_CTYPE=C to process text byte-by-byte. Ensure that
            # LC_ALL isn't set, so it doesn't interfere.
            local i ch hexch LC_CTYPE=C LC_ALL=
            for ((i = 1; i <= ${#PWD}; ++i)); do
                ch="$PWD[i]"
                if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                    url_path+="$ch"
                else
                    printf -v hexch "%02X" "'$ch"
                    url_path+="%$hexch"
                fi
            done
        }

        printf '\e]7;%s\a' "file://$HOST$url_path"
    }

    # Register the function so it is called at each prompt.
    autoload add-zsh-hook
    add-zsh-hook precmd update_terminal_cwd
fi

# Copy from /etc/zshrc in macOS 10.14
# Correctly display UTF-8 with combining characters.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    setopt combiningchars
fi

# Copy from /etc/zshrc in macOS 10.14
disable log