{ lib
, stdenv
, hello
, go-changelog
  # , go-protobuf
, protoc-gen-go
, mkShell
}:

mkShell rec {
  name = "dev";

  packages = [
    hello
    protoc-gen-go

    # Custom packages, added to overlay
    go-changelog
  ];

  # Extra env vars
  FOO = "BAR";
}
