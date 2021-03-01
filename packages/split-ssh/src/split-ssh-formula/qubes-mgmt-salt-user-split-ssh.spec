Name:           qubes-mgmt-salt-user-split-ssh
Version:        0.2.0
Release:        1%{?dist}
Summary:        A Salt formula that enables split-SSH in Qubes OS

License:        GPLv2
URL:            https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user
Source0:        %{name}-%{version}.tar.gz

Group:          System administration tools
BuildArch:      noarch

%description
A Salt formula that enables split-SSH in Qubes OS.

%prep
%setup -q

%build
make

%install
make install DESTDIR=%{buildroot}

# Work around missing pillar_root for /srv/user_pillar
mkdir -p %{buildroot}/srv/pillar/_tops/user/
ln -s %{buildroot}/srv/user_pillar/split-ssh %{buildroot}/srv/pillar/split-ssh
ln -s %{buildroot}/srv/user_pillar/split-ssh/init.jinja %{buildroot}/srv/pillar/_tops/user/split-ssh.top

%files
%license LICENSE
%doc README.md
%config /srv/user_pillar/split-ssh/config.yaml
/srv/user_pillar/split-ssh
/srv/user_salt/split-ssh
/srv/pillar/split-ssh
/srv/pillar/_tops/split-ssh.top

%changelog
* Mon Mar 01 2021 Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
- Ensure pillar is enabled by working around missing pillar_root for /srv/user_pillar

* Sun Feb 28 2021 Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
- Ensure Salt pillar is installed

* Mon Feb  8 2021 Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
- Initial packaging
