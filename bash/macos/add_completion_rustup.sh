#!/bin/bash

BASH_COMPLETION_FILE=$(brew --prefix)/etc/bash_completion.d/rustup.bash-completion

if [ -f ${BASH_COMPLETION_FILE} ]; then
    echo "rm ${BASH_COMPLETION_FILE}"
    rm ${BASH_COMPLETION_FILE}
fi

# https://github.com/rust-lang-nursery/rustup.rs/#enable-tab-completion-for-bash-fish-or-zsh
echo "rustup completions bash > ${BASH_COMPLETION_FILE}"
rustup completions bash > ${BASH_COMPLETION_FILE}