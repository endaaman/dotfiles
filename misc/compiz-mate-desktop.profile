[staticswitcher]
s0_next_all_key = <Super>Tab
s0_prev_all_key = <Shift><Super>Tab
s0_auto_change_vp = true
s0_mouse_select = true
s0_mipmap = false
s0_focus_on_switch = true
s0_use_background_color = true
s0_background_color = #3d3846ff

[wall]
s0_left_key = <Super>Left
s0_right_key = <Super>Right
s0_up_key = <Super>Up
s0_down_key = <Super>Down
s0_left_window_key = <Shift><Super>Left
s0_right_window_key = <Shift><Super>Right
s0_up_window_key = <Shift><Super>Up
s0_down_window_key = <Shift><Super>Down

[opacify]
s0_toggle_key = Disabled

[opengl]
s0_texture_filter = 2

[resize]
s0_initiate_button = <Alt>Button3
s0_initiate_key = <Super>s

[shelf]
s0_trigger_key = Disabled
s0_triggerscreen_key = Disabled

[grid]
s0_put_restore_key = <Super>q

[matecompat]
s0_run_key = <Super>r
s0_command_terminal = wmctrl -x -a tym  || tym &
s0_run_command_terminal_key = <Super>t

[place]
s0_mode = 1

[resizeinfo]
s0_always_show = true

[animation]
s0_open_matches = (type=Normal | Dialog | ModalDialog | Unknown) & !(name=gnome-screensaver) & !(name=mate-screensaver);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd);
s0_close_effects = animation:Glide 2;animation:Fade;animation:Fade;
s0_close_options = tickness=1;;;
s0_minimize_effects = animation:Glide 2;
s0_unminimize_effects = animation:Glide 2;
s0_shade_effects = animation:None;
s0_focus_durations = 50;

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

[composite]
s0_refresh_rate = 50

[core]
s0_active_plugins = core;composite;crashhandler;opengl;compiztoolbox;imgjpeg;maximumize;decor;grid;imgpng;imgsvg;matecompat;mblur;mousepoll;move;place;regex;resize;resizeinfo;staticswitcher;text;wall;animation;animationaddon;animationplus;animationsim;annotate;blur;commands;dbus;notification;obs;workarounds;
s0_outputs = 2560x1440+1920+0;1920x1080+0+196;
s0_close_window_key = <Super>w
s0_maximize_window_key = Disabled
s0_unmaximize_window_key = Disabled
s0_window_menu_button = <Alt>Button2
s0_toggle_window_maximized_key = <Super>space
s0_hsize = 3
s0_vsize = 2

[decor]
s0_command = emerald --replace

[workarounds]
s0_keep_minimized_windows = true

