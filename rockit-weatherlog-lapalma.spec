Name:      rockit-weatherlog-lapalma
Version:   %{_version}
Release:   1
Summary:   Weather database updater.
License:   GPL-3.0
Url:       https://github.com/rockit-astro/weatherlog
BuildArch: noarch
Requires:  python3-rockit-common python3-rockit-weatherlog

%description

%build
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_unitdir}
mkdir -p %{buildroot}%{_sysconfdir}/weatherlog

%{__install} %{_sourcedir}/update-weather-database %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-weather-json %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-environment-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/update-infrastructure-database.service %{buildroot}%{_unitdir}
%{__install} %{_sourcedir}/lapalma_environment.json %{buildroot}%{_sysconfdir}/weatherlog/
%{__install} %{_sourcedir}/lapalma_infrastructure.json %{buildroot}%{_sysconfdir}/weatherlog/

%files
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%{_bindir}/update-weather-json
%defattr(-,root,root,-)
%{_unitdir}/update-environment-database.service
%{_unitdir}/update-infrastructure-database.service
%{_sysconfdir}/weatherlog/lapalma_environment.json
%{_sysconfdir}/weatherlog/lapalma_infrastructure.json

%changelog
