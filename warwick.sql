-- Template for creating a fresh sqlite database for the Warwick Windmill Hill Observatory

CREATE TABLE weather_sensors (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type TEXT NOT NULL,
    label TEXT NOT NULL,
    color TEXT NOT NULL);

CREATE TABLE weather_data (
    bin INTEGER,
    sensor_id INTEGER,
    utc INTEGER,
    value REAL,
    last_updated INTEGER DEFAULT (strftime('%s', 'now')),
    PRIMARY KEY (bin, sensor_id),
    FOREIGN KEY (sensor_id) REFERENCES weather_sensors (id));

INSERT INTO weather_sensors (name, type, label, color) VALUES
    ('external_temperature', 'temperature', 'Terrace', '#009DDC'),
    ('external_humidity', 'humidity', 'Terrace', '#009DDC'),
    ('wind_speed', 'wind_raw', 'Terrace', '#009DDC'),
    ('wind_direction', 'wind_raw', 'Terrace', '#009DDC'),
    ('wind_gust', 'wind_raw', 'Terrace', '#009DDC'),
    ('wind_lull', 'wind_raw', 'Terrace', '#009DDC'),
    ('pressure', 'pressure', 'Terrace', '#009DDC'),
    ('accumulated_rain', 'rain_vaisala', 'Terrace', '#009DDC'),
    ('rain_intensity', 'rain_vaisala', 'Terrace', '#009DDC'),
    ('rg11_unsafe', 'rain', 'Terrace', '#009DDC'),
    ('dew_point_delta', 'dewpt', 'Terrace', '#009DDC'),
    ('internal_temperature', 'temperature', 'Big Dome', '#22cc44'),
    ('internal_humidity', 'humidity', 'Big Dome', '#22cc44'),
    ('internal_dew_point_delta', 'dewpt', 'Big Dome', '#22cc44'),
    ('heliostat_internal_temperature', 'temperature', 'Small Dome', '#F26430'),
    ('heliostat_internal_humidity', 'humidity', 'Small Dome', '#F26430'),
    ('heliostat_dew_point_delta', 'dewpt', 'Small Dome', '#F26430'),
    ('raw_sky_temperature', 'skytemp_raw', 'Terrace', '#009DDC'),
    ('raw_sky_ambient', 'skytemp_raw', 'Terrace', '#009DDC'),
    ('sky_temperature', 'skytemp', 'Terrace', '#009DDC'),
    ('sky_brightness', 'brightness', 'Terrace', '#009DDC');
