{pkgs, ...}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${catppuccinDrv}";
        "font" = "JetBrains Mono Nerd Font:size=10";
        "shell" = "fish";
      };
      "scrollback" = {
        "lines" = 10000;
      };
      # https://codeberg.org/dnkl/foot/raw/branch/master/foot.ini
    };
  };
}
