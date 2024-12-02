{ lib, config, inputs, ... }:
let
  inherit (lib) mkOption types;
  cfg = config.fhup.common;
in
{
  options.fhup.common = {
    modules = mkOption {
      type = types.listOf types.deferredModule;
      default = [ ];
      description = "Modules that are loaded in all hosts and home manager configurations";
    };

    exclusiveModules = mkOption {
      type = types.listOf types.deferredModule;
      default = [ ];
      description = "Modules that are loaded in either standalone home manager configurations or host configurations";
    };

    specialArgs = mkOption {
      type = types.lazyAttrsOf types.unspecified;
      description = "Special args passed to all hosts and home manager configurations";
      default = { };
    };
  };

  config = {
    fhup.common.specialArgs = {
      inherit inputs;
    };

    fhup.home-manager = {
      inherit (cfg) modules;
    };

    fhup.nixos.modules = lib.mkMerge [
      cfg.modules
      cfg.exclusiveModules
    ];
  };
}
