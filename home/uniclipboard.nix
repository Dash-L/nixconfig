{ appimageTools, fetchurl }:
let
  pname = "uniclipboard";
  version = "0.19.1";

  src = fetchurl {
    url = "https://github.com/UniClipboard/UniClipboard/releases/download/v${version}/UniClipboard_${version}_amd64.AppImage";
    hash = "sha256:4b6855da5262a05b2c550c1c54564571521106bcfc332ad1b9551d2078781f1a";
  };
in appimageTools.wrapType2 { inherit pname version src; }
