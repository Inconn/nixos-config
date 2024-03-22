{ config, pkgs, lib, ... }:

{
	imports = [
		./disks.nix
		./hardware-configuration.nix
	];

	impermanence.enable = true;
	impermanence.persistDirectory = "/nix/persist";
	impermanence.directories = [
		"/etc/NetworkManager/system-connections"
	];

	pipewire.enable = true;

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
