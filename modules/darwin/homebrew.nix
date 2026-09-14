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
      "bitwarden"
      "ticktick"
      "linearmouse"
      "omniwm"
      "microsoft-office"
      "jetbrains-toolbox"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
