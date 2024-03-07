#!/usr/bin/env sh

# Fetch list of open windows with their workspace numbers using hyprctl, excluding unwanted workspaces
window_list=$(hyprctl clients | awk '
  BEGIN {id = ""; workspace = ""; title = "";}
  /id: / {id = $2}
  /workspace: / {workspace = $2}
  /title: / {
    gsub("\t*title: *", "");
    title = $0
  }
  workspace != "-1" && title != "" {
    print workspace ": " title
    title = ""; # Reset title for the next entry
  }
')

# Use rofi to let the user select a window, showing workspace number and title
selected_window=$(echo "$window_list" | rofi -dmenu -i -p "Switch to:")

# Extract the title from the selection
selected_title=$(echo "$selected_window" | sed 's/^[0-9]*: //')

# Focus the selected window using hyprctl and the extracted title
if [ -n "$selected_title" ]; then
    hyprctl dispatch focuswindow "title:${selected_title}"
fi
