Split-SSH
=========

A Salt formula that enables [split-SSH][split-ssh] in Qubes OS.

Overview
--------

FIXME

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

FIXME

Enable the top files:

```sh
# dom0

sudo qubesctl top.enable split-ssh
```

Apply the state (if you modified the configuration, adjust the targets accordingly):

```sh
# dom0

sudo qubesctl --targets=debian-12,ssh-client,ssh-vault state.apply
```

Once the state is enforced, create new SSH keys in the **vault** (or copy existing keys if you prefer).

References
----------

- [Using split ssh in QubesOS 4.0][split-ssh]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]

  [split-ssh]: https://kushaldas.in/posts/using-split-ssh-in-qubesos-4-0.html
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
