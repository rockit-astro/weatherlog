Name:      rockit-weather-database-updater
Version:   %{_version}
Release:   1
Summary:   Weather database updater.
License:   GPL-3.0
Url:       https://github.com/rockit-astro/weatherlog
BuildArch: noarch
Requires:  python3-rockit-common

%description

%build
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_unitdir}

%{__install} %{_sourcedir}/update-weather-database %{buildroot}%{_bindir}
%{__install} %{_sourcedir}/update-weather.service %{buildroot}%{_unitdir}

%files
%defattr(0755,root,root,-)
%{_bindir}/update-weather-database
%defattr(-,root,root,-)
%{_unitdir}/update-weather.service

%changelog
