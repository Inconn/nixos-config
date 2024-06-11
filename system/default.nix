{ pkgs, lib, config, ... }:

{
	imports = lib.concatMap import [
		./modules
		./modules/programs
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
	i18n.extraLocaleSettings = {
		LC_CTYPE = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_TIME = "C.UTF-8";
		LC_COLLATE = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_MESSAGES = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_ADDRESS = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
	};
}
