{ config, inputs, unstable, ... }:
let
  # Theme and config files live in the dotfiles repo (flake input, pinned in
  # flake.lock); `nix flake update dotfiles` picks up changes there.
  dotfiles = inputs.dotfiles;
in {
  home.packages = [ unstable.posting ];

  xdg.configFile = {
    "posting/themes/tokyo-night.yaml".source = "${dotfiles}/tokyo-night.yaml";
    "posting/config.yaml".text = ''
      theme: tokyo-night
      theme_directory: ${config.xdg.configHome}/posting/themes
    '';

    # sqlit itself writes settings.json (selected theme, custom_themes), so
    # only the theme file is managed here.
    "sqlit/themes/Tokyo Night 2.json".source = "${dotfiles}/sqlittheme.json";
  };

  home.file.".visidatarc".source = "${dotfiles}/.visidatarc";
}
