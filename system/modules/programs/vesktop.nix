{ pkgs, lib, config, ... }:
let
	cfg = config.vesktop;
in {
	options.vesktop = {
		enable = lib.mkEnableOption "vesktop";
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [
			pkgs.vesktop
		];
	};
}
