{
  description = "My Nixos Config Flake";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; 

    awww.url = "git+https://codeberg.org/LGFae/awww";

	home-manager = {
		url = "github:nix-community/home-manager/release-25.11";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager,/* spicetify-nix,*/ ...}@inputs: {
  	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
  	nixosConfigurations.izanagi = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ 
			./configuration.nix
			home-manager.nixosModules.home-manager
			{
				home-manager.useUserPackages = true;
				home-manager.useGlobalPkgs = true;
				home-manager.users.ebeyl = { imports = [ ./home.nix ]; };
                home-manager.extraSpecialArgs = {inherit inputs; };
			}
		];
	};
  };
}
