{
	description = "My NixOS config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-trunk.url = "github:nixos/nixpkgs";

		chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

		impermanence.url = "github:nix-community/impermanence";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.3.0";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpak = {
			url = "github:nixpak/nixpak";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, chaotic, nixos-hardware, home-manager, disko, impermanence, lanzaboote, nixpak, ... }@inputs: {

		overlays = {
			pkg-sets = (
				final: prev: {
					unstable = import inputs.nixpkgs-unstable { system = final.system; };
					trunk = import inputs.nixpkgs-trunk { system = final.system; };
				}
			);
		};

		nixosConfigurations = {
			vm = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./machines/vm
					./system
					disko.nixosModules.disko
					impermanence.nixosModules.impermanence
					home-manager.nixosModules.home-manager
					chaotic.nixosModules.default
				];
			};
			asphalt = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./machines/asphalt
					./system
					disko.nixosModules.disko
					impermanence.nixosModules.impermanence
					home-manager.nixosModules.home-manager
					lanzaboote.nixosModules.lanzaboote
					chaotic.nixosModules.default
					nixos-hardware.nixosModules.common-gpu-amd-sea-islands
				];
			};
			t470 = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./machines/t470
					./system
					disko.nixosModules.disko
					impermanence.nixosModules.impermanence
					home-manager.nixosModules.home-manager
					lanzaboote.nixosModules.lanzaboote
					chaotic.nixosModules.default
					# this laptop is a t470, but, after reviewing the nix files,
					# i believe the t480 profile will work fine for a t470
					nixos-hardware.nixosModules.lenovo-thinkpad-t480
				];
			};
		};

		homeConfigurations = {
			
		};
	};
}
