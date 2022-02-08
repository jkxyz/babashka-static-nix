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
      sha256 = "sha256-092w5av31gvwrgiiy40gjbm6kjpmipmya8i63dmqlbnhnwpsixvr";
    };

    x86_64-darwin = fetchurl {
      url =
        "https://github.com/babashka/babashka/releases/download/v${version}/babashka-${version}-macos-amd64.tar.gz";
      sha256 = "sha256-02jpg91bk946895yy2gjkw2xivggz8rvc0937wkmsxwzbm5qn68q";
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

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/bb --version | grep '${version}'
  '';
}
