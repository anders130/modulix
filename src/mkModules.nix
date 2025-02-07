{root}: path: [(args @ {pkgs, ...}: {imports = root.internal.mkModules args path;})]
