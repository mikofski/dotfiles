# KILL SSH-AGENT
eval `ssh-agent -k`
rm "$SSH_ENV"
