{
  flake.modules.homeManager.dev =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          core.editor = "hx";
        };
      };
    };
}
