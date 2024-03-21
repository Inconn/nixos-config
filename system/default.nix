{ pkgs, lib, config, ... }:

{
	nix.settings = {
		experimental-features = "nix-command flakes";

		auto-optimise-store = true;
	};

	imports = lib.concatMap import [
		./modules
	];

	users.mutableUsers = false;
	users.users.incon = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		initialHashedPassword = "$6$AG9VjEF8n96p4keh$Q8UWH1czgs.mH6PPK.Xk3KJ2jivRryG770KN6E0cEhfVtlmDLEbimavbdbzR7lK.wo29EbFnvJmQ1YifH6TvJ0";
	};

	networking.nftables.enable = true;
	
	time.timeZone = "America/Chicago";
	i18n.defaultLocale = "en_US.UTF-8";

	fileSystems."/nix/persist".neededForBoot = true;
	environment.persistence."/nix/persist" = {
		hideMounts = true;
		directories = [
			"/etc/nixos"
			"/var/log"
			"/var/lib/nixos"
			"/var/lib/systemd/coredump"
		];
		files = [
			"/etc/machine-id"
			"/etc/ssh/ssh_host_rsa_key"
			"/etc/ssh/ssh_host_rsa_key.pub"
			"/etc/ssh/ssh_host_ed25519_key"
			"/etc/ssh/ssh_host_ed25519_key.pub"
		];
	};

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};
}
