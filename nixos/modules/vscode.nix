{
  config,
  pkgs,
  ...
}: 

{
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
  };
}
