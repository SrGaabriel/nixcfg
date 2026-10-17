{
  flake.modules.nixos.ollama =
    { pkgs, lib, ... }:
    {
      services.ollama = {
        enable = true;
        package = pkgs.ollama-rocm;
        loadModels = [ "qwen2.5-coder:32b" ];
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "8192";
          OLLAMA_FLASH_ATTENTION = "1";
          OLLAMA_KV_CACHE_TYPE = "q8_0";
          OLLAMA_GPU_OVERHEAD = toString (2 * 1024 * 1024 * 1024);
        };
      };

      systemd.services.ollama.wantedBy = lib.mkForce [ ];
      systemd.services.ollama-model-loader.wantedBy = lib.mkForce [ "ollama.service" ];
    };
}
