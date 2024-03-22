{ config, pkgs, lib, ... }:

{
	options = {
		pipewire = {
			enable = lib.mkEnableOption {
				description = "Enable pipewire";
				default = false;
			};
		};
	};

	config = lib.mkIf config.pipewire.enable {
		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
	};
}
