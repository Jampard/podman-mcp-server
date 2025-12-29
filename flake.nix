{
  description = "MCP server for Podman and Docker container runtimes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule rec {
          pname = "podman-mcp-server";
          version = "0.0.12";

          src = ./.;

          vendorHash = "sha256-uo+cksVsxZMWZbUoNaNy7aSZogVB64Lp1gkw5vbVmls=";

          subPackages = [ "cmd/podman-mcp-server" ];

          ldflags = [
            "-s"
            "-w"
            "-X github.com/manusa/podman-mcp-server/pkg/podman-mcp-server/cmd.version=${version}"
          ];

          meta = with pkgs.lib; {
            description = "MCP server for Podman and Docker container runtimes";
            homepage = "https://github.com/manusa/podman-mcp-server";
            license = licenses.asl20;
            mainProgram = "podman-mcp-server";
          };
        };
      }
    );
}
