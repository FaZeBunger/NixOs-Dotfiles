{
  description = "Flake of Ethan Beyl";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      name = "Ethan Beyl";
      username = "ebeyl";
      hostname = "susanoo";
      timezone = "America/Chicago";
      defaultLocale = "en_US.UTF-8";
      email = "ethan.j.beyl-1@ou.edu";
    in
    {

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      nixosConfigurations.izanagi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          inherit hostname;
          inherit timezone;
          inherit defaultLocale;
          inherit username;
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ebeyl = { imports = [ ./home.nix ]; };

            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
            };
          }
        ];
      };
    };
}
