{ config, pkgs, lib, unstable, ... }:

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

	zramSwap.enable = true;

	hardware.amdgpu.loadInInitrd = true;
	hardware.amdgpu.amdvlk = true;

	impermanence.enable = true;
	impermanence.persistDirectory = "/nix/persist";
	
	pipewire.enable = true;

	services.power-profiles-daemon.enable = lib.mkForce false;
	services.tlp.enable = true;
	services.hdapsd.enable = true;

	boot.kernelPackages = pkgs.linuxPackages_cachyos;
	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
		systemd-boot.enable = true;
	};

	networking.hostName = "asphalt";

	networking.networkmanager.enable = true;

	system.stateVersion = "23.11";
}
