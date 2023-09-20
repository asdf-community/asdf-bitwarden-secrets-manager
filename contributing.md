# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test bitwarden-secrets-manager https://github.com/FIAV1/asdf-bitwarden-secrets-manager.git "bws --version"
```

Tests are automatically run in GitHub Actions on push and PR.
