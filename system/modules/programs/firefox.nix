{ nixpak, pkgs, lib, config, ... }:
let
	cfg = config.firefox;
in {	
	options.firefox = {
		enable = lib.mkEnableOption "firefox";
	};

	config = lib.mkIf cfg.enable {
		programs.firefox = {
			package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {
				pipewireSupport = true;
			}) {};
			enable = true;
		};
	};
}
