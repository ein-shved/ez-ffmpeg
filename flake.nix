{
  description = ''
    A safe and ergonomic Rust interface for FFmpeg integration, designed for ease of use.
  '';

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        ez-ffmpeg = pkgs.callPackage ./. { };
      in
      {
        packages = {
          inherit ez-ffmpeg;
          default = ez-ffmpeg;
        };
        devShells.default = pkgs.mkShell {
          inputsFrom = [ ez-ffmpeg ];
          packages = with pkgs; [
            rust-analyzer
            rustfmt
          ];
        };
      }
    )
    // {
      formatter = nixpkgs.formatter;
    };
}
