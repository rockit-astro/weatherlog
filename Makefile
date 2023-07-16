RPMBUILD = rpmbuild --define "_topdir %(pwd)/build" \
        --define "_builddir %{_topdir}" \
        --define "_rpmdir %{_topdir}" \
        --define "_srcrpmdir %{_topdir}" \
        --define "_sourcedir %(pwd)"

all:
	mkdir -p build
	date --utc +%Y%m%d%H%M%S > VERSION
	${RPMBUILD} --define "_version %(cat VERSION)" -ba rockit-weatherlog.spec
	mv build/noarch/*.rpm .
	rm -rf build VERSION

install:
	@sudo cp update-weather-database /usr/bin/
	@sudo cp update-weather.service /etc/systemd/system/
	@echo ""
	@echo "Installation complete."
