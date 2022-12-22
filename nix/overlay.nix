final: prev: {
  devShell = final.callPackage ./devshell.nix { };

  go-changelog = prev.callPackage ./go-changelog.nix { };

  fluxcd =
    let
      version = "0.38.1";
      src = prev.fetchFromGitHub {
        owner = "fluxcd";
        repo = "flux2";
        rev = "v${version}";
        sha256 = "sha256-qNVzk3PUOCXHOOuXCgLy62gQNUdc2M1AeDVsgM8z1wo=";
      };
      manifests = prev.fetchzip {
        url = "https://github.com/fluxcd/flux2/releases/download/v${version}/manifests.tar.gz";
        sha256 = "sha256-mKER9vg9K9J1YsAs6qYUXzung4u/zV+0f7VA5bZVVYU=";
        stripRoot = false;
      };
    in
    (prev.fluxcd.override rec {
      # `vendorSha256` can't be overridden with `overrideAttrs`.
      # See https://github.com/NixOS/nixpkgs/issues/86349 for more information.
      buildGoModule = args: prev.buildGoModule.override { go = prev.go_1_18; } (args // {
        inherit src version;

        vendorSha256 = "sha256-8/rFdflDK3Pc5dDqSFJghjmJWVZAHiC+/6SDSWYzfVI=";

        ldflags = [ "-s" "-w" "-X main.VERSION=${version}" ];

        patches = null;

        installCheckPhase = ''
          $out/bin/flux --version | grep ${version} > /dev/null
        '';

        postUnpack = ''
          cp -r ${manifests} source/cmd/flux/manifests
        '';

        passthru.updateScript = null;
      });
    });

  protoc-gen-go = (prev.protoc-gen-go.overrideAttrs (oldAttrs: rec {
    version = "1.28.1";
    src = prev.fetchFromGitHub {
      owner = "protocolbuffers";
      repo = "protobuf-go";
      rev = "v${version}";
      sha256 = "sha256-7Cg7fByLR9jX3OSCqJfLw5PAHDQi/gopkjtkbobnyWM=";
    };
  }));

  kubectl = (prev.kubectl.overrideAttrs (oldAttrs: rec {
    version = "1.25.3";
    src = prev.fetchFromGitHub {
      owner = "kubernetes";
      repo = "kubernetes";
      rev = "v${version}";
      sha256 = "sha256-UDulyX1PXyAe4cqtekOY1nmQnmMqVLFuHnCswFfE6v0=";
    };
  }));
}
