{
  flake.modules.homeManager.dms =
    { pkgs, ... }:
    {
      programs.dank-material-shell = {
        enable = true;
        systemd.enable = true;

        settings = {
          appIdSubstitutions = [ ];
          barConfigs = [
            {
              attachToScreenEdge = false;
              autoHide = false;
              autoHideDelay = 250;
              barInsetPadding = 10;
              barLengthPadding = 232;
              borderColor = "surfaceText";
              borderEnabled = false;
              borderOpacity = 1;
              borderThickness = 1;
              bottomGap = 0;
              centerWidgets = [
                {
                  enabled = true;
                  id = "music";
                  mediaSize = 0;
                }
                {
                  clockCompactMode = false;
                  clockDateOrder = "timeFirst";
                  enabled = true;
                  id = "clock";
                }
              ];
              clickThrough = false;
              enabled = true;
              fontScale = 1;
              gothCornerRadiusOverride = false;
              gothCornerRadiusValue = 12;
              gothCornersEnabled = false;
              iconScale = 1;
              id = "default";
              innerPadding = -1;
              island = false;
              islandCompactThickness = 30;
              islandFloating = false;
              islandReserveThickness = 40;
              islandUseOverlayLayer = false;
              leftWidgets = [
                {
                  enabled = true;
                  id = "workspaceSwitcher";
                }
              ];
              maximizeDetection = true;
              maximizeWidgetIcons = false;
              maximizeWidgetText = false;
              name = "Main Bar";
              noBackground = false;
              openOnOverview = false;
              popupGapsAuto = true;
              popupGapsManual = 4;
              position = 0;
              removeWidgetPadding = false;
              rightWidgets = [
                {
                  enabled = true;
                  id = "systemMonitorPlus";
                }
                {
                  enabled = true;
                  id = "systemTray";
                  trayPopupSingleLine = true;
                  trayUseInlineExpansion = true;
                }
                {
                  enabled = true;
                  id = "clipboard";
                }
                {
                  enabled = true;
                  id = "notificationButton";
                }
                {
                  enabled = true;
                  id = "controlCenterButton";
                  showAudioIcon = false;
                  showAudioPercent = false;
                  showBluetoothIcon = false;
                  showNetworkIcon = true;
                  showScreenSharingIcon = false;
                  showVpnIcon = false;
                }
              ];
              screenPreferences = [ "all" ];
              scrollEnabled = true;
              scrollXBehavior = "column";
              scrollYBehavior = "workspace";
              shadowColorMode = "text";
              shadowCustomColor = "#000000";
              shadowIntensity = 0;
              shadowOpacity = 10;
              showOnLastDisplay = true;
              showOnWindowsOpen = false;
              spacing = 8;
              squareCorners = false;
              transparency = 1;
              visible = true;
              widgetOutlineColor = "secondary";
              widgetOutlineEnabled = true;
              widgetOutlineOpacity = 0;
              widgetOutlineThickness = 1;
              widgetPadding = 8;
              widgetTransparency = 1;
            }
          ];
          barElevationEnabled = false;
          builtInPluginSettings = {
            dms_clipboard_search = {
              trigger = "cb";
            };
            dms_power = {
              trigger = "pw";
            };
            dms_qr_generator = {
              trigger = "qrg";
            };
            dms_settings_search = {
              trigger = "?";
            };
          };
          clockFormat = "24h";
          configVersion = 18;
          controlCenterShowMicPercent = true;
          cornerRadius = 12;
          currentThemeCategory = "dynamic";
          currentThemeName = "dynamic";
          cursorSettings = {
            dwl = {
              cursorHideTimeout = 0;
            };
            hyprland = {
              hideOnKeyPress = false;
              hideOnTouch = false;
              inactiveTimeout = 0;
            };
            niri = {
              hideAfterInactiveMs = 0;
              hideWhenTyping = false;
            };
            size = 24;
            theme = "System Default";
          };
          desktopClockCustomColor = {
            a = 1;
            b = 1;
            g = 1;
            hslHue = -1;
            hslLightness = 1;
            hslSaturation = 0;
            hsvHue = -1;
            hsvSaturation = 0;
            hsvValue = 1;
            r = 1;
            valid = true;
          };
          floatingWindowSyncGlobal = false;
          fontFamily = "SF Pro Display";
          fontWeight = 500;
          foregroundLayerTransparency = 0;
          groupWorkspaceApps = false;
          matugenScheme = "scheme-vibrant";
          matugenTargetMonitor = "HDMI-A-1";
          matugenTemplateHyprland = false;
          maxWorkspaceIcons = 10;
          monoFontFamily = "SF Mono";
          networkPreference = "wifi";
          osdAlwaysShowValue = true;
          osdMediaVolumeEnabled = false;
          osdPowerProfileEnabled = true;
          screenPreferences = {
            wallpaper = [ "all" ];
          };
          showOccupiedWorkspacesOnly = true;
          systemMonitorCustomColor = {
            a = 1;
            b = 1;
            g = 1;
            hslHue = -1;
            hslLightness = 1;
            hslSaturation = 0;
            hsvHue = -1;
            hsvSaturation = 0;
            hsvValue = 1;
            r = 1;
            valid = true;
          };
          useAutoLocation = true;
          wallpaperFillMode = "Fit";
          widgetBackgroundColor = "s";
        };

        plugins =
          let
            dmsPlugins = pkgs.fetchFromGitHub {
              owner = "AvengeMedia";
              repo = "dms-plugins";
              rev = "547023b3ba65bcb195c93fd4b111d0f1eebe0432";
              sha256 = "sha256-3cZOazX90nAhNZ8Z6lTa8OC6Y+ZmpJ2cYOv46oelIm0=";
            };
          in
          {
            dockerManager = {
              src = pkgs.fetchFromGitHub {
                owner = "LuckShiba";
                repo = "DmsDockerManager";
                rev = "v1.2.0";
                sha256 = "sha256-VoJCaygWnKpv0s0pqTOmzZnPM922qPDMHk4EPcgVnaU=";
              };
            };
            dankKDEConnect = {
              enable = false;
              src = "${dmsPlugins}/DankKDEConnect";
            };
            dankLauncherKeys.src = "${dmsPlugins}/DankLauncherKeys";
            systemMonitorPlus = {
              src = "${
                pkgs.fetchFromGitHub {
                  owner = "Dadangdut33";
                  repo = "dms-plugins";
                  rev = "63fe6b87c497f1f7c2ea61432716817db1c5c3a4";
                  sha256 = "sha256-/iIqBej8dFwOQpvO9PXFvnDwZMSA7IykzaQjl5xoJUs=";
                }
              }/SystemMonitorPlus";
              settings = {
                resourceOrder = "cpuUsage,cpuTemp,gpuTemp,ramUsage";

                cpuUsageEnabled = true;
                cpuUsageVisualStyle = "gauge";
                cpuUsageShowText = false;

                cpuTempEnabled = true;
                cpuTempVisualStyle = "gauge";
                cpuTempShowText = false;

                gpuTempEnabled = true;
                gpuTempVisualStyle = "gauge";
                gpuTempShowText = false;

                ramUsageEnabled = true;
                ramUsageVisualStyle = "gauge";
                ramUsageShowText = false;
              };
            };
            brSoccer = {
              enable = false;
              src = pkgs.fetchFromGitHub {
                owner = "Nadoutti";
                repo = "nadotti-br-soccer-plugin";
                rev = "992f7046f32bca0a25441696869e111481f90b91";
                sha256 = "sha256-0uN4dJG/dfWRZ+5HXbgW2axd3iDdlg9P/EBMnNWNz6M=";
              };
            };
            dmsScreenshot = {
              src = pkgs.fetchFromGitHub {
                owner = "JDKamalakar";
                repo = "DMS-Screenshot";
                rev = "f40deaf839b6e45feb978fa83a28c3db117b3c87";
                sha256 = "sha256-Vf2J5Gmb/gyMDC9YhU4cxqSqPTbJR5WXdOheKssL8qw=";
              };
            };
            nixMonitor = {
              enable = false;
              src = pkgs.fetchFromGitHub {
                owner = "antonjah";
                repo = "nix-monitor";
                rev = "v1.0.3";
                sha256 = "sha256-biRc7ESKzPK5Ueus1xjVT8OXCHar3+Qi+Osv/++A+Ls=";
              };
            };
            calculator = {
              src = pkgs.fetchFromGitHub {
                owner = "rochacbruno";
                repo = "DankCalculator";
                rev = "c9fbbe921e9afeb92f4e92390e9fc05f006f0373";
                sha256 = "sha256-dqFTvNogWsqK82EhgMIbJB70R5TgcRiA3Elx1LkSia8=";
              };
              settings.trigger = "=";
            };
          };
      };
    };

  flake.modules.homeManager.dms-desktop =
    { pkgs, ... }:
    {
      programs.dank-material-shell.plugins = {
        amdGpuMonitor = {
          src = pkgs.fetchFromGitHub {
            owner = "navidagz";
            repo = "dms-amd-gpu-monitor";
            rev = "v3.0.0";
            sha256 = "sha256-oQst63DAWR8GsH6X9g3DiXpkypx70VF9rnZlbJzXUnQ=";
          };
          settings = {
            minimumWidth = false;
            popoutStyle = "default";
          };
        };
        gameControllerBattery = {
          src = pkgs.fetchFromGitHub {
            owner = "Hujair";
            repo = "gameControllerBattery";
            rev = "v1.2.0";
            sha256 = "sha256-irWI2LI8IOhva/DpfF8nI23wQMKyOPGNv86G9ZDjJ4g=";
          };
        };
      };
    };
}
