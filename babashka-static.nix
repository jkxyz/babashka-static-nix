{ fetchurl, stdenv }:

let
  version = "0.7.4";

  babashkaSources = rec {
    x86_64-linux = fetchurl {
      url =
        "https://github.com/babashka/babashka/releases/download/v${version}/babashka-${version}-linux-amd64-static.tar.gz";
      sha256 = "sha256-cHqrIbQJIdDTMj4k68czBoDmUOa7Oqtrpnq9z08vFGw=";
    };

    aarch64-linux = fetchurl {
      url =
        "https://github.com/babashka/babashka/releases/download/v${version}/babashka-${version}-linux-aarch64-static.tar.gz";
      sha256 = "";
    };

    x86_64-darwin = fetchurl {
      url =
        "https://github.com/babashka/babashka/releases/download/v${version}/babashka-${version}-macos-amd64.tar.gz";
      sha256 = "";
    };

    aarch64-darwin = x86_64-darwin;
  };
in stdenv.mkDerivation {
  pname = "babashka";
  inherit version;

  src = babashkaSources.${stdenv.hostPlatform.system};

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp bb $out/bin
  '';
}
