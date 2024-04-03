{ config, lib, ... }:
let
	cfg = config.impermanence;
in {
	# this module is based on this impermanence module
	# https://github.com/chayleaf/dotfiles/blob/master/system/modules/impermanence.nix

	options = {
		impermanence = with lib; {
			enable = mkEnableOption {
				description = "Enable impermanence";
				default = false;
			};
			persistDirectory = mkOption {
				type = types.path;
				description = "Path to persist directory";
			};
			directories = mkOption {
				type = with types; listOf (either path attrs);
				default = [ ];
				description = "Extra directories to persist";
			};
			files = mkOption {
				type = with types; listOf path;
				default = [ ];
				description = "Extra files to persist";
			};
			persistTmp = mkOption {
				type = types.bool;
				default = true;
				description = "Persist tmp & clean on boot";
			};
		};
	};



	config = lib.mkIf cfg.enable {
		users.mutableUsers = false;
		boot.tmp.cleanOnBoot = lib.mkIf cfg.persistTmp true;

		fileSystems.${toString cfg.persistDirectory}.neededForBoot = true;
		environment.persistence.${toString cfg.persistDirectory} = {
			hideMounts = true;
			directories = map (x:
				if builtins.isPath x then toString x
				else if builtins.isPath (x.directory or null) then x // { directory = toString x.directory; }
				else x
			) ([
				{ directory = "/etc/nixos"; user = "root"; group = "root"; mode = "0755"; }
				{ directory = "/var/lib/nixos"; user = "root"; group = "root"; mode = "0755"; }

				{ directory = "/var/log"; user = "root"; group = "root"; mode = "0755"; }

				{ directory = "/var/lib/systemd/coredump"; user = "root"; group = "root"; mode = "0755"; }
				{ directory = "/var/tmp"; user = "root"; group = "root"; mode = "1777"; }
				{ directory = "/var/spool"; user = "root"; group = "root"; mode = "0777"; }
			] ++ lib.optionals cfg.persistTmp [
				{ directory = "/tmp"; user = "root"; group = "root"; mode = "1777"; } 
			] ++ lib.optionals config.networking.networkmanager.enable [
				{ directory = "/etc/NetworkManager/system-connections"; user = "root"; group = "root"; mode = "0700"; }
			] ++ lib.optionals (config.boot ? lanzaboote && config.boot.lanzaboote.enable) [
				config.boot.lanzaboote.pkiBundle
			] ++ lib.optionals config.hardware.bluetooth.enable [
				{ directory = "/var/lib/bluetooth"; user = "root"; group = "root"; mode = "0700"; }
			] ++ cfg.directories);
			files = map (x:
				if builtins.isPath x then toString x
				else if builtins.isPath (x.file or null) then x // { file = toString x.file; }
				else x
			) ([
				"/etc/adjtime"
				"/etc/machine-id"
			] ++ lib.optionals config.services.openssh.enable [
				"/etc/ssh/ssh_host_rsa_key"
				"/etc/ssh/ssh_host_rsa_key.pub"
				"/etc/ssh/ssh_host_ed25519_key"
				"/etc/ssh/ssh_host_ed25519_key.pub"
			] ++ cfg.files);
		};
	};
}
