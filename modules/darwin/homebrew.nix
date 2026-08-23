{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "uninstall";
      autoUpdate = false;
      upgrade = false;
    };

    taps = [
      {
        name = "BarutSRB/tap";
        trusted = true;
      }
    ];

    casks = [
      "ghostty"
      "spotify"
      "signal"
      "obsidian"
      "ticktick"
      "claude-code"
      "bitwarden"
      "jetbrains-toolbox"
      "omniwm"
    ];
  };
}
