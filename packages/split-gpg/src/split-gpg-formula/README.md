Split-GPG
=========

A Salt formula that enables [split-GPG][split-gpg] in Qubes OS.

Overview
--------

- Ensures the existence of a **vault** qube. This qube has no network access and holds the master GPG key(s).
- Ensures the existence of a **backend** qube that starts automatically on system startup. This qube has no network access and holds the GPG subkey(s) that were generated in the **vault** from the master key.
- Ensures the presence of a Qubes RPC policy in `dom0`. That policy ensures that access to the **vault** from any other qubes is denied. The policy also ensures that the user is asked before any qube accesses the GPG (sub)keys contained in the **backend**.
- Ensures a **client** qube exists. That qube is configured to allow usage of GPG but relies on the GPG (sub)keys contained in the **backend**.

By default, the **vault** is a _qube_ called `gpg-vault`, the **backend** is a _qube_ called `gpg-backend` and the **client** is a _qube_ called `gpg-client`, but that configuration can be changed if needeed.

Installation
------------

### Recommended installation

Build and sign an RPM package in order to install this Salt formula in _dom0_. See [qubes-mgmt-salt-user-split-gpg][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/packages/split-gpg

### Manual installation

- Enable the Salt _user directories_ ([how-to][user-dirs-how-to])
- Copy, or type the contents of the `state/` directory into `/srv/user_salt/split-gpg/`.
- Copy, or type the contents of the `pillar/` directory into `/srv/user_pillar/split-gpg/`.
- Inspect the surrounding files and apply similar permissions and ownership to the `/srv/user_salt/split-gpg` and `/srv/user_pillar/split-gpg` directories.

Usage
-----

Adapt the configuration to your needs if necessary by modifying `/srv/user_pillar/split-gpg/config.yaml`.

Enable the top files:

```sh
sudo qubesctl top.enable split-gpg.backend split-gpg.client split-gpg.policy split-gpg.vault
```

Apply the state (if you modified the configuration, adjust the targets accordingly):

```sh
sudo qubesctl --targets=fedora-32,gpg-client state.apply
```

**Note**: the configured **backend**, **client** and **vault** machines will be created if they don't exist. That is the point of using a Salt formula! The client is part of the targets because because part of the configuration applies to it.

Once the state is enforced, create new GPG keys and subkeys in the **vault**, copy the subkey(s) to the **backend** using `qvm-copy` and import them using GPG. When you use `qubes-gpg-client-wrapper` in the **client**, it's the **backend**'s GPG that is be used. The master GPG key never needs (or should) leave the **vault**.

References
----------

- [Using split gpg in QubesOS 4.0][split-gpg]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]

  [split-gpg]: https://www.qubes-os.org/doc/split-gpg
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
