QVM Features in Salt Pillar
===========================

A Salt formula that exposes [QVM _features_][qvm-features] in Salt _pillar_.

Overview
--------

### Access QVM features in Salt states

Given the following feature in _dom0_:

```sh
# dom0

qvm-features dom0
# [...]
# u2f-frontends    personal work
```

States can be generated dynamically using a Jinja template:

```salt
# /srv/user_salt/u2f/init.top

user:
  dom0:
    - u2f.services
```

```salt
# /srv/user_salt/u2f/services.sls

{% for frontends in pillar.get('qubes').get('features').get('u2f-frontends').split(' ') -%}
{{ frontend }}-u2f-proxy-service-is-enabled:
  qvm.features:
    - name: {{ frontend }}
    - enable:
      - service.qubes-u2f-proxy
{% endfor -%}
```

**Note**: the example uses the `qvm.features` formula to enable a service, that's only a coincidence!

What is worth noticing is that exposing QVM features to the pillar allows to address the following two constraints, without pre-defining the name of the qubes in the Salt state:

- the states that enable services do require the `name` of the _qube_
- state IDs must be unique

With a template like this, new U2F frontends can be added by editing the QVM feature instead of requiring any of the Salt states to be manually changed or augmented.

```sh
# dom0

# Add some-other-qube to the list of U2F frontends
qvm-features dom0 u2f-frontends "personal work some-other-qube"

# Ensure the qubes-u2f-proxy service is enabled in all U2F frontends
sudo qubesctl state.apply
```

Installation
------------

### Recommended installation

_Coming soon..._

Build and sign an RPM package in order to install this Salt formula in _dom0_. See [qubes-mgmt-salt-user-qvm-features-in-pillar][rpm].

  [rpm]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/tree/main/packages/qvm-features-in-pillar

### Manual installation

- Enable the Salt _user directories_ ([how-to][user-dirs-how-to])
- Copy, or type the contents of the `state/` directory into `/srv/user_salt/qvm-features-in-pillar/`.

Usage
-----

Enable the top file:

```sh
# dom0

sudo qubesctl top.enable qvm-features-in-pillar
```

Apply the state:

```sh
# dom0

sudo qubesctl state.apply  # dom0 is the default target
```

Once the state is enforced, define the features you want to use and create the Salt files you need.

References
----------

- [QVM Features tooling][qvm-features]
- [Inspiration and code][gist]
- [How to enable the Salt user directories in Qubes OS][user-dirs-how-to]
- [Qubes U2F proxy from where the example is taken][u2f-proxy]

  [qvm-features]: https://dev.qubes-os.org/projects/core-admin-client/en/latest/manpages/qvm-features.html
  [gist]: https://gist.github.com/bcduggan/d0ee8a22767b32fc23d063ccf9385623
  [user-dirs-how-to]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user#prerequisites
  [u2f-proxy]: https://www.qubes/os.org/doc/u2f-proxy/
