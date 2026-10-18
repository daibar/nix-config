{ config, lib, pkgs, unstable, ... }: {
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

  # sqlit only loads custom themes listed under custom_themes in settings.json
  # (it doesn't scan themes/). Merge ours in, keeping whatever else sqlit saved.
  home.activation.sqlitTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings="${config.xdg.configHome}/sqlit/settings.json"
    [ -s "$settings" ] || echo '{}' > "$settings"
    tmp="$(mktemp)"
    ${pkgs.jq}/bin/jq '.theme = "Tokyo Night 2"
      | .custom_themes = ((.custom_themes // []) + ["Tokyo Night 2"] | unique)' \
      "$settings" > "$tmp"
    $DRY_RUN_CMD mv "$tmp" "$settings"
  '';

  home.file.".visidatarc".source = ./tui/visidatarc;
}
