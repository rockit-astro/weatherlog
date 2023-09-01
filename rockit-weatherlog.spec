Name:      rockit-weatherlog
Version:   %{_version}
Release:   1
Summary:   Weather database updater.
License:   GPL-3.0
Url:       https://github.com/rockit-astro/weatherlog
BuildArch: noarch
%description

%build
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_unitdir}
mkdir -p %{buildroot}%{_sysconfdir}/weatherlog

%{__install} %{_sourcedir}/update-weather-database %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-weather-json %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-weather-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/update-environment-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/update-infrastructure-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/lapalma_environment.json %{buildroot}%{_sysconfdir}/weatherlog/
%{__install} %{_sourcedir}/lapalma_infrastructure.json %{buildroot}%{_sysconfdir}/weatherlog/
%{__install} %{_sourcedir}/warwick.json %{buildroot}%{_sysconfdir}/weatherlog/

%package lapalma
Summary:  Weather log data for La Palma telescopes
Group:    Unspecified
Requires: python3-rockit-weatherlog
%description lapalma

%files lapalma
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%{_bindir}/update-weather-json
%defattr(0644,root,root,-)
%{_unitdir}/update-environment-database.service
%{_unitdir}/update-infrastructure-database.service
%{_sysconfdir}/weatherlog/lapalma_environment.json
%{_sysconfdir}/weatherlog/lapalma_infrastructure.json

%package warwick
Summary:  Weather log data for Windmill Hill observatory
Group:    Unspecified
Requires: python3-rockit-weatherlog
%description warwick

%files warwick
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%{_bindir}/update-weather-json
%defattr(0644,root,root,-)
%{_unitdir}/update-weather-database.service
%{_sysconfdir}/weatherlog/warwick.json

%changelog
