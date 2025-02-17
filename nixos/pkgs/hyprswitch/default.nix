# ~/.config/nixos/pkgs/hyprswitch/default.nix
{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, json-c
}:

stdenv.mkDerivation {
  pname = "hyprswitch";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "ErikReider";
    repo = "hyprswitch";
    rev = "291_51a21435a11a7cf38736722873dbad3"; # Latest commit as of now
    sha256 = "sha256-0000000000000000000000000000000000000000000="; # We'll get the real hash from the error
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ json-c ];

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "A window switcher for Hyprland";
    homepage = "https://github.com/ErikReider/hyprswitch";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
