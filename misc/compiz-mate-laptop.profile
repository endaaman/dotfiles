[core]
s0_active_plugins = core;composite;crashhandler;opengl;compiztoolbox;decor;grid;imgjpeg;imgpng;imgsvg;matecompat;mousepoll;move;obs;place;regex;resize;resizeinfo;snap;staticswitcher;text;vpswitch;wall;animation;animationaddon;animationjc;animationplus;commands;dbus;notification;shelf;workarounds;
s0_outputs = 1920x1080+0+0;
s0_close_window_key = <Super>w
s0_unmaximize_window_key = Disabled
s0_window_menu_key = Disabled
s0_window_menu_button = Disabled
s0_toggle_window_maximized_key = <Super>space

[showmouse]
s0_guide_thickness = 0
s0_emitters = 3
s0_color = #ffdf3fff

[shelf]
s0_trigger_key = Disabled
s0_triggerscreen_key = Disabled
s0_inc_button = <Alt><Super>Button2

[staticswitcher]
s0_next_all_key = <Super>Tab
s0_prev_all_key = <Shift><Super>Tab
s0_use_background_color = true
s0_background_color = #333333d9

[grid]
s0_put_top_key = <Control><Super>Up
s0_put_bottom_key = <Control><Super>Down
s0_put_restore_key = <Control><Super>space
s0_top_left_corner_action = 7
s0_top_right_corner_action = 9
s0_bottom_left_corner_action = 1
s0_bottom_right_corner_action = 3

[composite]
s0_unredirect_match = (any) & !(class=Totem) & !(class=MPlayer) & !(class=vlc) & !(class=Plugin-container) & !(class=QtQmlViewer) & !(class=Firefox) & !(class=google-chrome) & !(class=google-chrome-unstable) & !(class=chromium-browser) & !(name=osu!.exe)

[screenshot]
s0_selection_outline_color = #2f2f4f9f
s0_selection_fill_color = #2f2f4f4f

[animationplus]
s0_bonanza_color = #ff3305ff

[firepaint]
s0_fire_color = #ff3305ff

[neg]
s0_window_toggle_key = <Shift><Super>n

[workarounds]
s0_keep_minimized_windows = true
s0_ooo_menu_fix = false
s0_java_fix = false
s0_java_taskbar_fix = false
s0_aiglx_fragment_fix = false
s0_initial_damage_complete_redraw = false

[decor]
s0_active_shadow_color = #00000080
s0_command = emerald --replace

[place]
s0_mode = 1
s0_position_matches = ;
s0_position_x_values = -32768;
s0_position_y_values = -32768;
s0_position_constrain_workarea = false;

[opacify]
s0_toggle_key = <Shift><Super>o

[wallpaper]
s0_bg_image = ;
s0_bg_image_pos = 0;
s0_bg_fill_type = 0;
s0_bg_color1 = #0c170eff;
s0_bg_color2 = #0c170eff;

[animation]
s0_open_effects = animation:Glide 2;animation:Fade;animation:Fade;
s0_open_matches = (type=Normal | Dialog | ModalDialog | Unknown);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd);
s0_close_effects = animation:Glide 2;animation:Fade;animation:Fade;
s0_close_matches = (type=Normal | Dialog | ModalDialog | Unknown) & !(name=gnome-screensaver) & !(name=mate-screenshot);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd) ;
s0_minimize_effects = animation:Glide 2;
s0_unminimize_effects = animation:Glide 2;

[expo]
s0_ground_color1 = #b3b3b3cc
s0_ground_color2 = #b3b3b300

[cubeaddon]
s0_ground_color1 = #b3b3b3cc
s0_ground_color2 = #b3b3b300

[matecompat]
s0_command_terminal = tym
s0_run_command_terminal_key = <Super>t

[wall]
s0_edge_radius = 7
s0_outline_color = #333333d9
s0_background_gradient_base_color = #cccce6d9
s0_background_gradient_highlight_color = #f3f3ffd9
s0_background_gradient_shadow_color = #f3f3ffd9
s0_thumb_gradient_base_color = #33333359
s0_thumb_gradient_highlight_color = #3f3f3f3f
s0_thumb_highlight_gradient_base_color = #fffffff3
s0_thumb_highlight_gradient_shadow_color = #dfdfdfa6
s0_arrow_base_color = #e6e6e6d9
s0_arrow_shadow_color = #dcdcdcd9
s0_left_key = <Super>h
s0_right_key = <Super>l
s0_up_key = <Super>k
s0_down_key = <Super>j
s0_left_window_key = <Shift><Super>h
s0_right_window_key = <Shift><Super>l
s0_up_window_key = <Shift><Super>k
s0_down_window_key = <Shift><Super>j

[ezoom]
s0_zoom_box_outline_color = #2f2f4f9f
s0_zoom_box_fill_color = #2f2f2f4f
s0_spec_target_focus = true

[animationaddon]
s0_beam_color = #7f7f7fff
s0_fire_color = #ff3305ff

[scale]
s0_key_bindings_toggle = true
s0_button_bindings_toggle = true

[put]
s0_put_restore_key = <Super>Insert
s0_put_pointer_key = Disabled

[addhelper]
s0_toggle_key = <Super>o
s0_brightness = 90
s0_saturation = 90
s0_opacity = 90

[resize]
s0_initiate_button = <Alt>Button3
s0_mode = 2

[commands]
s0_command0 = mate-screenshot
s0_command1 = mate-screenshot -a -d 100
s0_command2 = mate-screenshot --window
s0_command3 = tym -e /usr/bin/zsh
s0_run_command0_key = <Shift><Super>p
s0_run_command1_key = <Super>p
s0_run_command2_key = <Alt><Super>p
s0_run_command3_key = <Super>z

[switcher]
s0_next_key = Disabled
s0_prev_key = Disabled
s0_next_all_key = <Super>Tab
s0_prev_all_key = <Shift><Super>Tab
s0_focus_on_switch = true
s0_zoom = 0.600000
s0_use_background_color = true
s0_background_color = #333333f8

[shift]
s0_ground_color1 = #b3b3b3cc
s0_ground_color2 = #b3b3b300

[thumbnail]
s0_thumb_color = #0000007f
s0_font_background_color = #0000007f

[freewins]
s0_circle_color = #54befb80
s0_line_color = #1800ffff
s0_cross_line_color = #1800ffff

[resizeinfo]
s0_gradient_1 = #cccce6cc
s0_gradient_2 = #f3f3f3cc
s0_gradient_3 = #d9d9d9cc
s0_outline_color = #e6e6e6ff

