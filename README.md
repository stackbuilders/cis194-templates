# cis194-templates

[![CircleCI](https://circleci.com/gh/stackbuilders/cis194-templates.svg?style=shield)](https://circleci.com/gh/stackbuilders/cis194-templates)

## Requirements

Install [haskell-stack](https://docs.haskellstack.org/en/stable/README/#how-to-install).


## Getting Started

Clone the repository:

```
git clone https://github.com/stackbuilders/cis194-templates.git
```

Install the dependencies and compile the project:

```
stack build
```

Run the tests:

```
stack test
```

### Developing with nix-shell

Install [nix](https://nixos.org/nix) package manager:

```
sh <(curl https://nixos.org/nix/install)
```

Spawn a new shell with all the dependencies defined at [shell.nix](shell.nix):

```
nix-shell
```

## Tips & Tricks

Run linter:

```
stack test :hlint
```

## License

Licensed under the [MIT License](LICENSE).
