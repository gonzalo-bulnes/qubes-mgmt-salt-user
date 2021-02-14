User Salt States for Qubes OS
=============================

A collection of user Salt states for Qubes OS.

- **Split-SSH** ([sources][split-ssh-src], [packaging][split-ssh-pkg])

  [split-ssh-src]: ./states/split-ssh/src
  [split-ssh-pkg]: ./states/split-ssh

Usage
-----

### Prerequisites

Enable the Salt [user directories][qubes-user-dirs] if you haven't already. This allows to install Salt states without mixing them with the `base` states that are maintained by the Qubes OS team.

```sh
sudo qubesctl top.enable qubes.user-dirs
```

  [qubes-user-dirs]: https://github.com/QubesOS/qubes-mgmt-salt-base-config#qubesuser-dirs

Then apply the state to ensure the directories are present:

```sh
sudo qubesctl state.apply
```

### Step-by-step

This repository contains multiple states and it is not required to use them all. For each of them, the same enabling steps apply, and `split-ssh` will be used as an example.

#### Install the state

In order to be able to use a state, its definition should be present in the `/srv/user_salt/` directory of _dom0_.


> ⚠ **Security warning**: Since any domain is _less trusted_ than _dom0_ (by definition), copying anything into _dom0_ requires extreme caution. See [References](#references) for details, and use own judgement.
>
> Next to each state **sources** (e.g. [split-SSH sources][split-ssh-src]), this repository provides **packaging tools** (e.g. [split-SSH packaging][split-ssh-pkg]) that allow to take advantage of [dom0's secure update][secure-update] to install the sources. That's what I prefer, but please bear in mind that your circumstances and mine could be different.

  [secure-update]: https://www.qubes-os.org/doc/dom0-secure-updates


No matter how you decide to perform this step, the end result should be a directory containing one or more `.top` files (and the corresponding `.sls` and other files):

```sh
/srv/user_salt/split-ssh
```

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
For example, the `split-ssh` state targets `dom0` and the `fedora-32` template, as well as two qubes called `ssh-vault` and `ssh-client`:

```sh
sudo qubesctl --targets=fedora-32,ssh-client,ssh-vault state.apply
```

Note that _dom0_ is always implicitly targetted by `qubesctl` (and appears in the output as `local`). If you know it doesn't need to be updated, you can skip _dom0_:

```sh
sudo qubesctl --skip-dom0 --targets=fedora-32,ssh-client,ssh-vault state.apply # in this example, that would be enough if the qubes already exist
```

Contributing
------------

### Known issues

#### Top file merging strategy

After enabling the `user` environment, applying the state causes the following warning:

```sh
[WARNING ] top_file_merging_strategy is set to 'merge' and multiple top files were found. Merging order is not deterministic, it may be desirable to either set top_file_merging_strategy to 'same' or use the 'env_order' configuration parameter to specify the merging order.
```

I haven't yet looked up where the `top_file_merging_strategy` can be configured.

References
----------

- [Copying to _dom0_](https://www.qubes-os.org/doc/copy-from-dom0)

