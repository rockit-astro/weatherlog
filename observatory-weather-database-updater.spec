Name:      observatory-weather-database-updater
Version:   20211208
Release:   0
Url:       https://github.com/warwick-one-metre/weatherlogd
Summary:   Weather logger for the Warwick La Palma telescopes.
License:   GPL-3.0
Group:     Unspecified
BuildArch: noarch
Requires:  python3, python3-Pyro4, python3-pymysql, python3-warwick-observatory-common
Requires:  mariadb, mariadb-server, %{?systemd_requires}

%description

%build
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_unitdir}

%{__install} %{_sourcedir}/update-weather-database %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-weather-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/update-weather-database.timer %{buildroot}%{_unitdir}

%post
%systemd_post update-weather-database.timer

%preun
%systemd_preun update-weather-database.timer

%postun
%systemd_postun_with_restart update-weather-database.timer

%files
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%defattr(-,root,root,-)
%{_unitdir}/update-weather-database.service
%{_unitdir}/update-weather-database.timer

%changelog
