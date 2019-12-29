[matecompat]
s0_command_terminal = tym
s0_run_command_terminal_key = <Super>t

[commands]
s0_command0 = mate-screenshot
s0_command1 = mate-screenshot -a -d 100
s0_command2 = mate-screenshot --window
s0_command3 = tym -e /usr/bin/zsh
s0_run_command0_key = <Shift><Super>p
s0_run_command1_key = <Super>p
s0_run_command2_key = <Alt><Super>p
s0_run_command3_key = <Super>z

[composite]
s0_unredirect_match = (any) & !(class=Totem) & !(class=MPlayer) & !(class=vlc) & !(class=Plugin-container) & !(class=QtQmlViewer) & !(class=Firefox) & !(class=google-chrome) & !(class=google-chrome-unstable) & !(class=chromium-browser) & !(name=osu!.exe)

[addhelper]
s0_toggle_key = <Super>o
s0_brightness = 90
s0_saturation = 90
s0_opacity = 90

[switcher]
s0_next_all_key = <Super>Tab
s0_prev_all_key = <Shift><Super>Tab
s0_focus_on_switch = true
s0_zoom = 0.600000
s0_use_background_color = true
s0_background_color = #333333f8

[place]
s0_mode = 1
s0_position_matches = ;
s0_position_x_values = -32768;
s0_position_y_values = -32768;
s0_position_constrain_workarea = false;

[workarounds]
s0_keep_minimized_windows = true
s0_ooo_menu_fix = false
s0_java_fix = false
s0_java_taskbar_fix = false
s0_aiglx_fragment_fix = false
s0_initial_damage_complete_redraw = false

[shelf]
s0_trigger_key = Disabled
s0_triggerscreen_key = Disabled
s0_inc_button = <Alt><Super>Button2

[resize]
s0_initiate_button = <Alt>Button3
s0_mode = 2

[neg]
s0_window_toggle_key = <Shift><Super>n

[wall]
s0_edge_radius = 7
s0_left_key = <Super>Left
s0_right_key = <Super>Right
s0_up_key = <Super>Up
s0_down_key = <Super>Down
s0_left_window_key = <Shift><Super>Left
s0_right_window_key = <Shift><Super>Right
s0_up_window_key = <Shift><Super>Up
s0_down_window_key = <Shift><Super>Down

[staticswitcher]
s0_next_all_key = <Super>Tab
s0_prev_all_key = <Shift><Super>Tab
s0_use_background_color = true

[opacify]
s0_toggle_key = <Shift><Super>o

[scale]
s0_key_bindings_toggle = true
s0_button_bindings_toggle = true

[core]
s0_active_plugins = core;composite;crashhandler;opengl;compiztoolbox;decor;imgjpeg;imgpng;imgsvg;matecompat;mousepoll;move;obs;place;regex;resize;scale;snap;staticswitcher;text;thumbnail;vpswitch;wall;wallpaper;animation;animationaddon;animationjc;animationplus;commands;dbus;notification;shelf;workarounds;
s0_outputs = 1920x1080+0+0;
s0_close_window_key = <Super>w
s0_unmaximize_window_key = Disabled
s0_window_menu_key = Disabled
s0_window_menu_button = Disabled
s0_toggle_window_maximized_key = <Super>space
s0_hsize = 3
s0_vsize = 2

[grid]
s0_put_restore_key = <Control><Super>space
s0_top_left_corner_action = 7
s0_top_right_corner_action = 9
s0_bottom_left_corner_action = 1
s0_bottom_right_corner_action = 3

[animation]
s0_open_effects = animation:Glide 2;animation:Fade;animation:Fade;
s0_open_matches = (type=Normal | Dialog | ModalDialog | Unknown);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd);
s0_close_effects = animation:Glide 2;animation:Fade;animation:Fade;
s0_close_matches = (type=Normal | Dialog | ModalDialog | Unknown) & !(name=gnome-screensaver) & !(name=mate-screenshot);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd) ;
s0_minimize_effects = animation:Glide 2;
s0_unminimize_effects = animation:Glide 2;

[wallpaper]
s0_bg_image = ;
s0_bg_image_pos = 0;
s0_bg_fill_type = 0;
s0_bg_color1 = #0c170eff;
s0_bg_color2 = #0c170eff;

[put]
s0_put_pointer_key = Disabled

[decor]
s0_command = emerald --replace

