{ lib, pkgs, ... }:
let
  tomlFormat = pkgs.formats.toml { };

  numbered =
    prefix: f:
    builtins.listToAttrs (
      map (n: {
        name = "${prefix}.${toString (n - 1)}";
        value = f n;
      }) (lib.range 1 9)
    );

  hotkeys = {
    "focus.left" = "Option+Left Arrow";
    "focus.down" = "Option+Down Arrow";
    "focus.up" = "Option+Up Arrow";
    "focus.right" = "Option+Right Arrow";

    "moveColumn.left" = "Control+Option+Left Arrow";
    "moveColumn.right" = "Control+Option+Right Arrow";
    "move.down" = "Control+Option+Down Arrow";
    "move.up" = "Control+Option+Up Arrow";

    "moveWindowToMonitor.left" = "Control+Option+Shift+Left Arrow";
    "moveWindowToMonitor.down" = "Control+Option+Shift+Down Arrow";
    "moveWindowToMonitor.up" = "Control+Option+Shift+Up Arrow";
    "moveWindowToMonitor.right" = "Control+Option+Shift+Right Arrow";
    "moveWindowToWorkspaceDown" = "Unassigned";
    "moveWindowToWorkspaceUp" = "Unassigned";

    "switchWorkspace.next" = "Option+U";
    "switchWorkspace.previous" = "Option+I";
    "moveColumnToWorkspaceDown" = "Control+Option+U";
    "moveColumnToWorkspaceUp" = "Control+Option+I";

    "consumeWindowIntoColumn" = "Option+Comma";
    "expelWindowFromColumn" = "Option+Period";

    "cycleSizeForward" = "Option+R";
    "cycleWindowSecondarySpanForward" = "Option+Shift+R";
    "toggleContainerFullPrimarySpan" = "Option+F";
    "toggleFullscreen" = "Option+Shift+F";
    "centerColumn" = "Option+C";
    "centerVisibleColumns" = "Control+Option+C";
    "toggleFocusedWindowFloating" = "Option+V";
    "toggleColumnTabbed" = "Option+W";

    "toggleOverview" = "Option+O";
    "openCommandPalette" = "Option+D";
    "toggleQuakeTerminal" = "Option+T";
    "focusMonitorNext" = "Option+Tab";

    "focusPrevious" = "Unassigned";
    "cycleSizeBackward" = "Unassigned";
    "raiseAllFloatingWindows" = "Unassigned";
  }
  // numbered "focusColumn" (_: "Unassigned")
  // numbered "moveColumnToWorkspace" (n: "Control+Option+${toString n}");
in
{
  programs.nushell.extraEnv = ''
    use std/util "path add"
    path add [
      ($nu.home-dir | path join ".nix-profile" "bin")
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/usr/local/bin"
    ]
  '';

  home.activation.defaultTerminal = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for uti in public.unix-executable public.shell-script com.apple.terminal.shell-script; do
      run ${lib.getExe' pkgs.duti "duti"} -s com.mitchellh.ghostty "$uti" all \
        || echo "warning: could not set ghostty as the handler for $uti" >&2
    done
  '';

  xdg.configFile."ghostty/config".text = ''
    background-opacity = 0.95
    background-blur-radius = 20
    macos-option-as-alt = true
    macos-titlebar-style = tabs
  '';

  xdg.configFile."omniwm/settings.toml".source = tomlFormat.generate "omniwm-settings.toml" {
    general.ipcEnabled = true;
    workspaceBar.enabled = false;

    gestures = {
      workspaceSwipeEnabled = true;
      workspaceSwipeAxis = "vertical";
      workspaceSwipeFingerCount = 3;
    };

    borders = {
      width = 2.0;
      color = {
        red = 0.776;
        green = 0.627;
        blue = 0.965;
        alpha = 1.0;
      };
    };

    hotkeys = lib.mapAttrsToList (id: binding: { inherit id binding; }) hotkeys;
  };
}
