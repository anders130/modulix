{root}: module: {
    inherit (module) config imports;
    options = root.internal.adjustTypeArgs module.options;
}
