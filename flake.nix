{
  description = "Flake of Ethan Beyl";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    antigravity = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, niri, noctalia, antigravity, ... }@inputs:
  let
    hostSystem = "x86_64-linux";
    name = "Ethan Beyl";
    username = "ebeyl";
    timezone = "America/Chicago";
    defaultLocale = "en_US.UTF-8";
    email = "ethan.j.beyl-1@ou.edu";
    unstable = import nixpkgs-unstable {
      localSystem = hostSystem;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      susanoo = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostname = "susanoo";
          inherit timezone;
          inherit defaultLocale;
          inherit username;
          inherit unstable;
          inherit hostSystem;
        };

        modules = [
          { nixpkgs.hostPlatform = hostSystem; }
          ./hosts/susanoo/default.nix
          home-manager.nixosModules.home-manager
          inputs.noctalia-greeter.nixosModules.default
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = false;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ebeyl = {
              imports = [
                ./hosts/susanoo/home.nix
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
              inherit unstable;
              inherit antigravity;
            };
          }
        ];
      };

      izanagi = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostname = "izanagi";
          inherit timezone;
          inherit defaultLocale;
          inherit username;
          inherit unstable;
          inherit hostSystem;
        };


        modules = [
          { nixpkgs.hostPlatform = hostSystem; }
          ./hosts/izanagi/default.nix
          home-manager.nixosModules.home-manager
          inputs.noctalia-greeter.nixosModules.default
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = false;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ebeyl = {
              imports = [
                ./hosts/izanagi/home.nix
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
              inherit unstable;
              inherit antigravity;
            };
          }
        ];
      };
    };
  };
}
