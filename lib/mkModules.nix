{lib, ...}: path: [(args @ {pkgs, ...}: {imports = lib.mkModules' args path;})]
