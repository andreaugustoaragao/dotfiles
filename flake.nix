{
  description = "Macbook pro configuration";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };
  

  outputs = { self, nixpkgs, home-manager, darwin }: {

  darwinConfigurations."terminal-mbp" = darwin.lib.darwinSystem {
  # you can have multiple darwinConfigurations per flake, one per hostname

    system = "x86_64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
    #pkgs = import nixpkgs { system = "x86_64-darwin";};
    modules = [
        ./hosts/terminal-mbp/default.nix  
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.andrearagao.imports = [ ./modules/home-manager ];
          };
        }
    ]; # will be important later
  };

darwinConfigurations."A2130582" = darwin.lib.darwinSystem {
    system = "x86_64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
    
    modules = [
        ./hosts/terminal-mbp/default.nix  
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.aragao.imports = [ ./modules/home-manager ];
          };
        }
    ]; # will be important later
  };


};
}
