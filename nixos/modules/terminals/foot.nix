{pkgs, ...}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  tokyonightStorm = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/tokyonight-storm";
    hash = "sha256-V6IvefUH5CkbcAv868Ag0m4egIctqCmQFVtwwQByg3U=";
  };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${tokyonightStorm}";
        "font" = "JetBrains Mono Nerd Font:size=10";
        "shell" = "fish";
        "term" = "xterm-256color";
      };
      "scrollback" = {
        "lines" = 10000;
      };

      # https://codeberg.org/dnkl/foot/raw/branch/master/foot.ini
    };
  };
}
