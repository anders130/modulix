{modulix}: let
    hosts = modulix.mkHosts {
        inputs.self = ./__fixture;
    };
in (hosts.host1.config.myTestOption)
