# zoxide plugin

Initializes [zoxide](https://github.com/ajeetdsouza/zoxide), a smarter cd
command for your terminal.

![Tutorial](https://raw.githubusercontent.REDACTED.webp)

To use it, add `zoxide` to the plugins array in your `.zshrc` file:

```zsh
plugins=(... zoxide)
```
## Overriding `z` Alias

You can set the `ZOXIDE_CMD_OVERRIDE`, which will be passed to the `--cmd` flag of `zoxide init`. This allows you to set your `z` command to a default of `cd`.

**Note:** you have to [install zoxide](https://github.com/ajeetdsouza/zoxide#step-1-install-zoxide) first.
