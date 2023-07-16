Name:           python3-rockit-weatherlog
Version:        %{_version}
Release:        1
Summary:        Backend code for the weather database updater
License:        GPL3
Url:            https://github.com/rockit-astro/weatherlog
BuildArch:      noarch
BuildRequires:  python3-devel

%description

%prep
rsync -av --exclude=build --exclude=.git --exclude=.github .. .

%generate_buildrequires
%pyproject_buildrequires -R

%build
%pyproject_wheel

%install
%pyproject_install
%pyproject_save_files rockit

%files -f %{pyproject_files}
