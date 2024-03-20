{
	disko.devices = {
		disk = {
			vda = {
				device = "/dev/vda";
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
						files = {
							size = "100%";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ];

								subvolumes = {
									"/nix" = {
										mountOptions = [ "compress=zstd:9" "noatime" ];
										mountpoint = "/nix";
									};
									"/store" = {
										mountOptions = [ "compress-force=zstd:11" "noatime" ];
										mountpoint = "/nix/store";
									};
									"/persist" = {
										mountOptions = [ "compress=zstd:9" "relatime" ];
										mountpoint = "/nix/persist";
									};
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
