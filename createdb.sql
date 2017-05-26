
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
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `internal_temp` FLOAT NOT NULL,
  `internal_humidity` FLOAT NOT NULL,
  `roomalert_temp` FLOAT NOT NULL,
  `roomalert_humidity` FLOAT NOT NULL,
  `truss_temp` FLOAT NOT NULL,
  `hatch_closed` BOOLEAN NOT NULL,
  `trap_closed` BOOLEAN NOT NULL,
  `security_system_safe` BOOLEAN NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `weather_nites_roomalert` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `internal_temperature` FLOAT NOT NULL,
  `internal_humidity` FLOAT NOT NULL,
  `rack_temperature` FLOAT NOT NULL,
  `rack_humidity` FLOAT NOT NULL,
  `security_system` BOOLEAN NOT NULL,
  `mains_power` BOOLEAN NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `weather_goto_roomalert` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `internal_temp` FLOAT NOT NULL,
  `internal_humidity` FLOAT NOT NULL,
  `roomalert_temp` FLOAT NOT NULL,
  `roomalert_humidity` FLOAT NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `weather_onemetre_raindetector` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `unsafe_boards` TINYINT(1) NOT NULL,
  `total_boards` TINYINT(1) NOT NULL,
  `port1` TINYINT(1) NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `weather_onemetre_ups` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `main_ups_status` TINYINT(2) NOT NULL,
  `main_ups_battery_remaining` TINYINT UNSIGNED NOT NULL,
  `main_ups_load` TINYINT UNSIGNED NOT NULL,
  `dome_ups_status` TINYINT(2) NOT NULL,
  `dome_ups_battery_remaining` TINYINT UNSIGNED NOT NULL,
  `dome_ups_load` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `weather_superwasp` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `ext_temperature` FLOAT NOT NULL,
  `ext_humidity` FLOAT NOT NULL,
  `wind_speed` FLOAT NOT NULL,
  `wind_direction` FLOAT NOT NULL,
  `sky_temp` FLOAT NOT NULL,
  `pressure` FLOAT NOT NULL,
  `dew_point_delta` FLOAT NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `weather_network` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `ngtshead` FLOAT NOT NULL,
  `google` FLOAT NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

