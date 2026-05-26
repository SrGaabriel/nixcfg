{ ... }:
{
  programs.git = {
    enable = true;
    extraConfig = {
      core.editor = "hx";
    };
  };

  programs.helix = {
    enable = true;
  };
}
