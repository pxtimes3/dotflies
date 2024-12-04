{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "vscode-lua" ''
      export LUA_PATH="?.lua;?/init.lua;/home/px/.luarocks/share/lua/5.4/?.lua;/home/px/.luarocks/share/lua/5.4/?/init.lua;;"
      export LUA_CPATH="/home/px/.luarocks/lib/lua/5.4/?.so;;"
      exec ${pkgs.vscode}/bin/code "$@"
    '')
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
      mkhl.direnv
    ];
    globalSnippets = {
      fixme = {
        body = [
          "$LINE_COMMENT FIXME: $0"
        ];
        description = "Insert a FIXME remark";
        prefix = [
          "fixme"
        ];
      };
      todo = {
        body = [
          "$LINE_COMMENT TODO: $0"
        ];
        description = "Insert a TODO remark";
        prefix = [
          "todo"
        ];
      };
    };
    userSettings = {
      "lua.runtime" = {
        "path" = [
          "?.lua"
          "?/init.lua"
          "/home/px/.luarocks/share/lua/5.4/?.lua"
          "/home/px/.luarocks/share/lua/5.4/?/init.lua"
          "${pkgs.lua54Packages.lrexlib-pcre}/share/lua/5.4/?.lua"
          "${pkgs.lua54Packages.lrexlib-pcre}/share/lua/5.4/?/init.lua"
        ];
        "cpath" = [
          "/home/px/.luarocks/lib/lua/5.4/?.so"
          "${pkgs.lua54Packages.lrexlib-pcre}/lib/lua/5.4/?.so"
        ];
        "version" = "Lua 5.4";
      };
      "lua.workspace.library" = [
        "/home/px/.luarocks/lib/lua/5.4"
        "/home/px/.luarocks/share/lua/5.4"
      ];
    };
  };
}