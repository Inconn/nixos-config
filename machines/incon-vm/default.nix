{ config, pkgs, lib, ... }:

{
	imports = [
		./disks.nix
		./hardware-configuration.nix
	];
	services.xserver.enable = true;
	services.xserver.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		wayland.compositor = "kwin";
	};
	services.desktopManager.plasma6.enable = true;

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
