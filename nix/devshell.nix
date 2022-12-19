{ lib
, stdenv
, hello
, go-changelog
, go-protobuf
, mkShell
}:

mkShell rec {
  name = "dev";

  packages = [
    hello

    # Custom packages, added to overlay
    go-protobuf
    go-changelog
  ];

  # Extra env vars
  FOO = "BAR";
}
