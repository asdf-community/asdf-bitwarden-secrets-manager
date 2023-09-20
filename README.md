<div align="center">

# asdf-bitwarden-secrets-manager [![Build](https://github.com/FIAV1/asdf-bitwarden-secrets-manager/actions/workflows/build.yml/badge.svg)](https://github.com/FIAV1/asdf-bitwarden-secrets-manager/actions/workflows/build.yml) [![Lint](https://github.com/FIAV1/asdf-bitwarden-secrets-manager/actions/workflows/lint.yml/badge.svg)](https://github.com/FIAV1/asdf-bitwarden-secrets-manager/actions/workflows/lint.yml)

[bitwarden-secrets-manager](https://github.com/FIAV1/asdf-bitwarden-secrets-manager) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add bitwarden-secrets-manager
# or
asdf plugin add bitwarden-secrets-manager https://github.com/FIAV1/asdf-bitwarden-secrets-manager.git
```

bitwarden-secrets-manager:

```shell
# Show all installable versions
asdf list-all bitwarden-secrets-manager

# Install specific version
asdf install bitwarden-secrets-manager latest

# Set a version globally (on your ~/.tool-versions file)
asdf global bitwarden-secrets-manager latest

# Now bitwarden-secrets-manager commands are available
bws --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/FIAV1/asdf-bitwarden-secrets-manager/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Federico Frigo](https://github.com/FIAV1/)
