#!/usr/bin/zsh
cd ~/repos/ansible
ZSHRC="$HOME/.zshrc"
ZSHRC_CHUNK="
# ANSIBLE_DEV
alias dev-ansible='zsh /home/panda/repos/ansible/setup-tmux.zsh'
# END ANSIBLE_DEV
"

# Check if the zsh_chunk already exists in the .zshrc file
if grep -q "# ANSIBLE_DEV" "$ZSHRC"; then
    # Remove the existing zsh_chunk from the .zshrc file
    #sed -i '/# OPENAI_DEV/,/# END OPENAI_DEV/d' "$ZSHRC"
else
    # Append the new zsh_chunk to the .zshrc file
    echo "$ZSHRC_CHUNK" >> "$ZSHRC"
fi

# Source the .zshrc file to make the updated alias available
source $ZSHRC

# Define the tmux session name
_TMUX_SESSION_NAME="Ansible"
# write a variable the value to set the terminal title
# Coffee unicode character: \u2615
_TERMINAL_TITLE=$(printf '\u2615Ansible\u2615')

# Function to create a new tmux session
create_session() {
    tmux new-session -d -s "$_TMUX_SESSION_NAME"
}

# Function to kill an existing tmux session
kill_session() {
    tmux kill-session -t "$_TMUX_SESSION_NAME"
}

# Function to attach to an existing tmux session by detaching the session to be used
attach_session() {
    tmux attach-session -t "$_TMUX_SESSION_NAME" -d
}

# Function to set up tmux windows and panes
setup_tmux_windows() {
    local terminal_width=$(tput cols)
    local terminal_height=$(tput lines)

    # Create the "Development" window
    #tmux new-window -n "Development" -t "$_TMUX_SESSION_NAME"
    tmux rename-window -t "$_TMUX_SESSION_NAME:0" "Development"
    tmux split-window -h
    tmux select-pane -t 0
    tmux split-window -v
    tmux select-pane -t 0
    #tmux send-keys "export PS1=$_PS1_NEW" C-m
    tmux send-keys "nvim" C-m
    tmux select-pane -t 1
    #tmux send-keys "source ./.venv/bin/activate" C-m
    tmux send-keys "clear" C-m
    tmux select-pane -t 2
    tmux split-window -v
    tmux select-pane -t 2
    tmux resize-pane -y $((terminal_height * 40 / 100))   # Resize the pane to 60% of the terminal height
    #tmux send-keys "source ./.venv/bin/activate" C-m
    #tmux send-keys "PS1=$_PS1_NEW" C-m
    tmux send-keys "watch -c -n 1 'ls -uhl --recursive --sort=time'" C-m
    #tmux send-keys "most README.md" C-m
    tmux select-pane -t 3
    #tmux send-keys "source ./.venv/bin/activate" C-m
    #tmux send-keys "PS1=$_PS1_NEW" C-m
    tmux send-keys "watch -n 1 'git diff --cached'" C-m
    #tmux send-keys "git --no-pager log --graph --pretty=oneline --abbrev-commit --decorate --all $*" C-m
    #tmux send-keys "watch -n 1 'git --no-pager log --color=auto -n 1 -p'" C-m

    # Create the "OpenAI Assistant Integration" window
    tmux new-window -n "Execution" -t "$_TMUX_SESSION_NAME"
    tmux split-window -h                      # Split window horizontally
    tmux select-pane -t 0                     # Select the first pane
    #tmux send-keys "PS1=$_PS1_NEW" C-m
    tmux send-keys "clear" C-m                # Clears the first pane
    tmux select-pane -t 1                     # Selecting the second pane (right)
    tmux split-window -h                      # Split the second pane vertically
    tmux select-pane -t 1                     # Selecting the top pane (top-right)
    tmux split-window -v                      # Split the top-right pane vertically
    tmux select-pane -t 1                     # Selecting the top pane (top-right)
    tmux resize-pane -D 10                    # Resize the top pane downwards by 10 lines
    #tmux send-keys "PS1=$_PS1_NEW" C-m
    tmux send-keys "clear" C-m                # Clears the top pane
    tmux select-pane -t 2                     # Selecting the middle pane (middle-right)
    #tmux send-keys "PS1=$_PS1_NEW" C-m
    tmux send-keys "clear" C-m                # Clears the middle pane
    tmux select-pane -t 3                     # Selecting the bottom pane (bottom-right)
    #tmux send-keys "PS1=$_PS1_NEW" C-m
    tmux send-keys "clear" C-m                # Clears the bottom pane
    tmux previous-window
}

# If --reattach flag run attach_session function, else kill_session and create_session functions
if [[ "$1" == "--reattach" ]]; then
    attach_session
elif [[ "$1" == "--kill" ]]; then
    kill_session
else
    kill_session
    create_session
    setup_tmux_windows
    attach_session
fi

# set the terminal title
echo -ne "\033]0;$_TERMINAL_TITLE\007"
