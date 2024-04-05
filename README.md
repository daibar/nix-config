# Nix Configuration

## Project Structure
* home-manager:
    * home.nix
    * etc...
* flake.lock
* flake.nix
* nixos:
   * configuration.nix
   * hardware-configuration.nix (this can/should be generated and copied over for specific server)
   * networking.nix

## Install on Digital Ocean Droplot or other VM
https://github.com/elitak/nixos-infect

Check distro/version for compatibility

1) Setup ssh access with root
2) `> export doNetConf=y`
3) `> curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIX_CHANNEL=nixos-22.11 bash -x`
note: ignore warnings about script not supported being run 
4) Clone nix-config git repo in root home
5) Copy `hardware-configuration.nix` and `networking.nix` to target nix-config for consistency
note: you may need to generate `hardware-configuration.nix` again with the `nixos-generate-config` command.
delete the old file if necessary.


6) Build or rebuild after making changes
`$ sudo nixos-rebuild switch --flake .#{hostname}`
note: unsure why network-addresses-eth0.service may fail.  just run it again

7) Copy nix-config to new user home directory
`$ cp -r nix-config /home/daibar/`

8) Set password for newly created users from root or sudo
`$ passwd {username}`

9) Log into target user (i.e. daibar)
`$ su - daibar`

10) Follow Home Manager instructions

## Home Manager
1) Navigate to `~/nix-config`
2) Update `flake.nix` and `home-manager/home.nix` as directed in comments
3) Run the following commands while in nixos-config folder:
`$ home-manager --flake . switch`
or
`$ home-manager switch --flake .#{username}@{hostname}`
note: use -b backup flag as necessary

## Tips:
Always commit your changes before using switch.  If you have uncommitted changes they won't be found during install!
