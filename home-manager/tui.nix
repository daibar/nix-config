{ config, unstable, ... }: {
  home.packages = [ unstable.posting ];

  xdg.configFile = {
    "posting/themes/tokyo-night.yaml".source = ./tui/posting-tokyo-night.yaml;
    "posting/config.yaml".text = ''
      theme: tokyo-night
      theme_directory: ${config.xdg.configHome}/posting/themes
    '';

    # sqlit itself writes settings.json (selected theme, custom_themes), so
    # only the theme file is managed here.
    "sqlit/themes/Tokyo Night 2.json".source = ./tui/sqlit-tokyo-night-2.json;
  };

  home.file.".visidatarc".source = ./tui/visidatarc;
}
