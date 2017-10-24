
# SSH-AGENT
SSH_ENV="$HOME/.ssh/environment"

# delete old ssh temp folder
function delete_temp {
    if [ -f "$SSH_ENV" ]; then
        PATTERN='SSH_AUTH_SOCK=\(/tmp/ssh-[a-zA-Z0-9]*\)/agent.[0-9]*; export SSH_AUTH_SOCK;'
        SSH_TMP=`cat $SSH_ENV | grep SSH_AUTH_SOCK | sed "s|${PATTERN}|\1|g"`
        rm -rf $SSH_TMP
        echo deleted $SSH_TMP
    fi
}

# start the ssh-agent
function start_agent {
    delete_temp
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
        . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi
