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

	networking.hostName = "incon-vm";

	networking.networkmanager.enable = true;

	system.stateVersion = "23.11";
}
