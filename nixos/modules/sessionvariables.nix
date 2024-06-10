{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
	home.sessionVariables = {
		editor = "subl";
		TASKRC = "~/.config/task/taskrc";
		TASKDATA = "~/.config/taskdata";
	};
}