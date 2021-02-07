{ lib, modulesPath, pkgs, suites, ... }:

{
  imports = suites.goPlay;

  time.timeZone = "America/Denver";

  environment.systemPackages = with pkgs; [
    system76-firmware
    obs-studio
    obs-v4l2sink
    obs-linuxbrowser
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.usbmuxd.enable = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };

  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/aed36f15-3b54-49fa-bd18-75ecc73ef5c9";
      keyFile = "/luks.keyfile";
      fallbackToPassword = true;
      preLVM = true;
    };
  };

  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];

  boot.initrd.secrets = { "/luks.keyfile" = ../secrets/luks.keyfile; };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/47f467dc-cf6e-4668-977d-14b344604f64";
    fsType = "xfs";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/CD10-5E00";
    fsType = "vfat";
  };

  networking.useDHCP = false;
  networking.interfaces.enp109s0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  nix.maxJobs = lib.mkDefault 16;

  services.xserver.videoDrivers = [ "nvidia" ];

  services.fstrim.enable = true;

  services.hercules-ci-agent.concurrentTasks = 16;

  services.xserver.windowManager.steam.extraSessionCommands = ''
    if ! xrandr | grep HDMI-0 | grep disconnected > /dev/null; then
      xrandr --output DP-0 --off
    fi
  '';

  services.picom = {
    backend = "glx";
    vSync = true;
  };

  security.mitigations.acceptRisk = true;

  hardware.nvidia.modesetting.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.system76.enableAll = true;
}
