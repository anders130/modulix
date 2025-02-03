{self}: path: [(args @ {pkgs, ...}: {imports = self.internal.mkModules args path;})]
