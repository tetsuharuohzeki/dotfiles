#!/bin/zsh

ZSH_COMPLETION_DIR=${HOME}/.zfunc
ZSH_COMPLETION_FILE=${ZSH_COMPLETION_DIR}/_cargo

if [ -f ${ZSH_COMPLETION_FILE} ]; then
    echo "rm ${ZSH_COMPLETION_FILE}"
    rm ${ZSH_COMPLETION_FILE}
fi

# https://github.com/rust-lang-nursery/rustup.rs/#enable-tab-completion-for-bash-fish-or-zsh
CMD="rustup completions zsh cargo"
echo "${CMD} > ${ZSH_COMPLETION_FILE}"
eval ${CMD} > ${ZSH_COMPLETION_FILE}