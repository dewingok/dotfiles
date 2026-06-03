# Example local configs

  Sometimes, work just needs special configuration. This is how I do it:

- `config-local`

```config
[url "git@github-work:example/"]
  insteadOf = ssh://git@github.com/example/
  insteadOf = git@github.com:example/

[includeIf "gitdir:~/src/github.com/example/"]
path = ~/.config/git/email-local
```

-`email-local`

```config
[user]
  email = "11111111+example@users.noreply.github.com"
```
