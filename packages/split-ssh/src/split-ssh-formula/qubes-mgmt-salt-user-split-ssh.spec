Name:           qubes-mgmt-salt-user-split-ssh
Version:        0.1.0
Release:        1%{?dist}
Summary:        A Salt state that enables split-SSH in Qubes OS

License:        GPLv2
URL:            https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user
Source0:        %{name}-%{version}.tar.gz

Group:          System administration tools
BuildArch:      noarch

%description
A Salt state that enables split-SSH in Qubes OS.

%prep
%setup -q

%build
make

%install
make install DESTDIR=%{buildroot}

%files
%license LICENSE
%doc README.md
%config /srv/user_pillar/split-ssh/config.yaml
/srv/user_pillar/split-ssh
/srv/user_salt/split-ssh

%changelog
* Mon Feb  8 2021 Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
- Initial packaging
