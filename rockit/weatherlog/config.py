#
# This file is part of the Robotic Observatory Control Kit (rockit)
#
# rockit is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# rockit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with rockit.  If not, see <http://www.gnu.org/licenses/>.

"""Helper function to validate and parse the json config file"""

import json
from rockit.common import daemons, validation

CONFIG_SCHEMA = {
    'type': 'object',
    'additionalProperties': False,
    'required': [
        'log_name', 'bin_epoch', 'bin_length', 'watchers'
    ],
    'properties': {
        'log_name': {
            'type': 'string'
        },
        'database': {
            'type': 'object',
            'additionalProperties': False,
            'required': ['type'],
            'properties': {
                'type': {
                    'type': 'string',
                    'enum': ['sqlite', 'mysql']
                },
                'path': {
                    'type': 'string'
                },
                'host': {
                    'type': 'string'
                },
                'db': {
                    'type': 'string'
                },
                'user': {
                    'type': 'string'
                },
            },
            'anyOf': [
                {
                    'properties': {
                        'type': {
                            'enum': ['sqlite']
                        }
                    },
                    'required': ['path']
                },
                {
                    'properties': {
                        'type': {
                            'enum': ['mysql']
                        }
                    },
                    'required': ['host', 'db', 'user']
                }
            ]
        },
        'bin_epoch': {
            'type': 'integer'
        },
        'bin_length': {
            'type': 'integer',
            'minimum': 1
        },
        'dashboard': {
            'type': 'object',
            'additionalProperties': False,
            'required': ['output_root', 'start_date', 'latest_range', 'start_hour', 'types'],
            'properties': {
                'output_root': {
                    'type': 'string'
                },
                'start_date': {
                    'type': 'string'
                },
                'latest_range': {
                    'type': 'number'
                },
                'start_hour': {
                    'type': 'number',
                    'minimum': 0,
                    'maximum': 24
                },
                'types': {
                    'type': 'array',
                    'items': {
                        'type': 'string'
                    }
                },
                'wind_types': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'additionalProperties': False,
                        'required': ['scatter_type', 'speed_type', 'speed_sensor', 'direction_sensor',
                                     'gust_sensor', 'lull_sensor'],
                        'properties': {
                            'scatter_type': {
                                'type': 'string'
                            },
                            'speed_type': {
                                'type': 'string'
                            },
                            'speed_sensor': {
                                'type': 'string'
                            },
                            'direction_sensor': {
                                'type': 'string'
                            },
                            'gust_sensor': {
                                'type': 'string'
                            },
                            'lull_sensor': {
                                'type': 'string'
                            }
                        }
                    }
                }
            }
        },
        'watchers': {
            'type': 'object',
            'additionalProperties': {
                'type': 'object',
                'additionalProperties': False,
                'required': ['daemon', 'method', 'fields'],
                'properties': {
                    'daemon': {
                        'type': 'string',
                        'daemon_name': True
                    },
                    'method': {
                        'type': 'string'
                    },
                    'fields': {
                        'type': 'object',
                        'additionalProperties': {
                            'type': 'object',
                            'additionalProperties': False,
                            'required': ['sensor'],
                            'properties': {
                                'sensor': {
                                    'type': 'string'
                                },
                                'date_field': {
                                    'type': 'string'
                                },
                                'filter_invalid': {
                                    'type': 'boolean'
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


class Config:
    """Daemon configuration parsed from a json file"""
    def __init__(self, config_filename):
        # Will throw on file not found or invalid json
        with open(config_filename, 'r', encoding='utf-8') as config_file:
            config_json = json.load(config_file)

        # Will throw on schema violations
        validators = {
            'daemon_name': validation.daemon_name_validator,
        }

        validation.validate_config(config_json, CONFIG_SCHEMA, validators)

        self.log_name = config_json['log_name']
        self.bin_epoch = config_json['bin_epoch']
        self.bin_length = config_json['bin_length']
        self.database = config_json['database']
        self.dashboard = config_json.get('dashboard', None)
        self.watchers = config_json['watchers']
        for k in self.watchers.keys():
            self.watchers[k]['daemon'] = getattr(daemons, self.watchers[k]['daemon'])
