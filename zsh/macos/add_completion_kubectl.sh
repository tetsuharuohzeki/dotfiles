#!/bin/zsh

ZSH_COMPLETION_DIR=${HOME}/.zfunc
ZSH_COMPLETION_FILE=${ZSH_COMPLETION_DIR}/_kubectl

if [ -f ${ZSH_COMPLETION_FILE} ]; then
    echo "rm ${ZSH_COMPLETION_FILE}"
    rm ${ZSH_COMPLETION_FILE}
fi

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
CMD="kubectl completion zsh"
echo "${CMD} > ${ZSH_COMPLETION_FILE}"
eval ${CMD} > ${ZSH_COMPLETION_FILE}