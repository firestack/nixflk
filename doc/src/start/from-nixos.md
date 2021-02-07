# From NixOS

## Generate Configuration
Assuming your happy with your existing partition layout, you can generate a
basic NixOS configuration for your system using:
```
flk up
```

This will make a new file `hosts/up-$(hostname).nix`, which you can edit to
your liking.

> While the `up` sub-command is provided as a convenience to quickly set up and
> install a "fresh" NixOS system on current hardware, committing these files is
> discouraged.
>
> They are placed in the git staging area automatically because they would be
> invisible to the flake otherwise, but it is best to move what you need from
> them directly into a host module of your own making, and commit that instead.

Make sure your `i18n.defaultLocale` and `time.timeZone` are set properly for
your region. Keep in mind that `networking.hostName` with be automatically
set to the filename of your hosts file, so `hosts/my-host.nix` will have the
hostname `my-host`.

Now might be a good time to read the docs on [suites](../layout/suites.md) and
[profiles](../layout/profiles.md) and add or create any that you need.

# Installation

Once your ready to deploy `hosts/my-host.nix`:
```
flk my-host switch
```

> Instead of `switch`, you can pass `build`, `test`, `boot`, etc just as with
> `nixos-rebuild`.

This calls `nixos-rebuild` with sudo to build and install your configuration.

> It is convenient to have the template living at `/etc/nixos` so you can
> simply `sudo nixos-rebuild switch` from anywhere on the system, but it is
> not required.


