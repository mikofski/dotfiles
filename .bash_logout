#!/usr/bin/bash

# KILL SSH-AGENT & REMOVE SSH ENVIRONMENT
eval `ssh-agent -k`
if [[ -f $SSH_ENV ]]; then
    rm $SSH_ENV;
fi

