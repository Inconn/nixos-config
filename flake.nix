{
	description = "My NixOS config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
#		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		impermanence.url = "github:nix-community/impermanence";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, disko, impermanence, ... }@inputs: {
		nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./machines/vm
				./system
				disko.nixosModules.disko
				impermanence.nixosModules.impermanence
				home-manager.nixosModules.home-manager
			];
		};

		homeConfigurations = {
			
		};
	};
}
