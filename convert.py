
import sqlite3
from astropy.time import Time

db = sqlite3.connect('/var/www/dashboard/generated/weather.db')
values = []
with db:
    sensor_rows = db.execute('SELECT bin, measurement_id, date, value FROM weather_values').fetchall()
    for bin_idx, sensor_id, date, value in sensor_rows:
        if sensor_id >= 4:
            sensor_id += 1

        date = Time.strptime(date, '%Y-%m-%d %H:%M:%S')
        values.append((bin_idx, sensor_id, int(date.unix), value))

db2 = sqlite3.connect('weather.db')

with db2:
    db2.executemany('REPLACE INTO weather_data (bin, sensor_id, utc, value) VALUES (?, ?, ?, ?)', values)