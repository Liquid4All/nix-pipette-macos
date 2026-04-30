{ config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    mas

    ripgrep
    fd
    fzf
    onefetch
    git
    git-lfs
    jq
    ncdu
    tmux
    pwgen
    zip
    unzip
    rsync
    wget
    curl

    rustup
    nodejs_24

    cmake
    gnumake
    ninja
    clang-tools
    ccache
    sccache
    (direnv.overrideAttrs (_: { doCheck = false; }))

    glances
    iftop
    htop
    fish

    awscli2

    android-tools
    openjdk17-bootstrap

    python312
    uv

    neovim
    fastfetch
  ];

  home.file = {
    ".config/nixpkgs/config.nix" = {
      text = ''
        {
          allowUnfree = true;
          allowUnfreePredicate = pkg: true;
        }
      '';
      force = true;
    };

    ".config/fish/conf.d/nix-home-manager.fish".text = ''
      if test -d ~/.nix-profile/bin
          fish_add_path --prepend ~/.nix-profile/bin
      end

      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
          . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end
    '';
  };

  home.sessionVariables = {
    EDITOR = "neovim";
  };

  programs.zsh = {
    enable = true;

    envExtra = ''
      if [ -d "$HOME/.nix-profile/bin" ]; then
          export PATH="$HOME/.nix-profile/bin:$PATH"
      fi

      if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ] ; then
          . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi
    '';

    profileExtra = ''
      if [ -d "$HOME/.nix-profile/bin" ]; then
          export PATH="$HOME/.nix-profile/bin:$PATH"
      fi
    '';
  };

  programs.home-manager.enable = true;
}
