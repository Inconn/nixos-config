{ pkgs, ... }:

{
	imports = [
		./disks.nix
	];

	environment.systemPackages = [
		pkgs.sbctl
	];

	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
		systemd-boot.enable = true;
	};

	nixpkgs.hostPlatform = {
		gcc.arch = "skylake";
		gcc.tune = "skylake";
		system = "x86_64-linux";
	};

	impermanence.enable = true;
	impermanence.persistDirectory = "/nix/persist";
	
	hardware.opengl.enable = true;
	hardware.opengl.driSupport32Bit = true;

	pipewire.enable = true;

	networking.networkmanager.enable = true;

	zramSwap.enable = true;

	# copied straight from nixos.wiki
	services.tlp = {
	      enable = true;
	      settings = {
		CPU_SCALING_GOVERNOR_ON_AC = "performance";
		CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

		CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
		CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

		CPU_MIN_PERF_ON_AC = 0;
		CPU_MAX_PERF_ON_AC = 100;
		CPU_MIN_PERF_ON_BAT = 0;
		CPU_MAX_PERF_ON_BAT = 20;

		SOUND_POWER_SAVE_ON_AC=10;
		SOUND_POWER_SAVE_ON_BAT=10;

#		START_CHARGE_THRESH_BAT0 = 40;
#		STOP_CHARGE_THRESH_BAT0 = 80;
#		START_CHARGE_THRESH_BAT1 = 40;
#		STOP_CHARGE_THRESH_BAT1 = 80;

	      };
	};

	system.stateVersion = "23.11";
}
