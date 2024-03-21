{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		(modulesPath + "/profiles/qemu-guest.nix")
	];

	boot.initrd.availableKernelModules = [ "virtio_pci" "ahci" "sr_mod" "virtio_blk" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ ];
	boot.extraModulePackages = [ ];

	networking.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
