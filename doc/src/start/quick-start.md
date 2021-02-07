# Quick Start
The only dependency is nix, so make sure you have it [installed][install-nix].

## Get the Template
Here is a snippet that will work as long as `nix-shell` is in your path:
```sh
nix-shell https://github.com/nrdxp/nixflk/archive/core.tar.gz -A shell \
  --run "flk get core"

cd flk

nix-shell

git init
git add .
git commit -m init

cachix use nrdxp
```
> You can change `core` to `community` in the call to `flk get`

This will place you in a new folder named `flk` in the current directory with
git set up, and a nix-shell that provides all the dependencies, including the
required nix version. In addition, the cachix cache which contains all the
binary outputs from this flake is added for faster deployment.

## Next Steps:
- [Make installable ISO](./iso.md)
- [Already on NixOS](./from-nixos.md)
- [Install from Linux](./from-linux.md)


[install-nix]: https://nixos.org/manual/nix/stable/#sect-multi-user-installation
