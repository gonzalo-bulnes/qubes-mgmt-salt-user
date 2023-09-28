Split-SSH
=========

A Salt formula that enables [split-SSH][split-ssh] in Qubes OS.

Overview
--------

This formula configures a set of existing _qubes_ to provide Split-SSH. The qubes are expected to exist and be identified via a set of QVM tags.

Installation
------------

### Recommended installation

Build and sign an RPM package in order to install this Salt formula in _dom0_. See [qubes-mgmt-salt-user-split-ssh][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/packages/split-ssh

### Manual installation

- Enable the Salt _user directories_ ([how-to][user-dirs-how-to])
- Copy, or type the contents of the `state/` directory into `/srv/user_salt/split-ssh/`.

Usage
-----

### Apply QVM tags

- Any qube that should act as a Split-SSH _vault_ must be tagged as `split-ssh-vault`.
  It's _template_ must be tagged as `split-ssh-vault-template`.
 
  ```sh
  # dom0

  qvm-tags vault add split-ssh-vault

  # Assuming that vault is based on debian-12
  qvm-tags debian-12 add split-ssh-vault-template
  ```

- Any _qube_ that should act as a Split-SSH _client_ must be tagged as `split-ssh-client` and `split-ssh-vault-is-<name of vault>`. (For example: `split-ssh-vault-is-vault`.)
  The corresponding template must be tagged as `split-ssh-client-template`.

  ```sh
  # dom0

  qvm-tags work add split-ssh-client
  # Assuming that vault fulfills the Split-SSH vault role for work
  qvm-tags work add split-ssh-vault-is-vault

  # Assuming that work is based on debian-12
  qvm-tags debian-12 add split-ssh-client-template
  ```

That's all.

### Enable Split-SSH

Enable the top files:

```sh
# dom0

sudo qubesctl top.enable split-ssh
```

Apply the state (if you modified the configuration, adjust the targets accordingly):

```sh
# dom0

sudo qubesctl --targets=debian-12,work,vault state.apply  # dom0 is an implicit target
```

Once the state is enforced, create new SSH keys in the **vault** (or copy existing keys if you prefer).

References
----------

- [Using split ssh in QubesOS 4.0][split-ssh]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]

  [split-ssh]: https://kushaldas.in/posts/using-split-ssh-in-qubesos-4-0.html
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
