QVM Tags in Salt Pillar
=======================

A Salt formula that exposes [QVM __tags__][qvm-tags] in Salt _pillar_.

Overview
--------

### Target qubes using QVM tags

Given the following tags:

```sh
# dom0

qvm-tags work
# [...]
# split-ssh-client

qvm-tags debian-11
# [...]
# split-sh-client-template
```

Targets can be defined dynamically:

```salt
# /srv/user_salt/split-ssh/init.top

user:
  qubes:tags:split-ssh-client-template: # ①
    - match: pillar                     # ②
    - split-ssh.client.packages

  qubes:tags:split-ssh-client:
    - match: pillar
    - split-ssh.client.sock
```

- ① Will match all qubes with the specified tag. Note how the names of the qubes don't need to be known when the top file is written.
- ② Don't forget telling Salt that the target pattern is based on pillar data.

Enabling Split-SSH on a new qube becomes as simple as tagging it and its template before applying the state.

```sh
# dom0

# Assuming that the personal qube is based on Fedora 38
qvm-tags personal add split-ssh-client
qvm-tags fedora-38 add split-ssh-client-template

sudo qubesctl --skip-dom0 --targets=personal,fedora-38 state.apply
```

### Access QVM tags in Salt states

Given the following tag:

```sh
# dom0

qvm-tags work
# [...]
# split-ssh-vault-is-my-favorite-vault
```

The tag can be retrieved from a Jinja template:

```sh
# /srv/user_salt/split-ssh/client/files/bashrc.d/sock.jinja

# The following will be appended to the ~/.bashrc of each Split-SSH client.
{% set tags = pillar.get('qubes').get('tags') -%}
{% for tag in tags -%}
  {%- if tag.startswith('split-ssh-vault-is-') -%}
    {%- set vault = tag[19:] -%}
SSH_VAULT_VM={{ vault }}
  {%- endif -%}
{% endfor -%}

if [ "$SSH_VAULT_VM" != "" ]; then
  export SSH_AUTH_SOCK=/home/user/.SSH_AGENT_$SSH_VAULT_VM
fi
```

Installation
------------

### Recommended installation

_Coming soon..._

Build and sign an RPM package in order to install this Salt formula in _dom0_. See [qubes-mgmt-salt-user-qvm-tags-in-pillar][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/packages/qvm-tags-in-pillar

### Manual installation

- Enable the Salt _user directories_ ([how-to][user-dirs-how-to])
- Copy, or type the contents of the `state/` directory into `/srv/user_salt/qvm-tags-in-pillar/`.

Usage
-----

Enable the top file:

```sh
# dom0

sudo qubesctl top.enable qvm-tags-in-pillar
```

Apply the state:

```sh
# dom0

sudo qubesctl state.apply  # dom0 is the default target
```

Once the state is enforced, define the tags you want to use and create the Salt files you need.

References
----------

- [QVM Tags tooling][qvm-tags]
- [Inspiration and code][gist]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]
- [Split-SSH from where the example is taken][split-ssh]

  [qvm-tags]: https://dev.qubes-os.org/projects/core-admin-client/en/latest/manpages/qvm-tags.html
  [gist]: https://gist.github.com/bcduggan/d0ee8a22767b32fc23d063ccf9385623
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
  [split-ssh]: https://kushaldas.in/posts/using-split-ssh-in-qubesos-4-0.html
  