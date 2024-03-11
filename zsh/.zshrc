# only check zcompdump once a day to improve startup time
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

# Path to your oh-my-zsh installation.
DISABLE_MAGIC_FUNCTIONS=true
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles

ZSH_THEME="robbyrussell"

plugins=(git tmux zsh-autosuggestions)

ZSH_TMUX_AUTOSTART=true

# extended pattern matching
setopt extendedglob

source $ZSH/oh-my-zsh.sh

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[green]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%})"

# change python version as needed
# easier than fiddeling with default system version and breaking stuff
alias python="python3"
alias pip="python -m pip"

alias ls="ls -A --color=auto"

# shortcuts 
alias actv="source .venv/bin/activate"
# TODO: make this into script bin/.local/bin (fzf works with tmux now)
alias newpy='proj=$(find ~/ -maxdepth 3 -type d | fzf) &&
    tmux new-session -s $(basename $proj) -c $proj -d -n "nvim" &&
    tmux send-keys -t $(basename $proj):nvim "actv; nvim" Enter &&
    tmux new-window -t $(basename $proj) -c $proj -n "shell" &&
    tmux send-keys -t $(basename $proj):shell "actv" Enter &&
    tmux switch-client -t $(basename $proj):nvim'

# only needed on windows with wsl
alias explorer="explorer.exe ."

# nvm install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# add stuff to path
export PATH="$HOME/.local/bin:$PATH"

# add dotfile scripts to path
export PATH="$HOME/.dotfiles/scripts:$PATH"

# export PATH="/mnt/c/Windows/system32:$PATH"
 
# copilot aliases
# eval "$(github-copilot-cli alias -- "$0")"

# modular (mojo)
export MODULAR_HOME="$HOME/mokronos/.modular"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# make ctrl-p act like up arrow (take typed text into account)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search # Up
bindkey "^N" down-line-or-beginning-search # Down

# ros shell startup script
source /opt/ros/humble/setup.zsh
export ROS_DOMAIN_ID=21

# colcon autocomplete
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
# colcon annoying notifications suppression
export COLCON_EXTENSION_BLOCKLIST=colcon_core.event_handler.desktop_notification

# ugly fix for path problems with windows executables
# this path segment is there sometimes? like when i start fresh
# but then dissapears at some point, not sure when or why
# then explorer.exe or cmd.exe dont work, stuff doesn't work
export PATH="/usr/lib/wsl/lib:/mnt/c/Program Files/WindowsApps/CanonicalGroupLimited.Ubuntu_2204.3.49.0_x64__79rhkp1fndgsc:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Users/Sebastian Hirt/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/Sebastian Hirt/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
