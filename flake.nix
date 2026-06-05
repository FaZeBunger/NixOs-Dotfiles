{
  description = "Flake of Ethan Beyl";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      name = "Ethan Beyl";
      username = "ebeyl";
      hostname = "izanagi";
      timezone = "America/Chicago";
      defaultLocale = "en_US.UTF-8";
      email = "ethan.j.beyl-1@ou.edu";
      unstable = import nixpkgs-unstable {
        localSystem = system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit hostname;
          inherit timezone;
          inherit defaultLocale;
          inherit username;
          inherit unstable;
        };


        modules = [
          { nixpkgs.hostPlatform = system; }
          ./configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = false;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ebeyl = { 
              imports = [ 
                ./home.nix 
                inputs.stylix.homeModules.stylix
              ]; 
            };
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
              inherit unstable;
            };
          }
        ];
      };
    };
}
