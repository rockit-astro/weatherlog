RPMBUILD = rpmbuild --define "_topdir %(pwd)/build" \
        --define "_builddir %{_topdir}" \
        --define "_rpmdir %{_topdir}" \
        --define "_srcrpmdir %{_topdir}" \
        --define "_sourcedir %(pwd)"

all:
	mkdir -p build
	date --utc +%Y%m%d%H%M%S > VERSION
	${RPMBUILD} --define "_version %(cat VERSION)" -ba python3-rockit-weatherlog.spec
	${RPMBUILD} --define "_version %(cat VERSION)" -ba rockit-weatherlog-lapalma.spec
	mv build/noarch/*.rpm .
	rm -rf build VERSION

install:
	@date --utc +%Y%m%d%H%M%S > VERSION
	@python3 -m build --outdir .
	@sudo pip3 install rockit.weatherlog-$$(cat VERSION)-py3-none-any.whl
	@rm VERSION
	@sudo cp update-weather-database update-weather-json /usr/bin/
	@sudo cp update-weather.service /etc/systemd/system/
	@sudo mkdir /etc/weatherlog
	@echo ""
	@echo "Installation complete."
	@echo "Now copy the relevant json config file to /etc/weatherlog/"

install-lapalma:
	@date --utc +%Y%m%d%H%M%S > VERSION
	@python3 -m build --outdir .
	@sudo pip3 install rockit.weatherlog-$$(cat VERSION)-py3-none-any.whl
	@rm VERSION
	@sudo cp update-weather-database update-weather-json /usr/bin/
	@sudo cp update-environment-database.service update-infrastructure-database.service /etc/systemd/system/
	@-sudo mkdir /etc/weatherlog
	@sudo cp lapalma_environment.json lapalma_infrastructure.json /etc/weatherlog/
	@echo ""
	@echo "Installation complete."
