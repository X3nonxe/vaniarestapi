import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/providers/route_service_provider.dart';
import 'package:vaniarestapi/config/cors.dart';

import 'auth.dart';

Map<String, dynamic> config = {
  'name': env('APP_NAME'),
  'url': env('APP_URL'),
  'timezone': '',
  'websocket': false,
  'isolate': false,
  'isolateCount': 4,
  'cors': cors,
  // 'database': null, //databaseConfig, Put Your Databse config here
  // 'cache': CacheConfig(),
  'auth': authConfig,
  // 'storage': FileStorageConfig(),
  'mail': {
    'driver': env('MAIL_MAILER'),
    'host': env('MAIL_HOST'),
    'port': env('MAIL_PORT'),
    'username': env('MAIL_USERNAME'),
    'password': env('MAIL_PASSWORD'),
    'encryption': env('MAIL_ENCRYPTION'),
    'from_name': env('MAIL_FROM_NAME'),
    'from_address': env('MAIL_FROM_ADDRESS'),
  },
  'providers': <ServiceProvider>[
    RouteServiceProvider(),
  ],
};