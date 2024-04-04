{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",screen-256color:Tc"

    #
    # Tokyonight theme
    #

    # Status update interval
    set -g status-interval 1

    #
    # Colors
    #
    tmux_status_bg=#232433
    tmux_status_fg=colour7

    #first set of side status
    tmux_status_bg_1=colour8
    tmux_status_fg_1=colour4

    #second set of side status
    tmux_status_bg_2=colour4
    tmux_status_fg_2=colour0

    tmux_accent=colour1
    tmux_current_title_fg=colour2
    tmux_activity_color=colour3

    # Basic status bar colors
    set -g status-style bg=$tmux_status_bg

    # Left side of status bar
    set -g status-left-style bg=colour233,fg=colour243
    set -g status-left-length 40
    set -g status-left ""

    # Right side of status bar
    set -g status-right-style bg=colour233,fg=colour243
    set -g status-right-length 150
    set -g status-right "#[fg=$tmux_accent,bg=$tmux_status_bg_1,bold] %H:%M:%S #[fg=$tmux_status_fg_2,bg=$tmux_status_bg_2,nobold] %a %d %b %y "

    # Window status
    set -g window-status-format "#[fg=$tmux_status_fg_1,bg=$tmux_status_bg_1] #I #[fg=default,bg=default] #W #[default]"
    set -g window-status-current-format "#[fg=$tmux_accent,bg=$tmux_status_bg_1,bold] #I:#P #[fg=$tmux_current_title_fg,bg=$tmux_status_bg,bold] #W #[default]"

    # Current window status
    set -g window-status-current-style none

    # Window with activity status
    set -g window-status-activity-style bg="$tmux_status_bg",fg="$tmux_activity_color"

    # Window separator
    set -g window-status-separator ""

    # Window status alignment
    set -g status-justify centre

    # Pane border
    set -g pane-border-style bg=default,fg="$tmux_status_bg"

    # Active pane border
    set -g pane-active-border-style bg=default,fg="$tmux_status_bg_2"

    # Pane number indicator
    set -g display-panes-colour "$tmux_status_bg_2"
    set -g display-panes-active-colour "$tmux_accent"


    # Clock mode
    set -g clock-mode-colour "$tmux_status_bg_2"
    set -g clock-mode-style 24
    '';
  };
}
