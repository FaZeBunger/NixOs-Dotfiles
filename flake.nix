{
  description = "My Nixos Config Flake";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; 

    swww.url = "github:LGFae/swww";

	home-manager = {
		url = "github:nix-community/home-manager/release-25.05";
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
				home-manager.users.ebeyl = import ./home.nix;
			}
		];
	};
  };
}
