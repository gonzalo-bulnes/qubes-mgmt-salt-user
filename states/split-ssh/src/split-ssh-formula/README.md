Split-SSH
=========

A Salt state that enables [split-SSH][split-ssh] in Qubes OS.

Overview
--------

### Defaults

- Ensures the existence of a `ssh-vault` qube that starts automatically on system startup. This qube has no network access and holds SSH keys.
- Ensures the presence of a Qubes RPC policy in `dom0`. That policy ensures that the user is asked before any qube accesses the SSH keys contained in `ssh-vault`.
- Ensures a `ssh-client` qube exists. That qube is configured to allow usage of SSH but relies on the SSH keys contained in `ssh-vault`.

### Configuration

- Allows any number of clients and vaults to be defined via a signle Salt pillar configuration file
- **Known limitation**: in practice all clients will be configured to use the first vault. If you need a multi-vault setup, please rech out! Some of the state is ready to support multi-vault setups but not all of it.

Installation
------------

### Recommended

You can build and sign an RPM package in order to install it in _dom0_. See [qubes-mgmt-salt-user-split-ssh][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/states/split-ssh

### Alternative

- Copy, or type the contents of this `split-ssh` into `/srv/user_salt/split-ssh/`.
- Copy, or type the contents of this `pillar` into `/srv/user_pillar/split-ssh/`.
- Inspect the surounding files and apply similar permissions and ownership to the `/srv/user_salt/split-ssh` and `srv/user_pillar/split-ssh` directories.

Usage
-----

Enable the top files:

```sh
sudo qubesctl top.enable split-ssh.client split-ssh.policy split-ssh.vault
```

Modify the configuration if you wish (`/srv/user_pillar/split-ssh/config.yaml`):

```yaml
---
vaults:
  - name: ssh-vault
    template: fedora-32
    label: black
    mem: 400
    vcpus: 2
    autostart: True

clients:
  - name: ssh-client
    template: fedora-32
    label: blue
    mem: 400
    vcpus: 2
    autostart: False

```

Apply the state (adapt the targets according to your configuration):

```sh
sudo qubesctl --targets=fedora-32,ssh-client,ssh-vault state.apply
```

**Note**: the `ssh-client` and `ssh-vault` machines will be created if they don't exist. That is the point of having a Salt state! They are part of the targets because because part of the configuration applies to them.

Once the state is enforced, create new SSH keys in `ssh-vault` (or copy existing keys if you prefer).

References
----------

- [Salt user directories in Qubes OS][user-dirs]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]
- [Using split ssh in QubesOS 4.0][split-ssh]

  [user-dirs]: https://github.com/QubesOS/qubes-mgmt-salt-base-config#qubesuser-dirs
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
  [split-ssh]: https://kushaldas.in/posts/using-split-ssh-in-qubesos-4-0.html

