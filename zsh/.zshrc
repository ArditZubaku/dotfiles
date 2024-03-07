HISTFILE=~/.zsh_history

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Path to your oh-my-zsh installation.
ZSH=~/.oh-my-zsh
# Path to powerlevel10k theme 
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# List of plugins used
plugins=(git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting nvm)
source $ZSH/oh-my-zsh.sh
# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}
# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
# alias ls='eza -1   --icons=auto' # short list
alias ls='lsd' 
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Display Pokemon
# pokemon-colorscripts --no-title -r 1,3,6
export PATH="$PATH:~/azuredatastudio-linux-x64"
export PATH="$PATH:~/azuredatastudio-linux-x64"

eval $(thefuck --alias)

# open() {
#     dolphin "$1" > /dev/null 2>&1 &
# }

alias open='Thunar'
alias cat='bat'
alias tree='exa --tree --level=2'
alias deeptree='exa --tree'
alias latest-branches="git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"

export PATH="/usr/local/bin/gitkraken:$PATH"


# bun completions
[ -s "/home/zubaku92/.bun/_bun" ] && source "/home/zubaku92/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NO_COLOR='\033[0m'

safe_rm() {
    for dir in "$@"; do
        if [[ -d "$dir" && ( (-d "$dir/.git") || (-d "$(git -C "$dir" rev-parse --git-dir 2>/dev/null)") ) ]]; then
            echo -e "\n${YELLOW}${BOLD}Warning:${NO_COLOR} The directory '${GREEN}$dir${NO_COLOR}' is a Git repository."

            local branch=""
            local last_commit=""
            local stash_count=""

            if git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
                branch=$(git -C "$dir" branch --show-current)
                last_commit=$(git -C "$dir" log -1 --pretty=format:"%h - %s")
                stash_count=$(git -C "$dir" stash list | wc -l)
            else
                echo "${RED}Error:${NO_COLOR} Not a Git repository: '$dir'. Skipping Git information."
            fi

            echo "${BOLD}Current branch:${NO_COLOR} ${GREEN}${branch}${NO_COLOR}"
            echo "${BOLD}Last commit:${NO_COLOR} ${GREEN}${last_commit}${NO_COLOR}"

            if [[ $stash_count -gt 0 ]]; then
                echo "${BOLD}Stash count:${NO_COLOR} ${GREEN}${stash_count}${NO_COLOR}"
            else
                echo "${BOLD}Stash count:${NO_COLOR} ${RED}0${NO_COLOR}"
            fi

            echo -e "${BLUE}${BOLD}Are you sure you want to delete this repository? (${GREEN}y${BLUE}/${RED}n${BLUE})${NO_COLOR}"

            while true; do
                echo -n ""
                read -r reply
                case $reply in
                    [Yy]*)
                        echo -e "${RED}Deleting${NO_COLOR} '${GREEN}$dir${NO_COLOR}'..."
                        command rm -rf "$dir"
                        echo "Repository '${GREEN}$dir${NO_COLOR}' has been deleted."
                        break;;
                    [Nn]*)
                        echo "Deletion cancelled for '${GREEN}$dir${NO_COLOR}'."
                        break;;
                    *)
                        echo -e "${YELLOW}Please answer ${GREEN}y${YELLOW} (yes) or ${RED}n${YELLOW} (no).${NO_COLOR}";;
                esac
            done
        else
            command rm -rf "$dir"
        fi
    done
}

alias rm='safe_rm'

alias populate-db='export PGPASSWORD='postgres' 
psql -h localhost -p 5432 -U postgres -d postgres -f fw-dump.sql'

alias personalRepo="git config user.name 'ArditZubaku' && git config user.email 'zubaku92@gmail.com'"

alias workRepo="git config user.name 'Ardit-TelOS' && git config user.email 'ardit.zubaku@telos-labs.com'"


export EDITOR=vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Monitor script
function monitor() {
    # Function to add or update monitor configurations
    update_monitors() {
        # Read the action argument
        local action=$1

        # Path to the monitors.conf file
        local monitors_conf="/home/zubaku92/.config/hypr/monitors.conf"

        # Define the monitor configurations based on the action
        case $action in
            "--up" | "-u")
                config1="# LAPTOP\nmonitor = eDP-1, highres, 1920x1080, 1"
                config2="# ABOVE LAPTOP\n monitor = HDMI-A-1 , highres, 1920x0, 1"
                ;;
            "--right" | "-r")
                config1="# LAPTOP\nmonitor = eDP-1, highres, 1920x1080, 1"
                config2="# TO THE RIGHT OF LAPTOP\nmonitor = HDMI-A-1 , highres, 0x1080, 1"
                ;;
            "--left" | "-l")
                config1="# LAPTOP\nmonitor = eDP-1, highres, 1920x1080, 1"
                config2="# TO THE LEFT OF LAPTOP\nmonitor = HDMI-A-1 , highres, 0x1080, 1"
                ;;
            "--mirror" | "-m")
                config1="# LAPTOP\nmonitor = eDP-1, highres, 1920x1080, 1"
                config2="# MIRROR LAPTOP\nmonitor = HDMI-A-1 , highres, auto, 1, mirror, eDP-1"
                ;;
            *)
                echo "Invalid action. Usage: monitor --up or monitor --right"
                return 1
                ;;
        esac

        # Replace or append the monitor configurations in the monitors.conf file
        echo "" > $monitors_conf
        sed -i "/# LAPTOP/,/#/d" $monitors_conf
        echo -e "$config1\n$config2" >> $monitors_conf

        echo "Monitor configuration updated successfully."
    }

    # Main function
    main() {
        # Read the action argument
        local action=$1

        # Update the monitor configurations
        update_monitors $action
    }

    # Execute main function with provided arguments
    main $@
}

PATH=~/.console-ninja/.bin:$PATH
export PATH="$HOME/.local/bin":$PATH
