{lib, modulix}: let
    inherit (modulix.internal) mkModules;
    args = {
        config = {
            module1.enable = true;
            module2.enable = true;
            deeper.laying = {
                module1.enable = true;
                module2 = {
                    enable = true;
                    something.enable = true;
                };
                module3.enable = true;
                module4.enable = true;
            };
        };
        inputs.self = ./__fixture;
        inherit lib;
    };
in
    mkModules args ./__fixture
    |> map modulix.internal.adjustTypeArgs
