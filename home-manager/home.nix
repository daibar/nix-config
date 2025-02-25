# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./nvim.nix
    ./tmux.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username and home directory
  home = {
    username = "daibar";
    # linux
#   homeDirectory = "/home/daibar";
    # macos
    homeDirectory = "/Users/daibar";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # Add stuff for your user as you see fit:
  # gcc needed to allow treesitter to install language support
  home.packages = with pkgs; 
    [ 
      neofetch 
      gcc
      nerdfonts
      ripgrep
      cbonsai
    ];

  fonts.fontconfig.enable = true;

  # Enable home-manager, zsh and git
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
    };
    initExtra = ''
      # Mac Specific, may need adjustment
      [[ -s "/Users/daibar/scripts/gvm" ]] && source "Users/daibar/scripts/gvm"
      export GVM_ROOT=/Users/daibar/.gvm

      export PATH=$PATH:$(go env GOPATH)/bin
      export PATH=$PATH:/Users/daibar/go/bin

      #
      export PATH=/Users/daibar/.nix-profile/bin:$PATH
      export PATH=/Users/daibar/.local/bin:$PATH
      export PATH=/nix/var/nix/profiles/default/bin:$PATH

      #zsh-vi-mode keybindings
      function atuinSearch() {
        atuin search -i
      }
      zvm_define_widget atuin-search atuinSearch
      zvm_bindkey viins '^t' atuin-search

      # format less pager for nice output for programs like pgcli
      export LESS="-SRXF"

      # aliases
      alias bonsai="cbonsai -i -l -t 100"
    '';
  };

  programs.git = {
    enable = true;
    userName = "daibar";
    userEmail = "dannyaibar@gmail.com";
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
