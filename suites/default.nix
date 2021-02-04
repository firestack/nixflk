{ lib }:
let
  inherit (builtins) mapAttrs isFunction;
  inherit (lib.flk) importDefaults;

  profiles = importDefaults (toString ../profiles);
  users = importDefaults (toString ../users);

  allProfiles =
    let
      sansCore = lib.filterAttrs (n: _: n != "core") profiles;
    in
    lib.collect isFunction sansCore;

  allUsers =
    let
      filtered = lib.filterAttrs (n: _: n != "nrd") users;
    in
    lib.collect isFunction filtered;

  suites = with profiles; rec {
    work = [ develop virt users.nrd ci-agent ];

    graphics = work ++ [ graphical ];

    mobile = graphics ++ [ laptop ];

    play = graphics ++ [
      graphical.games
      network.torrent
      misc.disable-mitigations
    ];

    goPlay = play ++ [ laptop ];
  };
in
mapAttrs (_: v: lib.flk.profileMap v) suites // {
  inherit allProfiles allUsers;
}
