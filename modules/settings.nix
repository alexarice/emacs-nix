{ config, lib, ... }:

with lib;

{
  options = {
    global-variables = mkOption {
      type = types.varBindType;
      default = { };
      description = ''
        Variables to be set in <filename>init.el</filename>.
      '';
    };

    global-modes = mkOption {
      type = types.attrsOf types.bool;
      default = { };
      description = ''
        Modes to enable/disable on startup.
      '';
    };
  };

  config.preamble = mkAfter ''
    ${printVariables config.global-variables}

    ${concatStringsSep "\n" (mapAttrsToList (name: value: "(${name} ${if value then "1" else "-1"})") config.global-modes) }
  '';
}
