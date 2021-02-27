Split-SSH
=========

A Salt state that enables [split-SSH][split-ssh] in Qubes OS.

Overview
--------

- Ensures the existence of a `ssh-vault` qube that starts automatically on system startup. This qube has no network access and holds SSH keys.
- Ensures the presence of a Qubes RPC policy in `dom0`. That policy ensures that the user is asked before any qube accesses the SSH keys contained in `ssh-vault`.
- Ensures a `ssh-client` qube exists. That qube is configured to allow usage of SSH but relies on the SSH keys contained in `ssh-vault`.

Installation
------------

### Recommended installation

Build and sign an RPM package in order to install this Salt state in _dom0_. See [qubes-mgmt-salt-user-split-ssh][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/packages/split-ssh

### Manual installation

- Enable the Salt _user directories_ ([how-to][user-dirs-how-to])
- Copy, or type the contents of the `state/` directory into `/srv/user_salt/split-ssh/`.
- Inspect the surounding files and apply similar permissions and ownership to the `/srv/user_salt/split-ssh` directory.

Usage
-----

Enable the top files:

```sh
sudo qubesctl top.enable split-ssh.client split-ssh.policy split-ssh.vault
```

Apply the state:

```sh
sudo qubesctl --targets=fedora-32,ssh-client,ssh-vault state.apply
```

**Note**: the `ssh-client` and `ssh-vault` machines will be created if they don't exist. That is the point of having a Salt state! They are part of the targets because because part of the configuration applies to them.

Once the state is enforced, create new SSH keys in `ssh-vault` (or copy existing keys if you prefer).

References
----------

- [Using split ssh in QubesOS 4.0][split-ssh]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]

  [split-ssh]: https://kushaldas.in/posts/using-split-ssh-in-qubesos-4-0.html
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
