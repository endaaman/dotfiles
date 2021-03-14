[core]
s0_active_plugins = core;composite;crashhandler;opengl;compiztoolbox;imgjpeg;maximumize;decor;grid;imgpng;imgsvg;matecompat;mblur;mousepoll;move;place;regex;resize;resizeinfo;staticswitcher;text;wall;animation;animationaddon;animationplus;animationsim;annotate;blur;commands;dbus;notification;obs;workarounds;
s0_close_window_key = <Super>w
s0_maximize_window_key = Disabled
s0_unmaximize_window_key = Disabled
s0_window_menu_button = <Alt>Button2
s0_toggle_window_maximized_key = <Super>space
s0_hsize = 3
s0_vsize = 2

[shelf]
s0_trigger_key = Disabled
s0_triggerscreen_key = Disabled

[staticswitcher]
s0_next_all_key = <Super>Tab
s0_prev_all_key = <Shift><Super>Tab

[grid]
s0_put_restore_key = <Super>q

[workarounds]
s0_keep_minimized_windows = true

[decor]
s0_command = emerald --replace

[place]
s0_mode = 1

[opacify]
s0_toggle_key = Disabled

[animation]
s0_open_matches = (type=Normal | Dialog | ModalDialog | Unknown) & !(name=gnome-screensaver) & !(name=mate-screensaver);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd);
s0_close_effects = animation:Glide 2;animation:Fade;animation:Fade;
s0_close_options = tickness=1;;;
s0_minimize_effects = animation:Glide 2;
s0_unminimize_effects = animation:Glide 2;
s0_shade_effects = animation:None;
s0_focus_durations = 50;

[matecompat]
s0_run_key = <Super>r

[wall]
s0_left_key = <Super>h
s0_right_key = <Super>l
s0_up_key = <Super>k
s0_down_key = <Super>j
s0_left_window_key = <Shift><Super>h
s0_right_window_key = <Shift><Super>l
s0_up_window_key = <Shift><Super>k
s0_down_window_key = <Shift><Super>j

[resize]
s0_initiate_button = <Alt>Button3
s0_initiate_key = <Super>s

[commands]
s0_command0 = mate-screenshot -a -d 100
s0_command1 = mate-screenshot
s0_command2 = mate-screenshot -w
s0_command3 = tym -e /usr/bin/zsh
s0_command4 = wmctrl -x -a tym || tym
s0_run_command0_key = <Super>p
s0_run_command1_key = <Shift><Super>p
s0_run_command2_key = <Alt><Super>p
s0_run_command3_key = <Super>z
s0_run_command4_key = <Super>t

[resizeinfo]
s0_always_show = true

