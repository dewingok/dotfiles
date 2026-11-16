# Example local configs

  Sometimes, work just needs special configuration. This is how I do it:

- `config-local`

```config
[url "git@github-work:example/"]
  insteadOf = ssh://git@github.com/example/
  insteadOf = git@github.com:example/

[includeIf "gitdir:~/src/github.com/example/**"]
path = ~/.config/git/email-local
```

-`email-local`

```config
[user]
  email = "11111111+example@users.noreply.github.com"
  signingkey = ~/.ssh/id_ed25519_work.pub
```

## Commit signing

Commits and tags are signed with SSH keys from ssh-agent. Add each `.pub` key on GitHub as a **Signing key** (Settings → SSH and GPG keys); `gh ssh-key add --type signing` works once the token has the `admin:ssh_signing_key` scope.

`allowed_signers` lets `git log --show-signature` verify locally. It is generated, not tracked:

```sh
for k in ~/.ssh/id_ed25519*.pub; do awk '{print $3, $1, $2}' "$k"; done > ~/.config/git/allowed_signers
```
