{ pkgs, lib, config, ... }:

{
	imports = lib.concatMap import [
		./modules
	];

	nix.settings = {
		experimental-features = "nix-command flakes";

		auto-optimise-store = true;
	};

	users.users.incon = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		initialHashedPassword = "$6$AG9VjEF8n96p4keh$Q8UWH1czgs.mH6PPK.Xk3KJ2jivRryG770KN6E0cEhfVtlmDLEbimavbdbzR7lK.wo29EbFnvJmQ1YifH6TvJ0";
	};

	programs.git = {
		enable = true;
	};

	networking.nftables.enable = true;
	
	time.timeZone = "America/Chicago";
	i18n.defaultLocale = "en_US.UTF-8";
}
