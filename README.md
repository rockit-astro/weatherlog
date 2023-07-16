## Weather database logger

`update-weather-database` is a command that queries the observatory environment sensors and updates the weather database.
`update-weather-json` is a command that exports cached json files for use by the observatory dashboard.

They run as a timed system service  every 30 seconds.

### Software Setup (La Palma)

After installing `rockit-weatherlog`, the `update-weather` service must be enabled using:
```
sudo systemctl enable --now update-weather
```

The script requires a MySQL/MariaDB or sqlite database.

After installing `mariadb` configure the default options by running:
```
sudo mysql_secure_installation
```

If this gives an error "Cannot connect to local MySQL server through socket" then you may need to start the database service:
```
sudo systemctl enable --now mariadb
```

Set a root password, remove anonymous accounts, disable remote root login and test database.

Log in as root (`mysql -u root -p`) and the run the following to create the ops user and tables by running the commands
from `lapalma.sql`.

If you want to export / backup the database you must add the `--skip-tz-utc` argument to `mysqldump` to prevent it from breaking timestamps!
