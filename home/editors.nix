{ pkgs, ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_latte";

      editor = {
        mouse = true;
        true-color = true;
        line-number = "relative";
        bufferline = "multiple";
        idle-timeout = 0;
        rulers = [ 80 ];
        cursorline = true;
        gutters = [
          "diagnostics"
          "line-numbers"
          "spacer"
          "diff"
        ];

        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "error";
        };

        auto-save = {
          after-delay = {
            timeout = 300;
            enable = true;
          };
          focus-lost = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };

    languages = {
      use-grammars = {
        only = [
          "rust"
          "markdown"
          "toml"
          "bash"
          "soma"
          "lean"
          "haskell"
        ];
      };

      language = [
        {
          name = "rust";
          auto-format = false;
        }
        {
          name = "haskell";
          auto-format = false;
        }
        {
          name = "lean";
          scope = "source.lean";
          file-types = [ "lean" ];
        }
        {
          name = "soma";
          scope = "source.soma";
          injection-regex = "soma";
          file-types = [ "soma" ];
          comment-token = "//";
          block-comment-tokens = {
            start = "/*";
            end = "*/";
          };
          indent = {
            tab-width = 4;
            unit = "    ";
          };
          roots = [ ];
          auto-format = false;
          language-servers = [ "souls" ];
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "\"" = "\"";
          };
        }
      ];

      grammar = [
        {
          name = "haskell";
          source = {
            git = "https://github.com/scherna/tree-sitter-haskell";
            rev = "push-lozloplrwsto";
          };
        }
        {
          name = "soma";
          source = {
            git = "https://github.com/srgaabriel/tree-sitter-soma";
            rev = "main";
          };
        }
      ];

      language-server = {
        souls = {
          command = "souls";
          args = [ ];
        };
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "nix"
    ];
    userSettings = {
      diff_view_style = "unified";
      cli_default_open_behavior = "existing_window";
      collaboration_panel.dock = "left";
      git_panel.dock = "left";
      outline_panel.dock = "left";
      icon_theme = "Catppuccin Frappé";
      project_panel = {
        dock = "left";
      };
      helix_mode = true;
      vim.use_system_clipboard = "on_yank";
      agent = {
        dock = "right";
        default_profile = "write";
        inline_assistant_model = {
          provider = "copilot_chat";
          model = "claude-haiku-4.5";
        };
        model_parameters = [ ];
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      base_keymap = "JetBrains";
      ui_font_size = 16;
      buffer_font_size = 16;
      autosave.after_delay.milliseconds = 100;
      theme = {
        mode = "dark";
        light = "GitHub Light";
        dark = "Gruvbox Dark Hard";
      };
      lsp = {
        hls.initialization_options.haskell.formattingProvider = "fourmolu";
        rust-analyzer.initialization_options.check.command = "clippy";
        cargo-tom = {
          initialization_options = {
            offline = false;
            sort_format = true;
          };
          binary = {
            path = "/home/gabriel/Developer/cargotom/target/release/cargotom";
            arguments = [
              "--storage"
              "."
            ];
          };
        };
      };
      edit_predictions = {
        provider = "copilot";
        mode = "subtle";
      };
      auto_install_extensions = {
        catppuccin = true;
        nix = true;
      };
      format_on_save = "on";
      vim_mode = false;
      load_direnv = "shell_hook";
    };
  };

  programs.vscode.mutableExtensionsDir = false;

  programs.vscode.profiles.default = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc-icons
      github.copilot
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
      tamasfe.even-better-toml
    ];
    userSettings = {
      "security.workspace.trust.untrustedFiles" = "open";
      "workbench.colorTheme" = "Dark 2026";
      "workbench.iconTheme" = "catppuccin-perfect-macchiato";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 100;
      "github.copilot.nextEditSuggestions.enabled" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
    };
  };
}
