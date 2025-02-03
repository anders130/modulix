{lib}: let
    inherit (builtins) isAttrs mapAttrs removeAttrs;
in
    lib.fix (recurse:
        mapAttrs (
            _: value:
                if isAttrs value
                then
                    recurse (removeAttrs value ["type" "_type"])
                    // (
                        if value ? type
                        then {type = value.type.name;}
                        else {}
                    )
                else value
        ))
