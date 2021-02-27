Split-SSH
=========

A Salt formula that enables [split-SSH][split-ssh] in Qubes OS.

Overview
--------

- Ensures the existence of a **vault** qube that starts automatically on system startup. This qube has no network access and holds SSH keys.
- Ensures the presence of a Qubes RPC policy in `dom0`. That policy ensures that the user is asked before any qube accesses the SSH keys contained in the **vault**.
- Ensures a **client** qube exists. That qube is configured to allow usage of SSH but relies on the SSH keys contained in the **vault**.

By default, the **vault** is a _qube_ called `ssh-vault` and the **client** is a _qube_ called `ssh-client`, but that configuration can be changed if needeed.

Installation
------------

### Recommended installation

Build and sign an RPM package in order to install this Salt formula in _dom0_. See [qubes-mgmt-salt-user-split-ssh][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/packages/split-ssh

### Manual installation

- Enable the Salt _user directories_ ([how-to][user-dirs-how-to])
- Copy, or type the contents of the `state/` directory into `/srv/user_salt/split-ssh/`.
- Copy, or type the contents of the `pillar/` directory into `/srv/user_pillar/split-ssh/`.
- Inspect the surounding files and apply similar permissions and ownership to the `/srv/user_salt/split-ssh` and `/srv/user_pillar/split-ssh` directories.

Usage
-----

Adapt the configuration to your needs if necessary by modifying `/srv/user_pillar/split-ssh/config.yaml`.

Enable the top files:

```sh
sudo qubesctl top.enable split-ssh.client split-ssh.policy split-ssh.vault
```

Apply the state (if you modified the configuration, adjust the targets accordingly):

```sh
sudo qubesctl --targets=fedora-32,ssh-client,ssh-vault state.apply
```

**Note**: the configured **client** and **vault** machines will be created if they don't exist. That is the point of using a Salt formula! They are part of the targets because because part of the configuration applies to them.

Once the state is enforced, create new SSH keys in the **vault** (or copy existing keys if you prefer).

References
----------

- [Using split ssh in QubesOS 4.0][split-ssh]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]

  [split-ssh]: https://kushaldas.in/posts/using-split-ssh-in-qubesos-4-0.html
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
