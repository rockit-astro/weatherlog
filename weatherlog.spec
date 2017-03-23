Name:      onemetre-weatherlog
Version:   1.16
Release:   0
Url:       https://github.com/warwick-one-metre/weatherlogd
Summary:   Weather logger for the Warwick one-metre telescope.
License:   GPL-3.0
Group:     Unspecified
BuildArch: noarch
Requires:  python3, python3-warwickobservatory, python3-PyMySQL, mysql, %{?systemd_requires}
BuildRequires: systemd-rpm-macros

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
%service_add_pre update-weather-database.timer

%post
%service_add_post update-weather-database.timer

%preun
%stop_on_removal update-weather-database.timer
%service_del_preun update-weather-database.timer

%postun
%restart_on_update update-weather-database.timer
%service_del_postun update-weather-database.timer

%files
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%defattr(-,root,root,-)
%{_unitdir}/update-weather-database.service
%{_unitdir}/update-weather-database.timer

%changelog
