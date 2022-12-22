{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "go-changelog";
  version = "ba40b3a8c7ff33eee3ccd1d90dd76030f072df1f";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "go-changelog";
    rev = version;
    sha256 = "sha256-/3hENAiJFO+igfDyyuHl3+kaU8JJqd3EjxAiqfH9F6I=";
  };

  vendorSha256 = "sha256-e0G7u+XAVEEfHNX1FGNKVPe4dp5fRwwJ69dnkyoW+Fw=";

  subPackages = [ "cmd/changelog-build" ];
}
