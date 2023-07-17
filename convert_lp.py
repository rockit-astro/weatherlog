import pymysql
from astropy.time import Time

BIN_START = 0

db = pymysql.connect(host='localhost',
                     db='ops',
                     user='ops',
                     autocommit=True,
                     cursorclass=pymysql.cursors.DictCursor)

with db.cursor() as cur:
    cur.execute('SELECT id, name FROM weather_sensors')
    sensor_name_id_map = {r['name']: r['id'] for r in cur.fetchall()}

    values = []
    if False:
        print('Querying onemetre_vaisala...')
        cur.execute('SELECT * FROM weather_onemetre_vaisala WHERE bin > %s', [BIN_START])
        fields = {
            'temperature': 'onemetre_external_temperature',
            'relative_humidity': 'onemetre_external_humidity',
            'wind_speed': 'onemetre_wind_speed',
            'wind_direction': 'onemetre_wind_direction',
            'wind_gust': 'onemetre_wind_gust',
            'wind_lull': 'onemetre_wind_lull',
            'pressure': 'onemetre_pressure',
            'accumulated_rain': 'onemetre_accumulated_rain',
            'rain_intensity': 'onemetre_rain_intensity',
            'dew_point_delta': 'onemetre_external_dew_point_delta',
        }

        count = 0
        for row in cur.fetchall():
            count += 1
            if count % 1000 == 0:
                print(f'Extracting data ({count})')
            date = int(Time(row['date']).unix)
            for column, sensor in fields.items():
                if row[column + '_valid']:
                    values.append((row['bin'], sensor_name_id_map[sensor], date, row[column]))

    if True:
        print('Querying weather_onemetre_raindetector...')
        cur.execute('SELECT * FROM weather_onemetre_raindetector WHERE bin > %s', [BIN_START])
        fields = {
            'unsafe_boards': 'onemetre_rain_unsafe'
        }

        count = 0
        for row in cur.fetchall():
            count += 1
            if count % 1000 == 0:
                print(f'Extracting data ({count})')
            date = int(Time(row['date']).unix)
            for column, sensor in fields.items():
                values.append((row['bin'], sensor_name_id_map[sensor], date, row[column]))

    if False:
        print('Querying weather_tng_seeing...')
        cur.execute('SELECT * FROM weather_tng_seeing WHERE bin > %s', [BIN_START])
        fields = {
            'seeing': 'tng_seeing'
        }

        count = 0
        for row in cur.fetchall():
            count += 1
            if count % 1000 == 0:
                print(f'Extracting data ({count})')
            date = int(Time(row['date']).unix)
            for column, sensor in fields.items():
                if row[column] != -1:
                    values.append((row['bin'], sensor_name_id_map[sensor], date, row[column]))

with db.cursor() as cur:
    # Insert in chunks of 1000
    for i in range(0, len(values), 1000):
        print(f'Inserting data ({i})')
        cur.executemany(
            'REPLACE INTO weather_data (bin, sensor_id, utc, value) VALUES (%s, %s, %s, %s);',
            values[i:i+1000])
