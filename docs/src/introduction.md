# Introduction

[Modulix](https://github.com/anders130/modulix) is a NixOS configuration framework that simplifies host and module management using a structured approach, built upon [haumea](https://github.com/nix-community/haumea).

In short, modulix allows you to define your hosts and modules by organizing them into a directory structure:

```
.
├── hosts
│   ├── host1
│   └── host2
├── modules
│   ├── module1.nix
│   └── module2.nix
└── flake.nix
```

Modulix's source code is available on [GitHub](https://github.com/anders130/modulix) under the [MIT license](https://github.com/anders130/modulix/blob/master/LICENSE). You can see the implementation in the [`src`](https://github.com/anders130/modulix/tree/master/src) directory.

[→ Getting started](./getting-started.md)
