final: prev: {
  devShell = final.callPackage ./devshell.nix { };

  go-changelog = prev.callPackage ./go-changelog.nix { };

  protoc-gen-go = (prev.protoc-gen-go.overrideAttrs (oldAttrs: rec {
    version = "1.28.1";
    src = prev.fetchFromGitHub {
      owner = "protocolbuffers";
      repo = "protobuf-go";
      rev = "v${version}";
      sha256 = "sha256-7Cg7fByLR9jX3OSCqJfLw5PAHDQi/gopkjtkbobnyWM=";
    };
  }));
}
