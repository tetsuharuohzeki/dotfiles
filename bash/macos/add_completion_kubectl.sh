#!/bin/bash

BASH_COMPLETION_KUBECTL=$(brew --prefix)/etc/bash_completion.d/kubectl

if [ -f ${BASH_COMPLETION_KUBECTL} ]; then
    echo "rm ${BASH_COMPLETION_KUBECTL}"
    rm ${BASH_COMPLETION_KUBECTL}
fi

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
echo "kubectl completion bash > ${BASH_COMPLETION_KUBECTL}"
kubectl completion bash > ${BASH_COMPLETION_KUBECTL}