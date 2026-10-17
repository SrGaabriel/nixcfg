{
  flake.modules.homeManager.dev =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          core.editor = "hx";
          user = {
            name = "Gabriel Minatel";
            email = "gabriel@minatel.dev";
          };
          init.defaultBranch = "main";
        };
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };

      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Gabriel Minatel";
            email = "gabriel@minatel.dev";
          };
          aliases.up = [
            "util"
            "exec"
            "--"
            "sh"
            "-c"
            "jj bookmark move --from @-- --to @- && jj git push"
          ];
        };
      };
    };
}
