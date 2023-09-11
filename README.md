User Salt Formulas for Qubes OS
===============================

A collection of user Salt formulas for Qubes OS.

- **QVM Features in Salt Pillar** ([sources][qvm-features-in-pillar-src])
- **QVM Tags in Salt Pillar** ([sources][qvm-tags-in-pillar-src])
- **Split-GPG** ([sources][split-gpg-src], [packaging][split-gpg-pkg])
- **Split-SSH** ([sources][split-ssh-src], [packaging][split-ssh-pkg])

  [qvm-features-in-pillar-src]: ./packages/qvm-features-in-pillar/src
  [qvm-tags-in-pillar-src]: ./packages/qvm-tags-in-pillar/src
  [split-gpg-src]: ./packages/split-gpg/src
  [split-gpg-pkg]: ./packages/split-gpg
  [split-ssh-src]: ./packages/split-ssh/src
  [split-ssh-pkg]: ./packages/split-ssh

Overview
--------

This repository contains a collection of Salt formulas that I use in Qubes OS, along with **the tooling necessary to create RPM packages** in order to get those Salt formulas into _dom0_ in a reasonably secure fashion.

See [RPM packaging in the context of Qubes OS][rpm-packaging] for more information about why RPM packages may be a good way to copy files into _dom0_.

See also the [References](#references) section in this README, bear in mind that your cirumstances and mine could be different, and use own judgement.

  [rpm-packaging]: https://docs.gonzalobulnes.com/configuration_management.html#rpm-packaging

Usage
-----

### Prerequisites

Enable the Salt [user directories][qubes-user-dirs] if you haven't already. This allows to install Salt formulas without mixing them with the `base` formulas that are maintained by the Qubes OS team.

```sh
# dom0

sudo qubesctl top.enable qubes.user-dirs
```

  [qubes-user-dirs]: https://github.com/QubesOS/qubes-mgmt-salt-base-config#qubesuser-dirs

Then apply the state to ensure the directories are present:

```sh
# dom0

sudo qubesctl state.apply
```

### Installation

This repository contains multiple formulas and it is not required to use them all. For each of them, similar installation and usage instructions apply: please refer to their respective READMEs for details.

### Useful commands

#### Enabling a formula

In Qubes OS, Salt states are applied by `qubesctl`. No state will be applied by `qubesctl` unless its _top files_ have been enabled.

In `qubesctl`/Salt context, the directories are separated by a `.` and the `.top` extension is omitted.
Multiple _top files_ can be enabled all at once:

```sh
# dom0

sudo qubesctl top.enable split-ssh.client split-ssh.policy split-ssh.vault
```

At any time, you can list all the enabled formulas:

```sh
# dom0

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

#### Applying the state

If you've got time to spare, the enabled states can be applied at once across all qubes:

```sh
# dom0

sudo qubesctl --all state.apply
```

Each state targets one or more qubes, and if you know which qubes you're modifying you can save some time by targetting them specifically.

```sh
# dom0

sudo qubesctl --targets=debian-11,ssh-client,ssh-vault state.apply
```

Note that _dom0_ is always implicitly targetted by `qubesctl` (and appears in the output as `local`). If you know it doesn't need to be updated, you can skip _dom0_:

```sh
# dom0

sudo qubesctl --skip-dom0 --targets=debian-11,ssh-client,ssh-vault state.apply
```

Development
-----------

### Pre-requisites

#### Platform

I personally build the packages on the target platform, because Qubes OS templates make that easy, and it makes sense to me to do it. For now I'll assume you do the same.

For Qubes OS R4.1, that means a **Fedora 32** _qube_. That _qube_ can be completely offline.


#### Tito and rpm-sign

[Tito][tito] is in charge of building the RPM packages. Make sure it is installed:

```sh
# fedora-32

sudo dnf install tito
```

The entire point of building our own packages is being able to sign them. To do that, `rpm-sign` must be installed.

```sh
# fedora-32

sudo dnf install rpm-sign
```

  [tito]: https://github.com/rpm-software-management/tito

#### Using RPM with Split-GPG

If you use _Split-GPG_ on Qubes OS, some configuration is needed to ensure that RPM tooling can sign the packages. That can be done adding the following to the `~/.rpmmarcos` file of the _qube_ where you'll build the packages. (Of course, that qube also needs allow the use of Split GPG.)

```specfile
# ~/.rpmmacros

# ...

# Use split-GPG. The options are adjusted below.
%__gpg /usr/bin/qubes-gpg-client-wrapper

# Your signing key name would be different:
%_gpg_name Package Signing Key

# Based on the default command defined in /usr/lib/rpm/macros
# Removed the options: --no-armor --no-verbose --no-secmem-warning because qubes-gpg-client-wrapper doesn't support them
# Separated the option -o from -sb because qubes-gpg-client-wrapper was getting confused
%__gpg_sign_cmd                 %{__gpg} \
        gpg \
        %{?_gpg_digest_algo:--digest-algo %{_gpg_digest_algo}} \
        %{?_gpg_sign_cmd_extra_args:%{_gpg_sign_cmd_extra_args}} \
        -u "%{_gpg_name}" -sb -o %{__signature_filename} %{__plaintext_filename}
# ...
```

Note: you'll export the name of the GPG key as `GPG_NAME` later on. Both need to match!

### Building packages

In order to build packages for a given formula (e.g. the split-SSH formula):

1. Set the formula version number and the package release number:

   ```sh
   # The name of the Salt formula
   export FORMULA=split-ssh

   # The version of the formula (sources)
   export VERSION=0.8.0

   # The release of the RPM package
   export RELEASE=4

   make release
   ```

2. Commit the changes, create a Git tag for Tito, and a [signed tag][stag] for sources verification purposes:

   ```sh
   # This uses all the environment variables defined above.

   # The GPG key to verify the sources and sign the RPM packages
   export GPG_NAME="Key ID"

   # The commit message can be whatever you want
   git commit -m "Release ${FORMULA}-${VERSION}-${RELEASE}"

   # This tag is required to build the packages with Tito
   git tag qubes-mgmt-salt-user-${FORMULA}-${VERSION}-${RELEASE}

   # Any signed tag would do
   git stag
   ```

3. Build the packages:

   ```sh
   # This uses all the environment variables defined above.

   make packages
   ```

4. The packages will be created in `/tmp/tito`:

   ```sh
   tree /tmp/tito

   # /tmp/tito/
   # ├── noarch
   # │   └── qubes-mgmt-salt-user-split-ssh-0.8.0-4.fc32.noarch.rpm
   # ├── qubes-mgmt-salt-user-split-ssh-0.8.0-4.fc32.src.rpm
   # ├── qubes-mgmt-salt-user-split-ssh-0.8.0.tar.gz
   # └── qubes-mgmt-salt-user-split-ssh-0.8.0.tar.gz.asc
   ```

5. Unset the environment variables:

   ```sh
   unset FORMULA
   unset VERSION
   unset RELEASE
   unset GPG_NAME
   ```

  [stag]: https://www.qubes-os.org/doc/code-signing/#using-pgp-with-git

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

Copyright © 2021–2023 Gonzalo Bulnes Guilpain

This project is released under the GNU General Public License v2 (see [LICENSE](LICENSE.md)).

