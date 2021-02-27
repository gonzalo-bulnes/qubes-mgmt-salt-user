User Salt States for Qubes OS
=============================

A collection of user Salt formulas for Qubes OS.

- **Split-SSH** ([sources][split-ssh-src], [packaging][split-ssh-pkg])

  [split-ssh-src]: ./packages/split-ssh/src
  [split-ssh-pkg]: ./packages/split-ssh

Usage
-----

### Prerequisites

Enable the Salt [user directories][qubes-user-dirs] if you haven't already. This allows to install Salt formulas without mixing them with the `base` formulas that are maintained by the Qubes OS team.

```sh
sudo qubesctl top.enable qubes.user-dirs
```

  [qubes-user-dirs]: https://github.com/QubesOS/qubes-mgmt-salt-base-config#qubesuser-dirs

Then apply the state to ensure the directories are present:

```sh
sudo qubesctl state.apply
```

### Step-by-step

This repository contains multiple formulas and it is not required to use them all. For each of them, the same enabling steps apply, and `split-ssh` will be used as an example.

#### Install the formula

In order to be able to use a formula, the state definition should be present in the `/srv/user_salt/` directory of _dom0_, and the pillar definition in `/srv/user_pillar`.


> ⚠ **Security warning**: Since any domain is _less trusted_ than _dom0_ (by definition), copying anything into _dom0_ requires extreme caution. See [References](#references) for details, and use own judgement.
>
> Next to each state **sources** (e.g. [split-SSH sources][split-ssh-src]), this repository provides **packaging tools** (e.g. [split-SSH packaging][split-ssh-pkg]) that allow to take advantage of [dom0's secure update][secure-update] to install the sources. That's what I prefer, but please bear in mind that your circumstances and mine could be different.

  [secure-update]: https://www.qubes-os.org/doc/dom0-secure-updates


No matter how you decide to perform this step, the end result should be a directory containing one or more `.top` files (and the corresponding `.sls` and other files), as well as a directory containing a `config.yaml` file:

```sh
/srv/user_pillar/split-ssh # contains the configuration
/srv/user_salt/split-ssh   # contains the .top files
```
#### Adjust the configuration to fit your needs

The state will be defined by the configuration stored in the pillar. In our example, you can find the default configuration in `/srv/user_pillar/split-ssh/config.yaml` and modify it to fit your needs.

#### Enable the state

In Qubes OS, Salt states are applied by `qubesctl`. No state will be applied by `qubesctl` unless its _top files_ have been enabled.

In our example, three _top files_ are provided:

```sh
sudo ls /srv/user_salt/split-ssh/*.top
# split-ssh/client.top  split-ssh/policy.top  split-ssh/vault.top
```

In `qubesctl`/Salt context, the directories are separated by a `.` and the `.top` extension is omitted.
The _top files_ can be enabled all at once:

```sh
sudo qubesctl top.enable split-ssh.client split-ssh.policy split-ssh.vault
```

At any time, you can list all the enabled states:

```sh
sudo qubesctl top.enabled
# local
#     ----------
#     user:
#         - /srv/salt/_tops/user/split-ssh.vault.top
#         - /srv/salt/_tops/user/split-ssh.client.top
#         - /srv/salt/_tops/user/split-ssh.policy.top
#     base:
#         - /srv/salt/_tops/base/topd.top
#         - /srv/salt/_tops/base/qubes.user-dirs.top
```

#### Apply the state

All the enabled states can be applied at once:

```sh
sudo qubesctl --all state.apply
```

Each state targets one or more qubes, and if you know which qubes you're modifying you can save some time by targetting them specifically.
For example, the `split-ssh` state targets `dom0` by default, as well as the `fedora-32` template, and two qubes called `ssh-vault` and `ssh-client`:

```sh
sudo qubesctl --targets=fedora-32,ssh-client,ssh-vault state.apply
```

Note that _dom0_ is always implicitly targetted by `qubesctl` (and appears in the output as `local`). If you know it doesn't need to be updated, you can skip _dom0_:

```sh
sudo qubesctl --skip-dom0 --targets=fedora-32,ssh-client,ssh-vault state.apply # in this example, that would be enough if the client and vault qubes already exist
```

References
----------

- [Copying to _dom0_](https://www.qubes-os.org/doc/copy-from-dom0)

Contributions
-------------

Contributions are welcome! Please refer to the [contribution guidelines][contributing] to get started.

Please note that this project is released with a [Contributor Code of Conduct][coc]. By participating in this project you agree to abide by its terms.

  [contributing]: ./CONTRIBUTING.md
  [coc]: ./CODE_OF_CONDUCT.md

License
-------

Copyright © 2021 Gonzalo Bulnes Guilpain

This project is released under the GNU General Public License v2 (see [LICENSE](LICENSE.md)).

