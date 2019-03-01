Name:      observatory-weather-database-updater
Version:   2.4.0
Release:   0
Url:       https://github.com/warwick-one-metre/weatherlogd
Summary:   Weather logger for the Warwick one-metre telescope.
License:   GPL-3.0
Group:     Unspecified
BuildArch: noarch
Requires:  python36, python36-Pyro4, python36-PyMySQL, python36-warwick-observatory-common
Requires:  mariadb, mariadb-server, %{?systemd_requires}

%description
Part of the observatory software for the Warwick one-meter telescope.

update-weather-database polls the local sensors and updates the weather database.

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
