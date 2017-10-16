## La Palma weather database updater [![Travis CI build status](https://travis-ci.org/warwick-one-metre/weatherlogd.svg?branch=master)](https://travis-ci.org/warwick-one-metre/weatherlogd)

Part of the observatory software for the Warwick La Palma telescopes.

`update-weather-database` is a command that queries the observatory environment sensors and updates the weather database for use by the [web dashboard](https://github.com/warwick-one-metre/dashboard).
It is installed as a timed system service that runs every 30 seconds.

See [Software Infrastructure](https://github.com/warwick-one-metre/docs/wiki/Software-Infrastructure) for an overview of the W1m software architecture and instructions for developing and deploying the code.

### Software Setup

After installing `observatory-weather-database-updater`, the `update-weather-database.timer` must be enabled using:
```
sudo systemctl enable update-weather-database.timer
```

The service will automatically start on system boot, or you can start it immediately using:
```
sudo systemctl start update-weather-database.timer
```

The script requires a MySQL or MariaDB database to be hosted on the same machine.
It will connect with the user account `ops` (no password) and write to the database `ops`.
The database can be created using:
```sql
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
CREATE DATABASE IF NOT EXISTS `ops` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ops`;

CREATE TABLE `dashboard_config` (
  `id` int(11) NOT NULL,
  `keyname` text NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `obslog` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` enum('error','warning','info') NOT NULL,
  `source` text NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_goto_roomalert` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `internal_temp` float NOT NULL,
  `internal_humidity` float NOT NULL,
  `roomalert_temp` float NOT NULL,
  `roomalert_humidity` float NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_goto_ups` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `main_ups_status` tinyint(2) NOT NULL,
  `main_ups_battery_remaining` tinyint(3) UNSIGNED NOT NULL,
  `main_ups_load` tinyint(3) UNSIGNED NOT NULL,
  `dome_ups_status` tinyint(2) NOT NULL,
  `dome_ups_battery_remaining` tinyint(3) UNSIGNED NOT NULL,
  `dome_ups_load` tinyint(3) UNSIGNED NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_network` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ngtshead` float NOT NULL DEFAULT '-1',
  `google` float NOT NULL DEFAULT '-1',
  `onemetre` float NOT NULL DEFAULT '-1',
  `goto` float NOT NULL DEFAULT '-1',
  `nites` float NOT NULL DEFAULT '-1',
  `swasp` float NOT NULL DEFAULT '-1',
  `swasp_gateway` float NOT NULL DEFAULT '-1',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_nites_roomalert` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `internal_temperature` float NOT NULL,
  `internal_humidity` float NOT NULL,
  `rack_temperature` float NOT NULL,
  `rack_humidity` float NOT NULL,
  `security_system` tinyint(1) NOT NULL,
  `mains_power` tinyint(1) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_onemetre_raindetector` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unsafe_boards` tinyint(1) NOT NULL,
  `total_boards` tinyint(1) NOT NULL,
  `port1` tinyint(1) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_onemetre_roomalert` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `internal_temp` float NOT NULL,
  `internal_humidity` float NOT NULL,
  `roomalert_temp` float NOT NULL,
  `roomalert_humidity` float NOT NULL,
  `truss_temp` float NOT NULL,
  `hatch_closed` tinyint(1) NOT NULL,
  `trap_closed` tinyint(1) NOT NULL,
  `security_system_safe` tinyint(1) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_onemetre_ups` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `main_ups_status` tinyint(2) NOT NULL,
  `main_ups_battery_remaining` tinyint(3) UNSIGNED NOT NULL,
  `main_ups_load` tinyint(3) UNSIGNED NOT NULL,
  `dome_ups_status` tinyint(2) NOT NULL,
  `dome_ups_battery_remaining` tinyint(3) UNSIGNED NOT NULL,
  `dome_ups_load` tinyint(3) UNSIGNED NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_onemetre_vaisala` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float NOT NULL,
  `temperature_valid` tinyint(1) NOT NULL,
  `relative_humidity` float NOT NULL,
  `relative_humidity_valid` tinyint(1) NOT NULL,
  `wind_direction` float NOT NULL,
  `wind_direction_valid` tinyint(1) NOT NULL,
  `wind_speed` float NOT NULL,
  `wind_speed_valid` tinyint(1) NOT NULL,
  `pressure` float NOT NULL,
  `pressure_valid` tinyint(1) NOT NULL,
  `accumulated_rain` float NOT NULL,
  `accumulated_rain_valid` tinyint(1) NOT NULL,
  `rain_intensity` float NOT NULL,
  `rain_intensity_valid` tinyint(1) NOT NULL,
  `dew_point_delta` float NOT NULL,
  `dew_point_delta_valid` tinyint(1) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weather_superwasp` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ext_temperature` float NOT NULL,
  `ext_humidity` float NOT NULL,
  `wind_speed` float NOT NULL,
  `wind_direction` float NOT NULL,
  `sky_temp` float NOT NULL,
  `pressure` float NOT NULL,
  `dew_point_delta` float NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `dashboard_config`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `obslog`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `weather_goto_roomalert`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_goto_ups`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_network`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_nites_roomalert`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_onemetre_raindetector`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_onemetre_roomalert`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_onemetre_ups`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_onemetre_vaisala`
  ADD PRIMARY KEY (`bin`);

ALTER TABLE `weather_superwasp`
  ADD PRIMARY KEY (`bin`);


ALTER TABLE `dashboard_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `obslog`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
```
