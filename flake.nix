{
  description = "Home Manager configurations for pipette-macos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = { username, extraPackages ? [], extraModules ? [] }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./common.nix
          {
            home.username = username;
            home.homeDirectory = "/Users/${username}";
            home.packages = extraPackages;
          }
        ] ++ extraModules;
      };
    in
    {
      homeConfigurations = {
        liquid = mkHome {
          username = "liquid";
          # extraPackages = with pkgs; [ ];
          extraModules = [{
            home.file.".zprofile".text = ''
              echo ""
              echo "========================================"
              echo "  Managed by Nix Home Manager"
              echo "  https://github.com/Liquid4All/nix-pipette-macos"
              echo "========================================"
              echo ""
            '';
            home.file.".config/fish/conf.d/welcome.fish".text = ''
              echo ""
              echo "========================================"
              echo "  Managed by Nix Home Manager"
              echo "  https://github.com/Liquid4All/nix-pipette-macos"
              echo "========================================"
              echo ""
            '';
          }];
        };
      };
    };
}
