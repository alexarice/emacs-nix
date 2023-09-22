{
  config,
  lib,
  ...
}:
with lib; {
  options = {
    global-variables = mkOption {
      type = types.varBindType;
      default = {};
      description = ''
        Variables to be set in <filename>init.el</filename>.
      '';
    };

    global-modes = mkOption {
      type = types.attrsOf types.bool;
      default = {};
      description = ''
        Modes to enable/disable on startup.
      '';
    };

    environment = mkOption {
      type = types.attrsOf types.lispVarType;
      default = {};
      description = ''
        Environment variables to set.
      '';
    };
  };

  config.preamble = mkAfter ''
    ${printVariables config.global-variables}

    ${concatStringsSep "\n" (mapAttrsToList (name: value: "(setenv \"${name}\" ${printLispVar value})") config.environment)}

    ${concatStringsSep "\n" (mapAttrsToList (name: value: "(${name} ${
        if value
        then "1"
        else "-1"
      })")
      config.global-modes)}
  '';
}
