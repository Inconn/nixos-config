{
	disko.devices = {
		disk = {
			nvme0n1 = {
				device = "/dev/nvme0n1";
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							size = "512M";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "umask=0077" ];
							};
						};
						luks = {
							size = "100%";
							content = {
								type = "luks";
								name = "crypt";
								extraFormatArgs = [ "--pbkdf argon2id --key-size 512 --hash sha512 --cipher aes-xts-plain64 --use-random --pbkdf-force-iterations 100 --pbkdf-memory 4194304 --pbkdf-parallel 4" ];
								content = {
									type = "lvm_pv";
									vg = "crypt";
								};
							};
						};
					};
				};
			};
		};
		lvm_vg = {
			crypt = {
				type = "lvm_vg";
				lvs = {
					swap = {
						size = "32G";
						content = {
							type = "swap";
							resumeDevice = true;
						};
					};
					root = {
						size = "100%FREE";
						content = {
							type = "btrfs";
							extraArgs = [ "-f" ];

							subvolumes = {
								"/nix" = {
									mountOptions = [ "compress-force=zstd:9" "noatime" ];
									mountpoint = "/nix";
								};
								"/store" = {
									mountOptions = [ "compress-force=zstd:15" "noatime" ];
									mountpoint = "/nix/store";
								};
								"/persist" = {
									mountOptions = [ "compress-force=zstd:9" "noatime" ];
									mountpoint = "/nix/persist";
								};
							};
						};
					};
				};
			};
		};
		nodev = {
			"/" = {
				fsType = "tmpfs";
				mountOptions = [
					"defaults"
					"size=4G"
					"mode=755"
				];
			};
		};
	};
}
