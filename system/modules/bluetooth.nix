{ config, pkgs, lib, ... }:

{
	options = {
		bluetooth = {
			enable = lib.mkEnableOption {
				description = "Enable bluetooth";
				default = false;
			};
		};
	};

	config = lib.mkIf config.pipewire.enable {
		hardware.bluetooth.enable = true;
	};
}
