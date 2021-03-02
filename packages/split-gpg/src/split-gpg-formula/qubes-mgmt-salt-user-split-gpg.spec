Name:           qubes-mgmt-salt-user-split-gpg
Version:        0.1.0
Release:        1%{?dist}
Summary:        A Salt formula that enables split-GPG in Qubes OS

License:        GPLv2
URL:            https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user
Source0:        %{name}-%{version}.tar.gz

Group:          System administration tools
BuildArch:      noarch

%description
A Salt formula that enables split-GPG in Qubes OS.

%prep
%setup -q

%build
make

%install
make install DESTDIR=%{buildroot}

# Work around missing pillar_root for /srv/user_pillar
mkdir -p %{buildroot}/srv/pillar/_tops/user/
ln -s /srv/user_pillar/split-gpg %{buildroot}/srv/pillar/split-gpg
ln -s /srv/user_pillar/split-gpg/init.jinja %{buildroot}/srv/pillar/_tops/user/split-gpg.top

%files
%license LICENSE
%doc README.md
%config /srv/user_pillar/split-gpg/config.yaml
/srv/user_pillar/split-gpg
/srv/user_salt/split-gpg
/srv/pillar/split-gpg
/srv/pillar/_tops/user/split-gpg.top

%changelog

* Tue Mar  2 2021 Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
- Initial packaging
