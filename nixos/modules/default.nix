# modules/default.nix
{ config, pkgs, ... }:

let
  # Import top-level modules
  moduleDir = ./.;
  moduleFiles = builtins.filter 
    (n: builtins.match ".*\\.nix" n != null && n != "default.nix") 
    (builtins.attrNames (builtins.readDir moduleDir));
  topModules = map (file: import (moduleDir + "/${file}")) moduleFiles;
  
  # Import subdirectories with default.nix
  dirNames = builtins.filter
    (n: builtins.pathExists (moduleDir + "/${n}/default.nix"))
    (builtins.attrNames (builtins.readDir moduleDir));
  subModules = map (dir: import (moduleDir + "/${dir}")) dirNames;
in
{
  imports = topModules ++ subModules;
}
