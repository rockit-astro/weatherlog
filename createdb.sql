
CREATE TABLE IF NOT EXISTS `weather_onemetre_vaisala` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `temperature` FLOAT NOT NULL,
  `temperature_valid` BOOLEAN NOT NULL,
  `relative_humidity` FLOAT NOT NULL,
  `relative_humidity_valid` BOOLEAN NOT NULL,
  `wind_direction` FLOAT NOT NULL,
  `wind_direction_valid` BOOLEAN NOT NULL,
  `wind_speed` FLOAT NOT NULL,
  `wind_speed_valid` BOOLEAN NOT NULL,
  `pressure` FLOAT NOT NULL,
  `pressure_valid` BOOLEAN NOT NULL,
  `accumulated_rain` FLOAT NOT NULL,
  `accumulated_rain_valid` BOOLEAN NOT NULL,
  `dew_point_delta` FLOAT NOT NULL,
  `dew_point_delta_valid` BOOLEAN NOT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB;

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

CREATE TABLE IF NOT EXISTS `weather_onemetre_raindetector` (
  `bin` int(10) unsigned NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `unsafe_boards` CHAR NOT NULL,
  `total_boards` CHAR NOT NULL,
  `port1` CHAR NOT NULL,
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

