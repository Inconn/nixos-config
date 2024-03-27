{ config, pkgs, lib, ... }:

{
	imports = [
		./disks.nix
		./hardware-configuration.nix
	];

	impermanence.enable = true;
	impermanence.persistDirectory = "/nix/persist";

	pipewire.enable = true;

	boot.kernelPackages = pkgs.linuxPackages_cachyos;
	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
		systemd-boot.enable = true;
	};

	networking.hostName = "incon-vm";

	networking.networkmanager.enable = true;

	system.stateVersion = "23.11";
}
