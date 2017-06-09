
CREATE TABLE IF NOT EXISTS `weather_onemetre_vaisala` (
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

CREATE TABLE IF NOT EXISTS `weather_onemetre_roomalert` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `internal_temp` float NOT NULL,
  `internal_humidity` float NOT NULL,
  `roomalert_temp` float NOT NULL,
  `roomalert_humidity` float NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weather_nites_roomalert` (
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

CREATE TABLE IF NOT EXISTS  `weather_goto_roomalert` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `internal_temp` float NOT NULL,
  `internal_humidity` float NOT NULL,
  `roomalert_temp` float NOT NULL,
  `roomalert_humidity` float NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weather_onemetre_raindetector` (
  `bin` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unsafe_boards` tinyint(1) NOT NULL,
  `total_boards` tinyint(1) NOT NULL,
  `port1` tinyint(1) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `weather_onemetre_ups` (
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

CREATE TABLE IF NOT EXISTS `weather_goto_ups` (
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

CREATE TABLE IF NOT EXISTS `weather_superwasp` (
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

CREATE TABLE IF NOT EXISTS `weather_network` (
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

