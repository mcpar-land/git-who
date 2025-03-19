{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: (flake-utils.lib.eachDefaultSystem (
    system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = pkgs.buildGoModule rec {
        pname = "git-who";
        version = "0.6";

        src = ./.;

        vendorHash = "sha256-VdQw0mBCALeQfPMjQ4tp3DcLAzmHvW139/COIXSRT0s=";
        # some automated tests require submodule to clone and will fail.
        doCheck = false;

        meta = {
          description = "Git blame for file trees";
          homepage = "https://github.com/sinclairtarget/git-who";
          license = pkgs.lib.licenses.mit;
        };
      };
    }
  ));
}
