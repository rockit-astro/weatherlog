-- Template for creating a fresh sqlite database for the Warwick Windmill Hill Observatory

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
CREATE DATABASE IF NOT EXISTS `ops` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ops`;

CREATE TABLE weather_sensors (
    id TINYINT unsigned NOT NULL AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    type VARCHAR(64) NOT NULL,
    label VARCHAR(64) NOT NULL,
    color CHAR(7) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE weather_data (
    bin INTEGER,
    sensor_id TINYINT unsigned,
    utc BIGINT,
    value FLOAT,
    last_updated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (bin, sensor_id),
    FOREIGN KEY (sensor_id) REFERENCES weather_sensors(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO weather_sensors (name, type, label, color) VALUES
    ('onemetre_external_temperature', 'external_temperature', 'W1m', '#009DDC'),
    ('onemetre_external_humidity', 'external_humidity', 'W1m', '#009DDC'),
    ('onemetre_wind_speed', 'wind', 'W1m', '#009DDC'),
    ('onemetre_wind_direction', 'wind', 'W1m', '#009DDC'),
    ('onemetre_wind_gust', 'wind', 'W1m', '#009DDC'),
    ('onemetre_wind_lull', 'wind', 'W1m', '#009DDC'),
    ('onemetre_pressure', 'pressure', 'W1m', '#009DDC'),
    ('onemetre_accumulated_rain', 'vaisala_rain', 'W1m', '#009DDC'),
    ('onemetre_rain_intensity', 'vaisala_rain_intensity', 'W1m', '#009DDC'),
    ('onemetre_external_dew_point_delta', 'external_dewpt', 'W1m', '#009DDC'),
    ('onemetre_rain_unsafe', 'rain', 'W1m', '#009DDC'),

    ('goto_external_temperature', 'external_temperature', 'GOTO', '#22CC44'),
    ('goto_external_humidity', 'external_humidity', 'GOTO', '#22CC44'),
    ('goto_wind_speed', 'wind', 'GOTO', '#22CC44'),
    ('goto_wind_direction', 'wind', 'GOTO', '#22CC44'),
    ('goto_wind_gust', 'wind', 'GOTO', '#22CC44'),
    ('goto_wind_lull', 'wind', 'GOTO', '#22CC44'),
    ('goto_pressure', 'pressure', 'GOTO', '#22CC44'),
    ('goto_accumulated_rain', 'vaisala_rain', 'GOTO', '#22CC44'),
    ('goto_rain_intensity', 'vaisala_rain_intensity', 'GOTO', '#22CC44'),
    ('goto_external_dew_point_delta', 'external_dewpt', 'GOTO', '#22CC44'),

    ('halfmetre_external_temperature', 'external_temperature', '.5m', '#F26430'),
    ('halfmetre_external_humidity', 'external_humidity', '.5m', '#F26430'),
    ('halfmetre_wind_speed', 'wind', '.5m', '#F26430'),
    ('halfmetre_wind_direction', 'wind', '.5m', '#F26430'),
    ('halfmetre_wind_gust', 'wind', '.5m', '#F26430'),
    ('halfmetre_wind_lull', 'wind', '.5m', '#F26430'),
    ('halfmetre_pressure', 'pressure', '.5m', '#F26430'),
    ('halfmetre_accumulated_rain', 'vaisala_rain', '.5m', '#F26430'),
    ('halfmetre_rain_intensity', 'vaisala_rain_intensity', '.5m', '#F26430'),
    ('halfmetre_external_dew_point_delta', 'external_dewpt', '.5m', '#F26430'),
    ('halfmetre_rain_unsafe', 'rain', '.5m', '#F26430'),

    ('raw_sky_temperature', 'skytemp_raw', '.5m', '#F26430'),
    ('raw_sky_ambient', 'skytemp_raw', '.5m', '#F26430'),
    ('sky_temperature', 'skytemp', '.5m', '#F26430'),
    ('sky_brightness', 'brightness', '.5m', '#F26430'),

    ('onemetre_internal_temperature', 'internal_temperature', 'W1m', '#009DDC'),
    ('onemetre_internal_humidity', 'internal_humidity', 'W1m', '#009DDC'),

    ('clasp_internal_temperature', 'internal_temperature', 'CLASP', '#DE0D92'),
    ('clasp_internal_humidity', 'internal_humidity', 'CLASP', '#DE0D92'),

    ('superwasp_internal_temperature', 'internal_temperature', 'SWASP', '#9933FF'),
    ('superwasp_internal_humidity', 'internal_humidity', 'SWASP', '#9933FF'),

    ('goto1_internal_temperature', 'internal_temperature', 'GOTO1', '#22CC44'),
    ('goto1_internal_humidity', 'internal_humidity', 'GOTO1', '#22CC44'),

    ('goto2_internal_temperature', 'internal_temperature', 'GOTO2', '#FDE74C'),
    ('goto2_internal_humidity', 'internal_humidity', 'GOTO2', '#FDE74C'),

    ('halfmetre_internal_temperature', 'internal_temperature', '.5m', '#F26430'),
    ('halfmetre_internal_humidity', 'internal_humidity', '.5m', '#F26430'),

    ('comproom_internal_temperature', 'internal_temperature', 'COMP', '#FF6699'),
    ('comproom_internal_humidity', 'internal_humidity', 'COMP', '#FF6699'),

    ('tng_seeing', 'seeing', 'TNG', '#F26430'),
    ('robodimm_seeing', 'seeing', 'RoboDIMM', '#FDE74C'),

    ('onemetre_ups1_battery', 'ups_battery', 'W1m(1)', '#009DDC'),
    ('onemetre_ups2_battery', 'ups_battery', 'W1m(2)', '#009DDC'),
    ('onemetre_ups1_load', 'ups_load', 'W1m(1)', '#009DDC'),
    ('onemetre_ups2_load', 'ups_load', 'W1m(2)', '#009DDC'),

    ('clasp_ups1_battery', 'ups_battery', 'CLASP(1)', '#DE0D92'),
    ('clasp_ups2_battery', 'ups_battery', 'CLASP(2)', '#DE0D92'),
    ('clasp_ups1_load', 'ups_load', 'CLASP(1)', '#DE0D92'),
    ('clasp_ups2_load', 'ups_load', 'CLASP(2)', '#DE0D92'),

    ('goto1_ups1_battery', 'ups_battery', 'GOTO1(1)', '#22CC44'),
    ('goto1_ups2_battery', 'ups_battery', 'GOTO1(2)', '#22CC44'),
    ('goto1_ups1_load', 'ups_load', 'GOTO1(1)', '#22CC44'),
    ('goto1_ups2_load', 'ups_load', 'GOTO1(2)', '#22CC44'),

    ('goto2_ups1_battery', 'ups_battery', 'GOTO2(1)', '#FDE74C'),
    ('goto2_ups2_battery', 'ups_battery', 'GOTO2(2)', '#FDE74C'),
    ('goto2_ups1_load', 'ups_load', 'GOTO2(1)', '#FDE74C'),
    ('goto2_ups2_load', 'ups_load', 'GOTO2(2)', '#FDE74C'),

    ('halfmetre_ups1_battery', 'ups_battery', '.5m(1)', '#F26430'),
    ('halfmetre_ups2_battery', 'ups_battery', '.5m(2)', '#F26430'),
    ('halfmetre_ups1_load', 'ups_load', '.5m(1)', '#F26430'),
    ('halfmetre_ups2_load', 'ups_load', '.5m(2)', '#F26430'),
    ('halfmetre_roof_voltage', 'roof_battery', '.5m', '#F26430'),

    ('ping_ngtshead', 'external_ping', 'Warwick', '#FDE74C'),
    ('ping_google', 'external_ping', 'Google', '#009DDC'),
    ('ping_onemetre', 'internal_ping', 'W1m', '#009DDC'),
    ('ping_goto1', 'internal_ping', 'GOTO1', '#22CC44'),
    ('ping_clasp', 'internal_ping', 'CLASP', '#DE0D92'),
    ('ping_superwasp', 'internal_ping', 'SWASP', '#9933FF'),
    ('ping_wht', 'internal_ping', 'WHT', '#CC0000');
