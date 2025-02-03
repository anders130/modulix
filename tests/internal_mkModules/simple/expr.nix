{modulix}: let
    inherit (modulix.internal) mkModules;
    args = {
        config.module.enable = true;
        inputs.self = ./__fixture;
    };
in
    mkModules args ./__fixture
    |> map modulix.internal.adjustTypeArgs
