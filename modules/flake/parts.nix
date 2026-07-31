{ inputs, ... }:
{
  # Declares the `flake.modules.<class>.<name>` option that every aspect
  # file writes into. Without this, flake-parts has no schema to merge them.
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
}
