{ ... }:

{
	imports = [
		./disks.nix
	];

	environment.persistence."/nix/persist" = {
		directories = [
			"/etc/secureboot"
			"/etc/NetworkManager/system-connections"
		];
	};

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
