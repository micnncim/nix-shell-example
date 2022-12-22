{ mkShell
, fluxcd
, go-changelog
, hello
, kubectl
, protoc-gen-go
}:

mkShell rec {
  name = "dev";

  packages = [
    fluxcd
    hello
    kubectl
    protoc-gen-go

    # Custom packages, added to overlay
    go-changelog
  ];

  # Extra env vars
  FOO = "BAR";
}
