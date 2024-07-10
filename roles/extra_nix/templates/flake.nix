{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = {pkgs, ... }: {

        services.nix-daemon.enable = true;
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes repl-flake";
        nix.settings.extra-platforms = [ "aarch64-darwin" "x86_64-darwin" ];
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = {% if ansible_architecture == "x86_64" %}"x86_64-darwin"{% else %}"aarch64-darwin"{% endif %};

        # Declare the user that will be running `nix-darwin`.
        users.users.{{ nix_user }} = {
          name = "{{ nix_user }}";
          home = "/Users/{{ nix_user }}";
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        environment.systemPackages = [ ];
    };
  in
  {
    darwinConfigurations."{{ ansible_hostname }}" = nix-darwin.lib.darwinSystem {
      modules = [
         configuration
      ];
    };
  };
}
