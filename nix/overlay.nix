final: prev: {
  devShell = final.callPackage ./devshell.nix { };

  go-protobuf = prev.callPackage ./go-protobuf.nix { };

  go-changelog = prev.callPackage ./go-changelog.nix { };
}
