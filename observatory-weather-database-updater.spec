Name:      observatory-weather-database-updater
Version:   2.2.0
Release:   0
Url:       https://github.com/warwick-one-metre/weatherlogd
Summary:   Weather logger for the Warwick one-metre telescope.
License:   GPL-3.0
Group:     Unspecified
BuildArch: noarch
%if 0%{?suse_version}
Requires:  python3, python34-Pyro4, python34-PyMySQL, python34-warwick-observatory-common, mariadb, %{?systemd_requires}
BuildRequires: systemd-rpm-macros
%endif
%if 0%{?centos_ver}
Requires:  python34, python34-Pyro4, python34-PyMySQL, python34-warwick-observatory-common, mariadb, mariadb-server, %{?systemd_requires}
%endif

%description
Part of the observatory software for the Warwick one-meter telescope.

update-weather-database polls the local sensors and updates the weather database.

%build
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_unitdir}

%{__install} %{_sourcedir}/update-weather-database %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-weather-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/update-weather-database.timer %{buildroot}%{_unitdir}

%pre
%if 0%{?suse_version}
%service_add_pre update-weather-database.timer
%endif

%post
%if 0%{?suse_version}
%service_add_post update-weather-database.timer
%endif
%if 0%{?centos_ver}
%systemd_post update-weather-database.timer
%endif

%preun
%if 0%{?suse_version}
%stop_on_removal update-weather-database.timer
%service_del_preun update-weather-database.timer
%endif
%if 0%{?centos_ver}
%systemd_preun update-weather-database.timer
%endif

%postun
%if 0%{?suse_version}
%restart_on_update update-weather-database.timer
%service_del_postun update-weather-database.timer
%endif
%if 0%{?centos_ver}
%systemd_postun_with_restart update-weather-database.timer
%endif

%files
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%defattr(-,root,root,-)
%{_unitdir}/update-weather-database.service
%{_unitdir}/update-weather-database.timer

%changelog
