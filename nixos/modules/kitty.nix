{
  pkgs,
  config,
  ...
}:
{
  programs.kitty = {
    enable = true;
    settings = ''{
      shell = fish
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;

      font_family       = "JetBrainsMono Nerd Font Regular";
      bold_font         = "JetBrainsMono Nerd Font Bold";
      italic_font       = "JetBrainsMono Nerd Font Italic";
      bold_italic_font  = "JetBrainsMono Nerd Font Bold Italic";

      font_size         = 12.0;

      cursor_stop_blinking_after = -1;

      select_by_word_characters @-./_~?&=%+#;

      foreground         = #e6e6dc;
      background         = #002635;
      background_opacity = 1.0;

      kitty_mod          = ctrl+shift;

      map ctrl+up        = scroll_line_up;
      map ctrl+k         = scroll_line_up;
      map ctrl+down      = scroll_line_down;
      map ctrl+j         = scroll_line_down;
      map ctrl+page_up   = scroll_page_up;
      map ctrl+page_down = scroll_page_down;
      map ctrl+home      = scroll_home;
      map ctrl+end       = scroll_end;
      map kitty_mod+h    = show_scrollback;

      map ctrl+w         = close_window;
      map kitty_mod+]    = next_window;
      map kitty_mod+[    = previous_window;
      map kitty_mod+f    = move_window_forward;
      map kitty_mod+b    = move_window_backward;
      map kitty_mod+`    = move_window_to_top;
      map kitty_mod+r    = start_resizing_window;
      map kitty_mod+1    = first_window;
      map kitty_mod+2    = second_window;
      map kitty_mod+3    = third_window;
      map kitty_mod+4    = fourth_window;
      map kitty_mod+5    = fifth_window;
      map kitty_mod+6    = sixth_window;
      map kitty_mod+7    = seventh_window;
      map kitty_mod+8    = eighth_window;
      map kitty_mod+9    = ninth_window;
      map kitty_mod+0    = tenth_window;

      map kitty_mod+right = next_tab;
      map kitty_mod+left  = previous_tab;
      map kitty_mod+t     = new_tab;
      map kitty_mod+q     = close_tab;
      map kitty_mod+.     = move_tab_forward;
      map kitty_mod+,     = move_tab_backward;
      map kitty_mod+alt+t = set_tab_title;

    }'';
  };
}